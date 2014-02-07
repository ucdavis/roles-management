require 'rake'

namespace :organization do
  desc 'Imports organizations from a CSV file'
  task :import_csv, [:csv_file] => :environment do |t, args|
    Authorization.ignore_access_control(true)

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
    puts "Parsing organizations to determine parental relationships ..."

    count = 0
    with_multiple = 0
    # Now that we have all organizations, go through and attempt to build the parent relationships
    Organization.all.each do |organization|
      count = count + 1
      
      # if count == 20
      #   exit
      # end

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
          OrganizationOrgId.create!({ org_id: parent_org_id, organization_id: parent_organization.id })
        end
        
        if parent_organization.id != organization.id
          parental_orgs << parent_organization unless parental_orgs.include?(parent_organization)
        end
      end
      
      # Display some debug about whether we found multiple, valid parents
      if parental_orgs.length > 1
        puts "\tHas multiple parental orgs:"
        with_multiple = with_multiple + 1
        parental_orgs.each do |org|
          if org
            puts "\t\t#{org.dept_code} #{org.name} (matched on: #{ org.org_ids.select{ |org_id| parent_org_ids.include?(org_id.org_id) }.map{ |org_id| org_id.org_id } })"
          else
            puts " -- Org is empty?"
            exit
          end
        end
      else
        puts "\tHas single or not parental org: #{parental_orgs.length}"
      end
      
      parental_orgs.each do |parental_org|
        puts "\tAssigning parental_org #{parental_org.id} #{parental_org.name} ..."
        organization.parent_organizations << parental_org
      end
    end
    
    puts "Went through #{count} organizations. #{with_multiple} had multiple parents."
    
    Authorization.ignore_access_control(false)
  end
  
  # As part of the migration from Groups with codes (to signify OUs) to a proper
  # Organization model we need to ensure every Group with a code is accounted for.
  # This task (temporarily needed) looks for Groups which have no Organization
  # equivalent. Run organization:import_csv first.
  desc 'Check for missing organizations'
  task :check_groups => :environment do
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
  task :migrate_groups => :environment do
    Authorization.ignore_access_control(true)
    
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
          organization.entities << member
        end
        
        # Remove those members from the OU-Group
        ou_group.memberships.each do |membership|
          membership.destroy
        end
        
        # Create a new rule within that group for "Department is..." to restore those members
        # via calculation
        gr = GroupRule.create!({ column: "organization", condition: "is", value: organization.name, group_id: ou_group.id })
        
        puts "\tConverting group rules using this group ..."
        # Convert any "OU is..." groups which use this group into an "Organization is..." rule
        GroupRule.where(column: 'ou', value: ou_group.name).each do |group_rule|
          group_rule.column = "organization"
          group_rule.value = organization.name # The organization names tend to be slightly different.
          group_rule.save!
          puts "\t\tGroupRule after: #{group_rule.column} #{group_rule.condition} #{group_rule.value} has #{group_rule.results.length} results"
          if group_rule_counts[group_rule.id] != group_rule.results.length
            puts "\t\tGroupRule count HAS changed."
          else
            puts "\t\tGroupRule count HAS NOT changed."
          end
          puts "\t\tGroupRule contains:"
          group_rule.results.each do |result|
            puts "\t\t\t#{result.entity.id} #{result.entity.name} (#{result.entity.type})"
          end
        end
      else
        puts "\tHas no matching organization"
      end
    end
    
    Authorization.ignore_access_control(false)
  end
  
  desc 'Drop all organizations'
  task :drop => :environment do
    Authorization.ignore_access_control(true)
    
    org_count = Organization.count
    
    Organization.destroy_all
    
    Authorization.ignore_access_control(false)
    
    puts "#{org_count} organization(s) dropped."
  end
end

