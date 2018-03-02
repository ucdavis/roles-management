require 'rake'

namespace :group do
  require 'authentication'
  include Authentication

  desc 'Recalculate all rule-based groups.'
  task :recalculate_all do
    Rake::Task['environment'].invoke

    total_count = GroupRuleResultSet.count

    GroupRuleResultSet.all.each_with_index do |grrs, i|
      puts "Recalculating for #{i} of #{total_count} ..."
      grrs.update_results
    end
  end

  desc 'Recalculate inherited application operatorships from groups.'
  task :recalculate_inherited_application_operatorships do
    Rake::Task['environment'].invoke

    # For every group ...
    Group.all.each do |g|
      # For that group's every application operatorship ...
      g.application_operatorships.all.each do |gao|
        # For each member of the group ...
        g.members.each do |m|
          # If they don't already have an _inherited_ application operatorship for this group, grant them one
          ao = ApplicationOperatorship.find_by_parent_id_and_entity_id_and_application_id(g.id, m.id, gao.application_id)
          if ao
            puts "Group member (#{m.id}, #{m.name}) of group (#{g.id}, #{g.name}) already had inherited application operatorship for application (#{gao.application_id}, #{gao.application.name})"
          else
            iao = ApplicationOperatorship.new
            iao.parent_id = g.id
            iao.entity_id = m.id
            iao.application_id = gao.application_id
            iao.save!
            puts "Inheriting new application operatorship for group member (#{m.id}, #{m.name}) of group (#{g.id}, #{g.name}) for application (#{gao.application_id}, #{gao.application.name})"
          end
        end
      end
    end
  end

  desc 'Recalculate inherited roles from groups for a given person.'
  task :recalculate_inherited_roles, [:loginid] => :environment do |t, args|
    unless args[:loginid]
      puts 'You must specify a login ID to recalculate.'
      exit
    end

    p = Person.find_by_loginid(args[:loginid])
    unless p
      puts "Could not find a person with login ID #{args[:loginid]}"
      exit
    end

    puts 'Pre-existing inherited role assignments:'

    preexisting_role_ids = []

    calculated_ras = []
    p.role_assignments.each do |ra|
      next if ra.parent_id.nil?

      puts "\tID: #{ra.id}, Role: #{ra.role.application.name} / #{ra.role.token}, via Group #{RoleAssignment.find_by_id(ra.parent_id).entity.name}"
      preexisting_role_ids << ra.role_id
      calculated_ras << ra
    end

    puts "\n#{p.loginid} has #{calculated_ras.length} inherited roles out of #{p.role_assignments.length} total roles."

    # First remove the calculated role assignments
    Thread.current[:role_assignment_destroying_calculated_flag] = true
    calculated_ras.each(&:destroy)
    Thread.current[:role_assignment_destroying_calculated_flag] = nil

    puts "All calculated role assignments destroyed.\n\n"

    recalculated_role_ids = []

    # Now re-create them based on each group's role assignment
    p.group_memberships.each do |gm|
      puts "Group (ID: #{gm.group_id} / #{gm.group.name}) has #{gm.group.roles.length} roles ..."
      gm.group.role_assignments.each do |group_ra|
        if RoleAssignment.find_by(entity_id: p.id, role_id: group_ra.role_id, parent_id: group_ra.id).nil?
          ra = RoleAssignment.new
          ra.entity_id = p.id
          ra.role_id = group_ra.role_id
          ra.parent_id = group_ra.id

          puts "\tGranting role (ID: #{group_ra.role_id} / #{group_ra.role.application.name}, #{group_ra.role.token}) with parent assignment #{group_ra.id} ..."

          ra.save!

          recalculated_role_ids << ra.role_id
        else
          puts "\tSkipping role grant as it already exists: role (ID: #{group_ra.role_id} / #{group_ra.role.application.name}, #{group_ra.role.token}) with parent assignment #{group_ra.id}. "
        end
      end
    end

    puts "\nPre-existing roles no longer assigned:"
    [preexisting_role_ids - recalculated_role_ids].flatten.each do |role_id|
      puts "\tRole ID: #{role_id}, #{Role.find_by_id(role_id).application.name} / #{Role.find_by_id(role_id).token}"
    end.empty? && begin
      puts "\tNone"
    end

    puts "\nRecalculated roles not previously assigned:"
    [recalculated_role_ids - preexisting_role_ids].flatten.each do |role_id|
      puts "\tRole ID: #{role_id}, #{Role.find_by_id(role_id).application.name} / #{Role.find_by_id(role_id).token}"
    end.empty? && begin
      puts "\tNone"
    end
  end

  desc '(Old) Audit inherited roles for data correctness.'
  task :old_audit_inherited_roles, [:loginid] => :environment do |_t, args|
    people = []
    bad_people_count = 0

    if args[:loginid]
      people << Person.find_by_loginid(args[:loginid])
    else
      people = Person.all
    end

    people.each do |p|
      calculated_ras = []
      bad_ras = []
      p.role_assignments.each do |ra|
        if ra.parent_id != nil
          calculated_ras << ra
          if RoleAssignment.find_by_id(ra.parent_id).nil?
            bad_ras << ra
            bad_people_count += 1
          end
        end
      end
    end

    puts "#{bad_people_count} / #{people.length} (#{bad_people_count / people.length}%) people have invalid inherited roles."
  end

  desc 'Audit inherited roles for data correctness.'
  task :audit_inherited_roles, [:loginid] => :environment do |_t, args|
    people = []

    total_ra_count = RoleAssignment.count
    total_incorrect = 0
    total_missing = 0

    if args[:loginid]
      people << Person.find_by_loginid(args[:loginid])
    else
      people = Person.all
    end

    total_people = people.count

    people.each_with_index do |p, i|
      puts "Analyzing #{p.loginid} (#{i + 1} / #{total_people}) ..."

      # Ensure a person doesn't have inherited roles they shouldn't have ...
      p.role_assignments.each do |ra|
        next if ra.parent_id.nil?

        # Role is inherited
        parent_ra = RoleAssignment.find_by_id(ra.parent_id)

        if parent_ra.nil?
          puts "\tRole assignment #{ra.id} is inherited from #{ra.parent_id} but parent doesn't exist. Skipping ...".red
          next
        end

        # Role is inherited from a group ...
        group = parent_ra.entity
        unless group.members.map(&:loginid).include?(p.loginid)
          puts "\tGroup #{group.id} #{group.name} (excluded) ...".red
          puts "\t\tHas inherited role #{parent_ra.role_id} / #{parent_ra.role.application.name}, #{parent_ra.role.token} but should not ...".red
          ra.destroy
          total_incorrect += 1
        end
      end

      person_role_ids = p.roles.map(&:id)

      # Ensure a person has the inherited roles they shouuld have ...
      p.groups.each do |group|
        group.role_assignments.each do |ra|
          unless person_role_ids.include?(ra.role_id)
            puts "\tGroup #{group.id} #{group.name} (included) ...".green
            puts "\t\tShould have inherited role #{ra.role_id} / #{ra.role.application.name}, #{ra.role.token} but has not yet ...".green

            new_ra = RoleAssignment.new
            new_ra.role_id = ra.role_id
            new_ra.entity_id = p.id
            new_ra.parent_id = ra.id
            new_ra.save!

            total_missing += 1
          end
        end
      end
    end

    puts "\n"
    puts "Total role assignments (at start)  : #{total_ra_count}"
    puts "Total role assignments (at finish) : #{RoleAssignment.count}"
    puts "Total found incorrect              : #{total_incorrect}"
    puts "Total found missing                : #{total_missing}"
  end

  desc 'Convert applicable "Org Is" rules to "Dept Is"'
  task convert_org_rules: :environment do
    GroupRule.where(column: 'organization').each do |gr|
      o = Organization.find_by(name: gr.value)
      next unless o

      # We only care about organizations with no children
      next unless o.child_org_ids.empty?

      d = Department.find_by(officialName: gr.value)
      d = Department.find_by(displayName: gr.value) if d.nil?
      d = Department.find_by(abbreviation: gr.value) if d.nil?
      if d.nil?
        STDERR.puts "Cannot convert GroupRule for organization '#{o.name}', no matching department found. Skipping ..."
        next
      end

      # Organization has no children and can be treated as a department
      puts "Converting organization-based GroupRule (ID: #{gr.id}, value: #{gr.value})"
      puts "\tResults before conversion: #{gr.results.length}"
      gr.column = 'department'
      gr.save!
      puts "\tResults after conversion: #{gr.results.length}"
    end
  end
end
