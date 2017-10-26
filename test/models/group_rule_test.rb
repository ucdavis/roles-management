require 'test_helper'

class GroupRuleTest < ActiveSupport::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake('casuser')

    @person = entities(:casuser)
  end

  test 'adding a person to a child organization of an organization should add a GroupRuleResult for that parent' do
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
    assert group.members.empty?, 'group should have no members'

    # Ensure @cthielen is in the GroupRuleResult for "Organization is toplevel", which is the parent organization of the one we just added @cthielen to (which is what this test is all about)
    group_rule = GroupRule.new({ column: 'organization', condition: 'is', value: o.name, group_id: group.id })
    group.rules << group_rule

    group.reload

    assert group.members.length == 1, 'group should have 1 member'
    assert group.members.include?(@cthielen) == false, 'group should not include @cthielen yet'

    # Add @cthielen to the child organization
    o_child.entities << @cthielen
    o_child.save!

    o.reload

    # Ensure @cthielen is in the parent's flattened_entities first ...
    assert o.flattened_entities.include?(@cthielen), "toplevel should include cthielen"

    group.reload

    assert group.members.length == 2, "group should have 2 members but has #{group.members.length}"
    assert group.members.include?(@cthielen), "group should include @cthielen"
  end

  test 'removing a person from a child organization of an organization should remove the GroupRuleResult for that parent' do
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

    o.reload

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

  test "adding a person to an organization should produce the relevant GroupRuleResult" do
    # Use fixture cthielen, not casuser, as casuser has an association with the toplevel organization by default
    @cthielen = entities(:cthielen)

    o = organizations(:toplevel)

    # Sanity check the fixtures first ...
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

    # Add @cthielen to the organization
    o.entities << @cthielen
    o.save!

    # Ensure @cthielen is in the parent's flattened_entities first ...
    assert o.flattened_entities.include?(@cthielen), "toplevel should include cthielen"

    group.reload

    assert group.members.length == 2, "group should have 2 members but has #{group.members.length}"
    assert group.members.include?(@cthielen), "group should include @cthielen"
  end

  test 'removing a person from an organization should remove the relevant GroupRuleResult' do
    # Use fixture cthielen, not casuser, as casuser has an association with the toplevel organization by default
    @cthielen = entities(:cthielen)

    o = organizations(:toplevel)

    # Sanity check the fixtures first ...
    assert o.entities.include?(@cthielen) == false, 'toplevel should not include cthielen yet'
    assert o.flattened_entities.include?(@cthielen) == false, 'toplevel should not include cthielen yet nor should any of its children via flattened_entities'

    # Ensure a group has a rule
    group = entities(:groupWithNothing)

    assert group.roles.empty?, 'looks like groupWithNothing has a role'
    assert group.rules.empty?, 'looks like groupWithNothing has a rule'
    assert group.owners.empty?, 'looks like groupWithNothing has an owner'
    assert group.operators.empty?, 'looks like groupWithNothing has an operator'

    # Test the group rule logic
    assert group.members.empty?, 'group should have no members'

    # Ensure @cthielen is in the GroupRuleResult for "Organization is toplevel", which is the parent organization of the one we just added @cthielen to (which is what this test is all about)
    group_rule = GroupRule.new( column: 'organization', condition: 'is', value: o.name, group_id: group.id )
    group.rules << group_rule

    group.reload

    assert group.members.length == 1, 'group should have 1 member'
    assert group.members.include?(@cthielen) == false, 'group should not include @cthielen yet'

    # Add @cthielen to the organization
    o.entities << @cthielen
    o.save!

    # Ensure @cthielen is in the parent's flattened_entities first ...
    assert o.flattened_entities.include?(@cthielen), "toplevel should include cthielen"

    group.reload

    assert group.members.length == 2, "group should have 2 members but has #{group.members.length}"
    assert group.members.include?(@cthielen), "group should include @cthielen"

    o.entities.destroy(@cthielen)
    o.save!

    group.reload

    assert group.members.length == 1, "group should have 1 member but has #{group.members.length}"
    assert group.members.include?(@cthielen) == false, "group should not include @cthielen"
  end

  test "Test basic 'Department is...' rule logic" do
    o = organizations(:separate_toplevel)

    group = entities(:groupWithNothing)

    # Sanity-check the fixtures
    assert group.roles.length == 0, "looks like groupWithNothing has a role"
    assert group.rules.length == 0, "looks like groupWithNothing has a rule"
    assert group.owners.length == 0, "looks like groupWithNothing has an owner"
    assert group.operators.length == 0, "looks like groupWithNothing has an operator"

    # Test the group rule logic (ensure 'Department is...' works)
    assert group.members.length == 0, "group should have no members"

    group_rule = GroupRule.new({ column: 'department', condition: 'is', value: o.name, group_id: group.id })
    group.rules << group_rule

    group.reload

    assert group.members.length == 1, "group should have 1 member"

    # Ensure adding someone to a department affects the group rule results ...
    @cthielen = entities(:cthielen)
    # Add @cthielen to the organization
    o.entities << @cthielen
    o.save!

    group.reload

    assert group.members.length == 2, "group should have 2 members but has #{group.members.length}"
    assert group.members.include?(@cthielen), "group should include @cthielen"

    o.entities.destroy(@cthielen)
    o.save!

    group.reload

    assert group.members.length == 1, "group should have 1 member but has #{group.members.length}"
    assert group.members.include?(@cthielen) == false, "group should not include @cthielen"
  end

  test "Ensure 'Department is...' rule logic does not include child entities like 'Organization is...' would" do
    o = organizations(:separate_toplevel)

    group = entities(:groupWithNothing)

    # Sanity-check the fixtures
    assert group.roles.length == 0, "looks like groupWithNothing has a role"
    assert group.rules.length == 0, "looks like groupWithNothing has a rule"
    assert group.owners.length == 0, "looks like groupWithNothing has an owner"
    assert group.operators.length == 0, "looks like groupWithNothing has an operator"

    # Test the group rule logic (ensure 'Department is...' works)
    assert group.members.length == 0, "group should have no members"

    group_rule = GroupRule.new({ column: 'department', condition: 'is', value: o.name, group_id: group.id })
    group.rules << group_rule

    group.reload

    assert group.members.length == 1, "group should have 1 member"
    assert group.members.include?(entities(:group_memberA)), "group_memberA should be a member"
    assert group.members.include?(entities(:group_memberB)) == false, "group_memberB should not be a member"
  end

  test "adding a new child organization should affect any GroupRuleResults for parent organizations" do
    # Use fixture cthielen, not casuser, as casuser has an association with the toplevel organization by default
    @cthielen = entities(:cthielen)

    o = organizations(:toplevel)
    o_orphan = organizations(:orphaned_org)

    # Sanity check the fixtures first ...
    assert o.child_organizations.include?(o_orphan) == false, "orphaned_org fixture should not be a child of toplevel"
    assert o.entities.include?(@cthielen) == false, "toplevel should not include cthielen yet"
    assert o.flattened_entities.include?(@cthielen) == false, "toplevel should not include cthielen yet nor should any of its children via flattened_entities"
    assert o_orphan.entities.include?(@cthielen) == false, "orphaned_org should not include cthielen yet"
    assert o_orphan.flattened_entities.length == 0, "orphaned_org should not include any entities"

    # Set up a group with a rule for the top-level org
    group = entities(:groupWithNothing)

    assert group.roles.length == 0, "looks like groupWithNothing has a role"
    assert group.rules.length == 0, "looks like groupWithNothing has a rule"
    assert group.owners.length == 0, "looks like groupWithNothing has an owner"
    assert group.operators.length == 0, "looks like groupWithNothing has an operator"
    assert group.members.length == 0, "group should have no members"

    group_rule = GroupRule.new({ column: 'organization', condition: 'is', value: o.name, group_id: group.id })
    group.rules << group_rule

    group.reload

    # Fixture includes one member but it shouldn't be @cthielen
    assert group.members.length == 1, "group should have 1 member"
    assert group.members.include?(@cthielen) == false, "group should not include @cthielen yet"

    # Add @cthielen to the orphaned org
    o_orphan.entities << @cthielen
    o_orphan.save!
    o_orphan.reload

    # @cthielen should not be in the soon-to-be parent's flattened_entities first ...
    assert o.flattened_entities.include?(@cthielen) == false, "toplevel should not include cthielen"
    # but he should be in the orphaned_org
    assert o_orphan.flattened_entities.include?(@cthielen), "orphaned_org should include cthielen"

    # Finally, the action we're testing, add the orphaned org to be a child of the top-level org
    o.child_organizations << o_orphan
    o.save!

    assert o_orphan.parent_organizations.length == 1, "orphaned org should now have one parent"
    assert o.flattened_entities.include?(@cthielen), "toplevel should now include cthielen because he is part of the recently-assigned child org"

    # Test that the GroupRule for the top-level org was adjusted
    group.reload

    assert group.members.include?(@cthielen), "group should include @cthielen"
    assert group.members.length == 2, "group should have 2 members but has #{group.members.length}"
  end

  test 'removing a child organization entirely should affect any GroupRuleResults for parent organizations' do
    # Use fixture cthielen, not casuser, as casuser has an association with the toplevel organization by default
    @cthielen = entities(:cthielen)

    o = organizations(:toplevel)
    o_orphan = organizations(:orphaned_org)

    # Sanity check the fixtures first ...
    assert o.child_organizations.include?(o_orphan) == false, "orphaned_org fixture should not be a child of toplevel"
    assert o.entities.include?(@cthielen) == false, "toplevel should not include cthielen yet"
    assert o.flattened_entities.include?(@cthielen) == false, "toplevel should not include cthielen yet nor should any of its children via flattened_entities"
    assert o_orphan.entities.include?(@cthielen) == false, "orphaned_org should not include cthielen yet"
    assert o_orphan.flattened_entities.length == 0, "orphaned_org should not include any entities"

    # Set up a group with a rule for the top-level org
    group = entities(:groupWithNothing)

    assert group.roles.length == 0, "looks like groupWithNothing has a role"
    assert group.rules.length == 0, "looks like groupWithNothing has a rule"
    assert group.owners.length == 0, "looks like groupWithNothing has an owner"
    assert group.operators.length == 0, "looks like groupWithNothing has an operator"
    assert group.members.length == 0, "group should have no members"

    group_rule = GroupRule.new({ column: 'organization', condition: 'is', value: o.name, group_id: group.id })
    group.rules << group_rule

    group.reload

    # Fixture includes one member but it shouldn't be @cthielen
    assert group.members.length == 1, "group should have 1 member"
    assert group.members.include?(@cthielen) == false, "group should not include @cthielen yet"

    # Add @cthielen to the orphaned org
    o_orphan.entities << @cthielen
    o_orphan.save!
    o_orphan.reload

    # @cthielen should not be in the soon-to-be parent's flattened_entities first ...
    assert o.flattened_entities.include?(@cthielen) == false, 'toplevel should not include cthielen'
    # but he should be in the orphaned_org
    assert o_orphan.flattened_entities.include?(@cthielen), 'orphaned_org should include cthielen'

    # Finally, the action we're testing, add the orphaned org to be a child of the top-level org
    o.child_organizations << o_orphan
    o.save!

    assert o_orphan.parent_organizations.length == 1, "orphaned org should now have one parent"
    assert o.flattened_entities.include?(@cthielen), "toplevel should now include cthielen because he is part of the recently-assigned child org"

    # Test that the GroupRule for the top-level org was adjusted
    group.reload

    assert group.members.include?(@cthielen), "group should include @cthielen"
    assert group.members.length == 2, "group should have 2 members but has #{group.members.length}"

    # Now perform the actual test - remove the child organization and ensure the group is updated correctly
    o.child_organizations.destroy_all
    o_orphan.reload

    assert o_orphan.parent_organizations.length == 0, "orphaned org should not have a parent anymore"
    assert o.child_organizations.include?(o_orphan) == false, "orphaned org should not be a child anymore"

    group.reload

    # The actual test!
    assert group.members.include?(@cthielen) == false, "group should no longer include @cthielen"
    assert group.members.length == 1, "group should have 1 member but has #{group.members.length}"
  end

  test "changing relevant person attributes should automatically associate them with the proper groups" do
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

    # Test that setting a person's OU fills in a group's department rule
    group.rules.destroy_all
    group_rule = GroupRule.new({ column: 'department', condition: 'is', value: organizations(:office_of_toplevel).name, group_id: group.id })
    group.rules << group_rule

    group.reload

    assert group.members.length == 0, "group should have no members"

    @person.organizations << organizations(:office_of_toplevel)
    @person.save!

    group.reload

    assert group.members.length == 1, "group should have a member"

    @person.organizations.destroy(organizations(:office_of_toplevel))
    @person.save!

    group.reload

    assert group.members.length == 0, "group should have no members"
  end

  test "creating a person should associate them with the proper groups" do
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

  test "deleting a person or disabling them should disassociate them with the proper groups" do
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

  test "group rules are ANDed together correctly" do
    # Ensure a group has a rule
    group = entities(:groupWithNothing)

    assert group.roles.length == 0, "looks like groupWithNothing has a role"
    assert group.rules.length == 0, "looks like groupWithNothing has a rule"
    assert group.owners.length == 0, "looks like groupWithNothing has an owner"
    assert group.operators.length == 0, "looks like groupWithNothing has an operator"

    @person.organizations << organizations(:office_of_toplevel)

    # Test login ID rules
    assert group.members.length == 0, "group should have no members"

    group_rule = GroupRule.new({ column: 'organization', condition: 'is', value: organizations(:office_of_toplevel).name, group_id: group.id })
    group.rules << group_rule

    group.reload

    assert group.members.length == 1, "group should have a member"

    group_rule = GroupRule.new({ column: 'title', condition: 'is', value: 'something that does not exist', group_id: group.id })
    group.rules << group_rule

    group.reload

    assert group.members.length == 0, "group should have no members"
  end

  test "Rule 'login ID is not' works" do
    # Ensure a group has a rule
    group = entities(:groupWithNothing)

    assert group.roles.length == 0, "looks like groupWithNothing has a role"
    assert group.rules.length == 0, "looks like groupWithNothing has a rule"
    assert group.owners.length == 0, "looks like groupWithNothing has an owner"
    assert group.operators.length == 0, "looks like groupWithNothing has an operator"

    @person.organizations << organizations(:office_of_toplevel)

    # Test login ID rules
    assert group.members.length == 0, "group should have no members"

    group_rule = GroupRule.new({ column: 'organization', condition: 'is', value: organizations(:office_of_toplevel).name, group_id: group.id })
    group.rules << group_rule

    group.reload

    assert group.members.length == 1, "group should have a member"

    group_rule = GroupRule.new({ column: 'loginid', condition: 'is not', value: @person.loginid, group_id: group.id })
    group.rules << group_rule

    group.reload

    assert group.members.length == 0, "group should have no members"
  end
end
