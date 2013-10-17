class EnsureGroupRuleResultsExistForAllGroupRules < ActiveRecord::Migration
  def up
    Authorization.ignore_access_control(true)
    
    GroupRule.all.each do |gr|
      gr.resolve!
    end
    
    Authorization.ignore_access_control(false)
  end

  def down
    puts "This migration is not reversible."
  end
end
