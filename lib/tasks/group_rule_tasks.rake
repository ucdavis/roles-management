require 'rake'

namespace :rules do
  require 'authentication'
  include Authentication

  desc 'Generates a summary CSV about group rules.'
  task summary_csv: :environment do
    require 'csv'

    puts ["group_rule_id","group_id","group_name","column","condition","value","result_count"].to_csv
    GroupRule.all.each do |gr|
      puts [gr.id,gr.group_id,gr.group.name,gr.column,gr.condition,gr.value,gr.result_set.results.length].to_csv
    end
  end

  desc 'Diagnoses a person against a group\'s rules'
  task :diagnoses_rules, [:group_id, :loginid] => :environment do |t, args|
    g = Group.find_by(id: args[:group_id])
    unless g
      STDERR.puts "Could not find a group with ID #{args[:group_id]}"
      exit(-1)
    end

    p = Person.find_by(loginid: args[:loginid])
    unless p
      STDERR.puts "Could not find a person with login ID #{args[:loginid]}"
      exit(-1)
    end

    puts "Group (#{g.id},#{g.name}) has #{g.rules.length} rules"

    puts "According to the database, specified person (#{p.id},#{p.loginid}) " + (g.members.include?(p) ? 'is' : 'is not') + " in the group"

    matches_all_groups = true

    g.rules.group_by(&:column).each do |column, rules|
      puts "\tColumn: #{column} (#{rules.length} rules)"
      match_count = 0
      rules.each do |rule|
        matches = rule.matches?(p)
        match_count += matches ? 1 : 0
        puts "\t\tRule: #{rule.column} #{rule.condition} #{rule.value} ... " + (matches ? 'matches' : 'does not match')
      end
      puts "\tColumn is " + (match_count > 0 ? 'a match' : 'not a match') + " (matching #{match_count})"
      matches_all_groups &= (match_count > 0)
    end

    puts "According to check, specified person (#{p.id},#{p.loginid}) " + (matches_all_groups ? 'should be' : 'should not be') + " in the group"
  end
end
