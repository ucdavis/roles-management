require 'rake'

namespace :group do
  require 'authentication'
  include Authentication

  desc 'Recalculate all rule-based groups.'
  task :recalculate_all do
    Rake::Task['environment'].invoke

    # Record groups which will need to recalculate their membership
    touched_group_ids = []

    puts "Recalculating #{GroupRule.count} group rules."

    # Recalculate all group rule caches
    GroupRule.all.each do |rule|
      old_count = rule.results.length
      touched_group_ids << rule.group.id
      rule.resolve!
      rule.reload
      puts "\tGroupRule ##{rule.id} (#{rule.column} #{rule.condition} #{rule.value}) went from #{old_count} to #{rule.results.length} results"
    end

    puts "Updating the #{touched_group_ids.uniq.length} affected groups."

    # Alert all groups
    touched_group_ids.uniq.each do |group_id|
      group = Group.find_by_id(group_id)
      old_count = group.members.length
      group.recalculate_members!
      group.reload
      puts "\tGroup ##{group.id} (#{group.name}) went from #{old_count} to #{group.members.length} members"
    end
  end

  desc 'Recalculate the rule-based members of a specific group.'
  task :recalculate, [:group_id] => :environment do |t, args|
    unless args[:group_id]
      puts "You must specify a group ID to recalculate."
      exit
    end

    g = Group.find_by_id(args[:group_id])
    unless g
      puts "Could not find a group with ID #{args[:group_id]}."
      exit
    end

    puts "Group (#{g.id}, #{g.name}) has #{g.rules.length} rules."

    # Recalculate the group's rule caches
    g.rules.each do |rule|
      old_count = rule.results.length
      rule.resolve!
      rule.reload
      puts "\tGroupRule ##{rule.id} (#{rule.column} #{rule.condition} #{rule.value}) went from #{old_count} to #{rule.results.length} results"
    end

    old_count = g.members.length
    g.recalculate_members!
    g.reload
    puts "\tGroup ##{g.id} (#{g.name}) went from #{old_count} to #{g.members.length} members"
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
      puts "You must specify a login ID to recalculate."
      exit
    end

    p = Person.find_by_loginid(args[:loginid])
    unless p
      puts "Could not find a person with login ID #{args[:loginid]}"
      exit
    end

    calculated_ras = []
    p.role_assignments.each do |ra|
      if ra.parent_id != nil
        calculated_ras << ra
      end
    end

    puts "#{p.loginid} has #{calculated_ras.length} inherited roles out of #{p.role_assignments.length} total roles."

    # First remove the calculated role assignments
    Thread.current[:role_assignment_destroying_calculated_flag] = true
    calculated_ras.each do |ra|
      ra.destroy
    end
    Thread.current[:role_assignment_destroying_calculated_flag] = nil

    puts "All calculated role assignments destroyed."

    # Now re-create them based on each group's role assignment
    p.group_memberships.each do |gm|
      puts "Group (ID: #{gm.group_id} / #{gm.group.name}) has #{gm.group.roles.length} roles ..."
      gm.group.role_assignments.each do |group_ra|
        if(RoleAssignment.find_by(entity_id: p.id, role_id: group_ra.role_id, parent_id: group_ra.id) == nil)
          ra = RoleAssignment.new
          ra.entity_id = p.id
          ra.role_id = group_ra.role_id
          ra.parent_id = group_ra.id

          puts "\tGranting role (ID: #{group_ra.role_id} / #{group_ra.role.application.name}, #{group_ra.role.token}) with parent assignment #{group_ra.id} ..."

          ra.save!
        else
          puts "\tSkipping role grant as it already exists: role (ID: #{group_ra.role_id} / #{group_ra.role.application.name}, #{group_ra.role.token}) with parent assignment #{group_ra.id}. "
        end
      end
    end
  end

  desc 'Audit inherited roles for data correctness.'
  task :audit_inherited_roles, [:loginid] => :environment do |t, args|
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
          if RoleAssignment.find_by_id(ra.parent_id) == nil
            bad_ras << ra
            bad_people_count = bad_people_count + 1
          end
        end
      end

      #puts "#{p.loginid} has #{bad_ras.length} / #{calculated_ras.length} % invalid inherited roles."
    end

    puts "#{bad_people_count} / #{people.length} (#{bad_people_count / people.length}%) people have invalid inherited roles."
  end
end
