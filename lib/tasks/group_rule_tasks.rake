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

  # desc 'Recalculate all rule-based groups.'
  # task :recalculate_all do
  #   Rake::Task['environment'].invoke

  #   total_count = GroupRuleResultSet.count

  #   GroupRuleResultSet.all.each_with_index do |grrs, i|
  #     puts "Recalculating for #{i} of #{total_count} ..."
  #     grrs.update_results
  #   end
  # end
end
