require 'rake'

namespace :group do
  require 'authentication'
  include Authentication

  desc 'Recalculate all rule-based groups.'
  task :recalculate_all do
    Rake::Task['environment'].invoke

    # Record groups which will need to recalculate their membership
    touched_group_ids = []

    disable_authorization

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

    enable_authorization
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

    disable_authorization

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

    enable_authorization
  end

  desc 'Recalculate inherited application operatorships from groups.'
  task :recalculate_inherited_application_operatorships do
    Rake::Task['environment'].invoke

    disable_authorization

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

    enable_authorization
  end
end
