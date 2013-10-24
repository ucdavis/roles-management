require 'test_helper'

class GroupRuleTest < ActiveSupport::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    @person = entities(:casuser)
  end
  
  test "changing relevant person attributes should automatically associate them with the proper groups" do
    without_access_control do
      # Ensure a group has a rule
      group = entities(:groupWithNothing)
      
      assert group.roles.length == 0, "looks like groupWithNothing has a role"
      assert group.rules.length == 0, "looks like groupWithNothing has a rule"
      assert group.owners.length == 0, "looks like groupWithNothing has an owner"
      assert group.operators.length == 0, "looks like groupWithNothing has an operator"

      # Test login ID rules
      assert group.members.length == 0, "group should have no members"
      
      group_rule = GroupRule.new({ column: 'loginid', condition: 'is', value: 'casuser2', group_id: group.id })
      group.rules << group_rule
      
      group.reload
      
      assert group.members.length == 0, "group should have no members"
      
      @person.loginid = 'casuser2'
      @person.save!
      
      group.reload
      
      assert group.members.length == 1, "group should have a member"
      
      @person.loginid = 'casuser'
      @person.save!
      
      group.reload
      
      assert group.members.length == 0, "group should have no members"
      
      group_rule = group.rules[0]
      group_rule.value = 'casuser'
      group_rule.save!
      
      group.reload
      
      assert group.members.length == 1, "group should have a member"
      
      # Test that destroying all rules removes members
      
      group.rules.destroy_all
      
      group.reload
      
      assert group.members.length == 0, "group should have no members"
      
      # Test that setting a person's title fills in a group
      group_rule = GroupRule.new({ column: 'title', condition: 'is', value: 'Researcher', group_id: group.id })
      group.rules << group_rule
      
      group.reload
      
      assert group.members.length == 0, "group should have no members"
      
      @person.title = titles(:researcher)
      @person.save!
      
      group.reload
      
      assert group.members.length == 1, "group should have a member"

      @person.title = nil
      @person.save!
      
      group.reload
      
      assert group.members.length == 0, "group should have no members"

      # Test that setting a person's major fills in a group
      group_rule = GroupRule.new({ column: 'major', condition: 'is', value: 'History', group_id: group.id })
      group.rules << group_rule
      
      group.reload
      
      assert group.members.length == 0, "group should have no members"
      
      @person.major = majors(:history)
      @person.save!
      
      group.reload
      
      assert group.members.length == 1, "group should have a member"

      @person.major = nil
      @person.save!
      
      group.reload
      
      assert group.members.length == 0, "group should have no members"

      # Test that setting a person's affiliation fills in a group
      group_rule = GroupRule.new({ column: 'affiliation', condition: 'is', value: 'staff', group_id: group.id })
      group.rules << group_rule
      
      group.reload
      
      assert group.members.length == 0, "group should have no members"
      
      @person.affiliations << affiliations(:staff)
      @person.save!
      
      group.reload
      
      assert group.members.length == 1, "group should have a member"

      @person.affiliations.destroy_all
      @person.save!
      
      group.reload
      
      assert group.members.length == 0, "group should have no members"

      # Test that setting a person's OU fills in a group
      group_rule = GroupRule.new({ column: 'ou', condition: 'is', value: 'An OU', group_id: group.id })
      group.rules << group_rule
      
      group.reload
      
      assert group.members.length == 0, "group should have no members"
      
      @person.groups << entities(:anOU)
      @person.save!
      
      group.reload
      
      assert group.members.length == 1, "group should have a member"

      @person.groups.destroy(entities(:anOU))
      @person.save!
      
      group.reload
      
      assert group.members.length == 0, "group should have no members"

      # Test that setting a person's classification fills in a group
      group_rule = GroupRule.new({ column: 'classification', condition: 'is', value: 'Programmer', group_id: group.id })
      group.rules << group_rule
      
      group.reload
      
      assert group.members.length == 0, "group should have no members"
      
      @person.title = classifications(:programmer).titles.first
      @person.save!
      
      group.reload
      
      assert group.members.length == 1, "group should have a member"

      @person.title = nil
      @person.save!
      
      group.reload
      
      assert group.members.length == 0, "group should have no members"
    end
  end

  test "creating a person should associate them with the proper groups" do
    assert false, "incomplete test"
  end

  test "deleting a person or disabling them should disassociate them with the proper groups" do
    assert false, "incomplete test"
  end
end
