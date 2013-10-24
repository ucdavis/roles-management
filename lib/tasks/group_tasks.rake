require 'rake'

namespace :group do
  desc 'Recalculate all rule-based groups.'
  task :recalculate_all do
    Rake::Task['environment'].invoke

    # Record groups which will need to recalculate their membership
    touched_group_ids = []

    Authorization.ignore_access_control(true)
    
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
    
    Authorization.ignore_access_control(false)
  end
end
