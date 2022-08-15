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
    count_diff_found = 0

    GroupRuleResultSet.all.each_with_index do |grrs, i|
      puts "Recalculating for #{i + 1} of #{total_count} ..."
      puts "\t#{grrs.column} #{grrs.value}, #{grrs.results.count} results"
      old_count = grrs.results.count
      grrs.update_results
      new_count = grrs.results.count

      if old_count == new_count
        puts "\t\tNo result count difference"
      else
        puts "\t\tResult count difference found (#{old_count} to #{new_count})"
        count_diff_found += 1
      end
    end

    puts "Total outdated GroupRuleResultSets: #{count_diff_found}"
  end

  desc 'Recalculate inherited application operatorships from groups (destructive).'
  task :recalculate_inherited_application_operatorships do
    Rake::Task['environment'].invoke
    Rails.logger.info "Running task group:recalculate_inherited_application_operatorships"

    stale_calculated_ao_ids = ApplicationOperatorship.where.not(parent_id: nil).map(&:id)

    found_correct = 0
    found_missing = 0
    found_incorrect = 0

    # For every group ...
    Group.all.each do |g|
      # For that group's every application operatorship ...
      g.application_operatorships.all.each do |gao|
        # For each member of the group ...
        g.members.each do |m|
          # If they don't already have an _inherited_ application operatorship for this group, grant them one
          ao = ApplicationOperatorship.find_by(parent_id: gao.id, entity_id: m.id, application_id: gao.application_id)
          if ao
            #puts "Group member (#{m.id}, #{m.name}) of group (#{g.id}, #{g.name}) already had inherited application operatorship for application (#{gao.application_id}, #{gao.application.name})"
            found_correct += 1
            stale_calculated_ao_ids.delete(ao.id)
          else
            iao = ApplicationOperatorship.new
            iao.parent_id = gao.id
            iao.entity_id = m.id
            iao.application_id = gao.application_id
            iao.save!
            found_missing += 1
            #puts "Inheriting new application operatorship for group member (#{m.id}, #{m.name}) of group (#{g.id}, #{g.name}) for application (#{gao.application_id}, #{gao.application.name})"
          end
        end
      end
    end

    found_incorrect = stale_calculated_ao_ids.length
    ApplicationOperatorship.where(id: stale_calculated_ao_ids).destroy_all

    if (found_incorrect > 0) || (found_missing > 0)
      puts "Operation complete. Results:\n"
      puts "\tFound correct   (fine)   : #{found_correct}"
      puts "\tFound incorrect (removed): #{found_incorrect}"
      puts "\tFound missing   (added)  : #{found_missing}"
    end

    Rails.logger.info "Finished task group:recalculate_inherited_application_operatorships"
  end

  desc 'Recalculate inherited application ownerships from groups (destructive).'
  task :recalculate_inherited_application_ownerships do
    Rake::Task['environment'].invoke

    Rails.logger.info "Running task group:recalculate_inherited_application_ownerships"
    stale_calculated_ao_ids = ApplicationOwnership.where.not(parent_id: nil).map(&:id)

    found_correct = 0
    found_missing = 0
    found_incorrect = 0

    # For every group ...
    Group.all.each do |g|
      # For that group's every application ownership ...
      g.application_ownerships.all.each do |gao|
        # For each member of the group ...
        g.members.each do |m|
          # If they don't already have an _inherited_ application ownership for this group, grant them one
          ao = ApplicationOwnership.find_by(parent_id: gao.id, entity_id: m.id, application_id: gao.application_id)
          if ao
            #puts "Group member (#{m.id}, #{m.name}) of group (#{g.id}, #{g.name}) already had inherited application ownership for application (#{gao.application_id}, #{gao.application.name})"
            found_correct += 1
            stale_calculated_ao_ids.delete(ao.id)
          else
            iao = ApplicationOwnership.new
            iao.parent_id = gao.id
            iao.entity_id = m.id
            iao.application_id = gao.application_id
            iao.save!
            found_missing += 1
            #puts "Inheriting new application ownership for group member (#{m.id}, #{m.name}) of group (#{g.id}, #{g.name}) for application (#{gao.application_id}, #{gao.application.name})"
          end
        end
      end
    end

    found_incorrect = stale_calculated_ao_ids.length
    ApplicationOwnership.where(id: stale_calculated_ao_ids).destroy_all

    if (found_incorrect > 0) || (found_missing > 0)
      puts "Operation complete. Results:\n"
      puts "\tFound correct   (fine)   : #{found_correct}"
      puts "\tFound incorrect (removed): #{found_incorrect}"
      puts "\tFound missing   (added)  : #{found_missing}"
    end

    Rails.logger.info "Finished task group:recalculate_inherited_application_ownerships"
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

    recalculated_role_ids = []

    # Re-create calculated role assignments them based on each group's role assignment
    p.groups.each do |group|
      puts "Group (ID: #{group.id} / #{group.name}) has #{group.roles.length} roles ..."
      group.role_assignments.each do |group_ra|
        if RoleAssignment.find_by(entity_id: p.id, role_id: group_ra.role_id, parent_id: group_ra.id).nil?
          # TODO: Refactor this as part of service layer work?
          RoleAssignmentsService.assign_role_to_entity(p, Role.find_by(id: group_ra.role_id), group_ra.id)

          puts "\tGranting role (ID: #{group_ra.role_id} / #{group_ra.role.application.name}, #{group_ra.role.token}) with parent assignment #{group_ra.id} ..."

          recalculated_role_ids << group_ra.role_id
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
      if people[0] == nil
        STDERR.puts "No person with login ID found: #{args[:loginid]}"
        exit(-1)
      end
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
          RoleAssignmentsService.unassign_role_from_entity(ra)
          total_incorrect += 1
        end
      end

      person_role_ids = p.roles.map(&:id)

      # Ensure a person has the inherited roles they should have ...
      p.groups.each do |group|
        group.role_assignments.each do |ra|
          unless person_role_ids.include?(ra.role_id)
            Rails.logger.info "#{p.loginid}: Group #{group.id} #{group.name} (included) ..."
            Rails.logger.info "#{p.loginid}: -- Should have inherited role #{ra.role_id} / #{ra.role.application.name}, #{ra.role.token} but has not yet ..."

            RoleAssignmentsService.assign_role_to_entity(p, Role.find_by(id: ra.role_id), ra.id)

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
