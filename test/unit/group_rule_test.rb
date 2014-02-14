require 'test_helper'

class GroupRuleTest < ActiveSupport::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    @person = entities(:casuser)
  end

  test "adding a person to a child organization of an organization should add a GroupRuleResult for that parent" do
    without_access_control do
      # Use fixture cthielen, not casuser, as casuser has an association with the toplevel organization by default
      @cthielen = entities(:cthielen)
      
      o = organizations(:toplevel)
      o_child = organizations(:office_of_toplevel)
      
      # Sanity check the fixtures first ...
      assert o.child_organizations.include?(o_child), "office_of_toplevel fixture should be a child of toplevel"
      assert o.entities.include?(@cthielen) == false, "toplevel should not include cthielen yet"
      assert o.flattened_entities.include?(@cthielen) == false, "toplevel should not include cthielen yet nor should any of its children via flattened_entities"
      
      # Ensure a group has a rule
      group = entities(:groupWithNothing)
      
      assert group.roles.length == 0, "looks like groupWithNothing has a role"
      assert group.rules.length == 0, "looks like groupWithNothing has a rule"
      assert group.owners.length == 0, "looks like groupWithNothing has an owner"
      assert group.operators.length == 0, "looks like groupWithNothing has an operator"
      
      # Test the group rule logic
      assert group.members.length == 0, "group should have no members"
      
      # Ensure @cthielen is in the GroupRuleResult for "Organization is toplevel", which is the parent organization of the one we just added @cthielen to (which is what this test is all about)
      group_rule = GroupRule.new({ column: 'organization', condition: 'is', value: o.name, group_id: group.id })
      group.rules << group_rule
      
      group.reload
      
      assert group.members.length == 1, "group should have 1 member"
      assert group.members.include?(@cthielen) == false, "group should not include @cthielen yet"
      
      Rails.logger.debug "===================="
      
      # Add @cthielen to the child organization
      o_child.entities << @cthielen
      o_child.save!
      
      # Ensure @cthielen is in the parent's flattened_entities first ...
      assert o.flattened_entities.include?(@cthielen), "toplevel should include cthielen"
      
      group.reload
      
      assert group.members.length == 2, "group should have 2 members but has #{group.members.length}"
      assert group.members.include?(@cthielen), "group should include @cthielen"      
    end
  end
  
  test "removing a person from a child organization of an organization should remove the GroupRuleResult for that parent" do
    without_access_control do
      # Use fixture cthielen, not casuser, as casuser has an association with the toplevel organization by default
      @cthielen = entities(:cthielen)
      
      o = organizations(:toplevel)
      o_child = organizations(:office_of_toplevel)
      
      # Sanity check the fixtures first ...
      assert o.child_organizations.include?(o_child), "office_of_toplevel fixture should be a child of toplevel"
      assert o.entities.include?(@cthielen) == false, "toplevel should not include cthielen yet"
      assert o.flattened_entities.include?(@cthielen) == false, "toplevel should not include cthielen yet nor should any of its children via flattened_entities"
      
      # Ensure a group has a rule
      group = entities(:groupWithNothing)
      
      assert group.roles.length == 0, "looks like groupWithNothing has a role"
      assert group.rules.length == 0, "looks like groupWithNothing has a rule"
      assert group.owners.length == 0, "looks like groupWithNothing has an owner"
      assert group.operators.length == 0, "looks like groupWithNothing has an operator"
      
      # Test the group rule logic
      assert group.members.length == 0, "group should have no members"
      
      # Ensure @cthielen is in the GroupRuleResult for "Organization is toplevel", which is the parent organization of the one we just added @cthielen to (which is what this test is all about)
      group_rule = GroupRule.new({ column: 'organization', condition: 'is', value: o.name, group_id: group.id })
      group.rules << group_rule
      
      group.reload
      
      assert group.members.length == 1, "group should have 1 member"
      assert group.members.include?(@cthielen) == false, "group should not include @cthielen yet"
      
      # Add @cthielen to the child organization
      o_child.entities << @cthielen
      o_child.save!
      
      # Ensure @cthielen is in the parent's flattened_entities first ...
      assert o.flattened_entities.include?(@cthielen), "toplevel should include cthielen"
      
      group.reload
      
      assert group.members.length == 2, "group should have 2 members but has #{group.members.length}"
      assert group.members.include?(@cthielen), "group should include @cthielen"
      
      o_child.entities.destroy(@cthielen)
      o_child.save!
      
      group.reload
      
      assert group.members.length == 1, "group should have 1 member but has #{group.members.length}"
      assert group.members.include?(@cthielen) == false, "group should not include @cthielen"      
    end
  end
  
  test "adding a person to an organization should produce the relevant GroupRuleResult" do
    assert false, "implement me"
  end
  
  test "removing a person from an organization should remove the relevant GroupRuleResult" do
    assert false, "implement me"
  end
  
  test "'Department is...' rules should only include members of that specific organization and not members from any child or parent organization" do
    assert false, "implement me"
  end
  
  test "adding a new child organization should affect any GroupRuleResults for parent organizations" do
    assert false, "implement me"
  end
  
  test "removing a child organization entirely should affect any GroupRuleResults for parent organizations" do
    assert false, "implement me"
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
      group.rules.destroy_all
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
      group.rules.destroy_all
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
      group.rules.destroy_all
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
      group.rules.destroy_all
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
    without_access_control do
      # Ensure a group has a rule
      group = entities(:groupWithNothing)
      
      assert group.roles.length == 0, "looks like groupWithNothing has a role"
      assert group.rules.length == 0, "looks like groupWithNothing has a rule"
      assert group.owners.length == 0, "looks like groupWithNothing has an owner"
      assert group.operators.length == 0, "looks like groupWithNothing has an operator"
  
      # Test login ID rules
      assert group.members.length == 0, "group should have no members"
      
      group_rule = GroupRule.new({ column: 'loginid', condition: 'is', value: 'somebody_new', group_id: group.id })
      group.rules << group_rule
      
      group.reload
      
      assert group.members.length == 0, "group should have no members"
      
      person = Person.new({loginid: 'somebody_new', first: 'Somebody', last: 'New'})
      person.save!
      
      group.reload
      
      assert group.members.length == 1, "group should have a member"
    end
  end
  
  test "deleting a person or disabling them should disassociate them with the proper groups" do
    without_access_control do
      # Ensure a group has a rule
      group = entities(:groupWithNothing)
      
      assert group.roles.length == 0, "looks like groupWithNothing has a role"
      assert group.rules.length == 0, "looks like groupWithNothing has a rule"
      assert group.owners.length == 0, "looks like groupWithNothing has an owner"
      assert group.operators.length == 0, "looks like groupWithNothing has an operator"
  
      # Test login ID rules
      assert group.members.length == 0, "group should have no members"
      
      group_rule = GroupRule.new({ column: 'loginid', condition: 'is', value: 'cthielen', group_id: group.id })
      group.rules << group_rule
      
      group.reload
      
      assert group.members.length == 1, "group should have a member"
      
      person = entities(:cthielen)
      person.destroy
      
      group.reload
      
      assert group.members.length == 0, "group should have no members"
    end
  end
  
  test "group rules are ANDed together correctly" do
    without_access_control do
      # Ensure a group has a rule
      group = entities(:groupWithNothing)
      
      assert group.roles.length == 0, "looks like groupWithNothing has a role"
      assert group.rules.length == 0, "looks like groupWithNothing has a rule"
      assert group.owners.length == 0, "looks like groupWithNothing has an owner"
      assert group.operators.length == 0, "looks like groupWithNothing has an operator"
  
      @person.groups << entities(:anOU)
  
      # Test login ID rules
      assert group.members.length == 0, "group should have no members"
      
      group_rule = GroupRule.new({ column: 'ou', condition: 'is', value: 'An OU', group_id: group.id })
      group.rules << group_rule
      
      group.reload
      
      assert group.members.length == 1, "group should have a member"
      
      group_rule = GroupRule.new({ column: 'title', condition: 'is', value: 'something that does not exist', group_id: group.id })
      group.rules << group_rule
      
      group.reload
      
      assert group.members.length == 0, "group should have no members"
    end
  end
end
