require 'rake'

namespace :organization do
  require 'authentication'
  include Authentication

  desc 'Imports organizations from a CSV file'
  task :import_csv, [:csv_file] => :environment do |t, args|
    unless args[:csv_file]
      puts "You must specify a CSV file to import."
      exit
    end

    # Parse the given CSV file for organization information

    require 'csv'

    begin
      csv_text = File.read(args[:csv_file])
    rescue
      puts "Unable to read file #{args[:csv_file]}."
      exit
    end

    # We'll grab the parent organization codes while parsing the CSV but will need to
    # analyze them only after the CSV parsing is complete.
    parental_codes = {}

    row_count = 0
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      row_count = row_count + 1

      if row["HOME_DEPARTMENT_NUM"].nil?
        puts "Skipping a row with no department code:"
        pp row
        next
      end

      # Any organization that reports to itself is expired or invalid
      next if (row["CHART_NUM"] + row["ORG_ID"]) == (row["RPTS_TO_ORG_CHART_NUM"] + row["RPTS_TO_ORG_ID"])

      organization = Organization.find_or_initialize_by_dept_code(row["HOME_DEPARTMENT_NUM"])

      # Save the basic organization information. Maybe already be set.
      organization.name = row["HOME_DEPARTMENT_PRIMARY_NAME"]
      organization.dept_code = row["HOME_DEPARTMENT_NUM"]
      organization.save!

      # Remember the parental code for later analysis
      parental_codes[organization.dept_code] = [] unless parental_codes[organization.dept_code]
      parental_code = row["RPTS_TO_ORG_CHART_NUM"] + row["RPTS_TO_ORG_ID"]
      parental_codes[organization.dept_code] << parental_code unless parental_codes[organization.dept_code].include?(parental_code)

      # Add this organization_code to the list of this organization's valid codes
      OrganizationOrgId.create!({ org_id: row["CHART_NUM"] + row["ORG_ID"], organization_id: organization.id })
    end

    puts "Finished importing from CSV. Read #{row_count} rows to create #{Organization.count} organizations."
    puts 'Parsing organizations to determine parental relationships ...'

    count = 0
    with_multiple = 0
    # Now that we have all organizations, go through and attempt to build the parent relationships
    Organization.all.each do |organization|
      count = count + 1

      puts "Parsing #{organization.id} #{organization.dept_code} #{organization.name}"

      # Find their parent organization ID by dept code, creating one if necessary
      parent_org_ids = parental_codes[organization.dept_code]

      puts "\tClaims the following parental org IDs: #{parent_org_ids}"

      parental_orgs = []
      parent_org_ids.each do |parent_org_id|
        parent_organization = Organization.includes(:org_ids).where(:organization_org_ids => { :org_id => parent_org_id })
        if parent_organization.length > 1
          puts "\tMultiple parent organizations found with org_id #{parent_org_id}! This should not happen!"
          exit
        else
          #puts "\tNo parent organization could be found."
        end

        parent_organization = parent_organization.first

        unless parent_organization
          puts "\tWe need to construct a parent ..."
          # Sadly if this is the case, we know very little about the organization ...
          parent_organization = Organization.create!
          OrganizationOrgId.create!( org_id: parent_org_id, organization_id: parent_organization.id )
        end

        if parent_organization.id != organization.id
          parental_orgs << parent_organization unless parental_orgs.include?(parent_organization)
        end
      end

      # Display some debug about whether we found multiple, valid parents
      if parental_orgs.length > 1
        puts "\tHas multiple parental orgs:"
        with_multiple += 1
        parental_orgs.each do |org|
          if org
            puts "\t\t#{org.dept_code} #{org.name} (matched on: #{ org.org_ids.select{ |org_id| parent_org_ids.include?(org_id.org_id) }.map{ |org_id| org_id.org_id } })"
          else
            puts ' -- Org is empty?'
            exit
          end
        end
      else
        puts "\tHas single or not parental org: #{parental_orgs.length}"
      end

      parental_orgs.each do |parental_org|
        puts "\tAssigning parental_org #{parental_org.id} #{parental_org.name} ..."
        begin
          organization.parent_organizations << parental_org
        rescue Exception => e
          puts "Not adding #{parental_org.name} as a parent of #{organization.name} because it would form a loop in the org tree. Error: #{e}."
        end
      end
    end

    puts "Went through #{count} organizations. #{with_multiple} had multiple parents."
  end

  # As part of the migration from Groups with codes (to signify OUs) to a proper
  # Organization model we need to ensure every Group with a code is accounted for.
  # This task (temporarily needed) looks for Groups which have no Organization
  # equivalent. Run organization:import_csv first.
  desc 'Check for missing organizations'
  task check_groups: :environment do
    Group.where('code is not null').each do |ou_group|
      organization = Organization.find_by_dept_code(ou_group.code)

      if organization
        puts "Group (#{ou_group.name}) has a matching Organization (#{organization.name})"
      else
        puts "Group (#{ou_group.name}) has no matching organization"
      end
    end
  end

  # Converts OU-Groups into Organizations.
  # This task is only temporarily needed. Run organization:import_csv first.
  desc 'Check for missing organizations'
  task migrate_groups: :environment do
    Group.where('code is not null').each do |ou_group|
      organization = Organization.find_by_dept_code(ou_group.code)

      puts "Group (#{ou_group.name}):"

      if organization
        group_rule_counts = {}
        puts "\tHas a matching Organization (#{organization.name}). Converting ..."

        # Convert any "OU is..." groups which use this group into an "Organization is..." rule
        GroupRule.where(column: 'ou', value: ou_group.name).each do |group_rule|
          group_rule_counts[group_rule.id] = group_rule.results.length
          puts "\t\tGroupRule before: #{group_rule.column} #{group_rule.condition} #{group_rule.value} has #{group_rule.results.length} results ..."
          puts "\t\tGroupRule contains:"
          group_rule.results.each do |result|
            puts "\t\t\t#{result.entity.id} #{result.entity.name} (#{result.entity.type})"
          end
        end

        # Add members from the OU-Group to the Organization
        ou_group.members.each do |member|
          puts "\t\tAdding member #{member.name} (#{member.type}) to Organization"
          begin
            organization.entities << member
          rescue ActiveRecord::RecordInvalid => e
            puts "\t\tCould not add member to organization: #{e}. Ignoring ..."
          end
        end

        # Remove those members from the OU-Group
        ou_group.memberships.each do |membership|
          puts "\t\tDestroying membership #{membership.id}"
          membership.destroy
        end

        # Create a new rule within that group for "Department is..." to restore those members
        # via calculation
        puts "\t\t"
        gr = GroupRule.create!( column: "organization", condition: "is", value: organization.name, group_id: ou_group.id )

        puts "\tConverting group rules using this group ..."
        # Convert any "OU is..." groups which use this group into an "Organization is..." rule
        GroupRule.where(column: 'ou', value: ou_group.name).each do |group_rule|
          group_rule.column = "organization"
          group_rule.value = organization.name # The organization names tend to be slightly different.
          group_rule.save!
          puts "\t\tGroupRule after: #{group_rule.column} #{group_rule.condition} #{group_rule.value} has #{group_rule.results.length} results"
          if group_rule_counts[group_rule.id] != group_rule.results.length
            puts "\t\tGroupRule result count HAS changed (#{group_rule_counts[group_rule.id]} before, #{group_rule.results.length} after)."
          else
            puts "\t\tGroupRule result count HAS NOT changed."
          end
          puts "\t\tGroupRule contains:"
          group_rule.results.each do |result|
            puts "\t\t\t#{result.entity.id} #{result.entity.name} (#{result.entity.type})"
          end
        end
      else
        puts "\tHas no matching organization, will leave it alone ..."

        if GroupRule.where(column: 'ou', value: ou_group.name).length > 0
          puts "\t\tBut this non-matching group has a group rule. This is unsupported in the migration!"
          exit
        end
      end
    end

    GroupRule.where(column: 'ou').each do |rule|
      puts "WARNING: A rule exists for 'ou' #{rule.condition} '#{rule.value}'. If this is a group that should have been converted, the name likely couldn't be matched exactly and you will need to migrate the rule yourself. It is attached to group #{rule.group.id}, #{rule.group.name}."
    end

    puts "Group rules were generated using 'Organization is'. This should be converted to 'Department is' soon."
  end

  # The UCD data is bad and contains some parent/child loops. Fortunately, they represent
  # invalid relationships so we'll simply remove them if found.
  desc 'Remove any two-way parent/child relationships'
  task remove_parental_loops: :environment do
    loop_count = 0
    Organization.all.each do |organization|
      organization.parent_organizations.each do |parent|
        if parent.parent_organizations.include? organization
          loop_count = loop_count + 1
          puts "Removing child #{organization.name} from parent #{parent.name} because it is a loop ..."
          parent.parent_organizations.destroy(organization)
        end
      end
    end

    puts "Destroyed #{loop_count} loops."
  end

  desc 'List any organization with more than one parent'
  task :list_multiple_parents => :environment do
    Organization.all.each do |organization|
      puts "#{organization.name} (#{organization.parent_organizations.length})" if organization.parent_organizations.length > 1
    end
  end

  # Verifies all nameless organizations are top-level and combines them into one top-level
  # node. It then attaches any named top-level organizations as children of that node,
  # leaving the org tree with a single top-level parent node.
  desc 'Adds a top-level node containing all the parentless-nodes'
  task :add_top_level_node => :environment do
    # Find nameless organizations and verify they are all top-level
    nameless_organizations = []
    Organization.all.each do |organization|
      if organization.name.nil?
        if organization.parent_organizations.length > 0
          puts "Found a nameless organization which is not top-level: #{organization.name} (#{organization.id}). This is unexpected. Aborting."
          exit
        end
        unless organization.dept_code.nil?
          puts "Found a nameless organization with a dept code: #{organization.name} (#{organization.id}). This is unexpected. Aborting."
          exit
        end
        if organization.entities.length > 0
          puts "Found a nameless organization with assigned entities: #{organization.name} (#{organization.id}). This is unexpected. Aborting."
          exit
        end

        puts "Found nameless organization: #{organization.id}"
        nameless_organizations << organization
      end
    end

    # Combine them into a single top-level organization (we do not have to worry about entities nor dept code due to the checks above)
    top_level = Organization.create!({name: "UC Davis"})
    puts "Created top-level organization 'UC Davis' (#{top_level.id})"

    nameless_organizations.each do |nameless_org|
      ## Assign all the org IDs of the nameless organizations to top-level
      nameless_org.org_ids.each do |nameless_org_id|
        puts "\tAssigning nameless org (#{nameless_org.id}) org_id of #{nameless_org_id.org_id} to the top-level ..."

        org_id = nameless_org_id.org_id

        # We need to delete the org_id before re-assigning it as they must remain unique in the database
        nameless_org_id.destroy

        OrganizationOrgId.create!({ org_id: org_id, organization_id: top_level.id })
        puts "\tdone."
      end

      ## Assign all the child organizations of the nameless organizations to the top-level
      nameless_org.child_organizations.each do |child_org|
        if top_level.child_organizations.include?(child_org)
          puts "\tWould assign nameless org (#{nameless_org.id}) child_org of #{child_org.name} (#{child_org.id}) to the top-level but it is already there. Skipping."
        else
          puts "\tAssigning nameless org (#{nameless_org.id}) child_org of #{child_org.name} (#{child_org.id}) to the top-level ..."
          top_level.child_organizations << child_org
          puts "\tdone."
        end
      end

      ## Finally, remove the nameless_org
      puts "\tRemoving nameless org #{nameless_org.id} ..."
      nameless_org.destroy
      puts "\tdone."
    end

    # Find the remaining orphaned orgs and assign them to the new top-level; they should all have names
    Organization.all.each do |organization|
      unless organization.id == top_level.id # don't want to add the new top-level!
        if organization.parent_organizations.empty?
          if organization.name.blank?
            puts 'Found a blank organization after having combined them all. This should not happen. Continuing ...'
          end
          puts "Adding #{organization.name} (#{organization.id}) to the top-level ..."
          top_level.child_organizations << organization
        end
      end
    end

    # Verify that there is only one top-level org and print out some stats
    top_orgs = Organization.includes(:parent_org_ids).where(:organization_parent_ids => { id: nil })
    if top_orgs.length != 1
      puts "Uh oh! Looks like there's more than one top-level org even though we're done. There are #{top_orgs.length}."
      exit
    end

    top_org = top_orgs[0]

    puts "New top-level org #{top_org.name} (#{top_org.id}) has #{top_org.org_ids.length} org IDs and #{top_org.child_organizations.length} children."
  end

  desc 'Removes a top-level node if one exists'
  task remove_top_level_node: :environment do
    orphaned_organizations = []

    Organization.all.each do |organization|
      orphaned_organizations << organization if organization.parent_organizations.empty?
    end

    if orphaned_organizations.length != 1
      puts "Cannot proceed. There are #{orphaned_organizations.length} top-level organizations, not 1."
      exit
    end

    top_level = orphaned_organizations[0]

    puts "Detaching #{top_level.child_organizations.length} organizations from the top-level node (#{top_level.name}):"
    top_level.child_organizations.each do |org|
      puts "\tDetaching #{org.name} (#{org.id})"
      top_level.child_organizations.destroy(org)
    end

    puts "Destroying the top-level node #{top_level.name} (#{top_level.id}) ..."
    top_level.destroy
  end

  desc 'List any organizations who have a parent which is also a grandparent'
  task :list_dubious_parentage, [:options] => :environment do |t, args|
    remove = args[:options] == 'remove'

    Organization.all.each do |organization|
      if organization.parent_organizations.length > 1
        parent_ids = organization.parent_organizations.map(&:id)
        organization.parent_organizations.each do |parent|
          grandparent_ids = parent.parent_organizations.map(&:id)
          intersections = parent_ids & grandparent_ids

          intersections.each do |i|
            puts "#{organization.name} (#{organization.id}) has #{Organization.find_by_id(i).name} (#{Organization.find_by_id(i).id}) as a parent but this is also a grandparent."
            if remove
              puts 'Removing ...'
              organization.parent_organizations.destroy(Organization.find_by_id(i))
            end
            puts 'Other parents:'
            parent_ids.each do |p|
              puts "\t#{Organization.find_by_id(p).name} (#{Organization.find_by_id(p).id})" unless intersections.include? p
            end
          end
        end
      end
    end
  end

  desc 'Drop all organizations'
  task drop: :environment do
    org_count = Organization.count

    Organization.destroy_all

    puts "#{org_count} organization(s) dropped."
  end

  desc 'Generate a GraphViz-compatible output to STDOUT'
  task graphviz: :environment do
    puts 'digraph unix {'
    puts "\tsize=\"6,6\";"
    puts "\tnode [color=lightblue2, style=filled];"

    Organization.all.each do |org|
      org.child_organizations.each do |child|
        puts "\t\"#{org.id}:#{org.name}\" -> \"#{child.id}:#{child.name}\";"
      end
    end

    puts '}'
  end

  desc 'Remove unused organizations'
  task remove_unused: :environment do
    Organization.all.each do |org|
      if org.child_org_ids.empty? && org.entities.empty? && org.managers.empty?
        puts "Removing unused orgazation (no children, no entities, no managers): #{org.name} ... "
        org.destroy
      elsif GroupRule.where(column: 'organization', value: org.name).empty? && org.child_org_ids.empty?
        puts "Removing unused orgazation (no children, no rules): #{org.name} ... "
        org.destroy
      end
    end
  end
end
