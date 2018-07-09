require 'rake'

namespace :group do
  require 'authentication'
  include Authentication

  desc 'Generates a summary CSV about groups.'
  task summary_csv: :environment do
    require 'csv'

    puts ["group_id","group_name","group_member_count"].to_csv
    Group.all.each do |g|
      puts [g.id,g.name,g.members.length].to_csv
    end
  end

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

  desc 'Audit inherited roles for data correctness.'
  task :audit_inherited_roles, [:loginid] => :environment do |_t, args|
    LOG_PROGRESS_INTERVAL = 1000
    people = []
    start_ts = Time.now

    Rails.logger.info "Starting task group:audit_inherited_roles at #{start_ts}"

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
      # Only log out every LOG_PROGRESS_INTERVAL rows
      if (i % LOG_PROGRESS_INTERVAL) == 0
        log_str = "Analyzing #{p.loginid} (#{i + 1} / #{total_people}) ..."
        Rails.logger.info log_str
      end

      # Ensure a person doesn't have inherited roles they shouldn't have ...
      p.role_assignments.each do |ra|
        next if ra.parent_id.nil?

        # Role is inherited
        parent_ra = RoleAssignment.find_by_id(ra.parent_id)

        if parent_ra.nil?
          Rails.logger.info "#{p.loginid}: Role assignment #{ra.id} is inherited from #{ra.parent_id} but parent doesn't exist. Skipping ..."
          next
        end

        # Role is inherited from a group ...
        group = parent_ra.entity
        unless group.members.map(&:loginid).include?(p.loginid)
          Rails.logger.info "#{p.loginid}: Group #{group.id} #{group.name} (excluded) ..."
          Rails.logger.info "#{p.loginid}: -- Has inherited role #{parent_ra.role_id} / #{parent_ra.role.application.name}, #{parent_ra.role.token} but should not ..."
          ra.destroy
          total_incorrect += 1
        end
      end

      person_role_ids = p.roles.map(&:id)

      # Ensure a person has the inherited roles they shouuld have ...
      p.groups.each do |group|
        group.role_assignments.each do |ra|
          unless person_role_ids.include?(ra.role_id)
            Rails.logger.info "#{p.loginid}: Group #{group.id} #{group.name} (included) ..."
            Rails.logger.info "#{p.loginid}: -- Should have inherited role #{ra.role_id} / #{ra.role.application.name}, #{ra.role.token} but has not yet ..."

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

    Rails.logger.info "Total role assignments (at start)  : #{total_ra_count}"
    Rails.logger.info "Total role assignments (at finish) : #{RoleAssignment.count}"
    Rails.logger.info "Total found incorrect              : #{total_incorrect}"
    Rails.logger.info "Total found missing                : #{total_missing}"

    stop_ts = Time.now
    Rails.logger.info "Task took #{stop_ts - start_ts}s"
    Rails.logger.info "Finished task group:audit_inherited_roles at #{stop_ts}"
  end
end
