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
      touched_group_ids << rule.group.id
      rule.resolve!
    end
    
    puts "Updating the #{touched_group_ids.uniq.length} affected groups."
    
    # Alert all groups 
    touched_group_ids.uniq.each do |group_id|
      Group.find_by_id(group_id).recalculate_members!
    end
    
    Authorization.ignore_access_control(false)
  end
end
