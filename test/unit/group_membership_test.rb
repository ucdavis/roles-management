require 'test_helper'

class GroupMembershipTest < ActiveSupport::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    @person = entities(:casuser)
  end
  
  test "members added or removed should have group's roles added or removed" do
    # Set up data and ensure it looks correct
    group = entities(:groupWithARole)
    
    assert group.roles.length == 1, "looks like groupWithARole doesn't have its one role"
    
    @person.role_assignments.destroy_all
    assert @person.roles.length == 0, "Looks like our test user 'casuser' has roles already - somebody messed with the fixtures"
    
    @person.group_memberships.destroy_all
    assert @person.group_memberships.length == 0, "'casuser' must not have group memberships for this test"
    
    # Assign test user to group, confirm they gain group's roles
    @person.groups << group
    assert @person.group_memberships.length == 1, "unable to add test user to group"
    
    @person.reload # Need to reload the person for the role assignment created in the RoleAssignment after_save callback to take effect
    
    assert @person.roles.length == 1, "assigning person to group should have given the person that group's role"
    
    # Remove the user from the group, ensure they lose group's roles
    @person.groups[0].destroy
    assert @person.group_memberships.length == 0, "unable to remove test user from group"
    
    @person.reload
    assert @person.roles.length == 0, "removing person from group should have removed the person that group's role"
  end
  
  test "group membership may not be cyclical" do
    group = entities(:groupWithNothing)
    another_group = entities(:anotherGroupWithNothing)
    
    assert group.members.length == 0, "group should not have any members. Fixture has been modified."
    assert another_group.members.length == 0, "another_group should not have any members. Fixture has been modified."
    
    group.members << another_group
    group.reload
    another_group.reload
    
    assert group.members.length == 1, "group should now have one member"
    assert another_group.members.length == 0, "another_group should still have no members"
    
    begin
      another_group.members << group
    rescue ActiveRecord::RecordInvalid
      # This is correct
    end
    
    assert another_group.valid? == false, "another_group should not be valid, having formed a cycle"
  end

  test "non-cycle group membership should work" do
    group1 = entities(:groupWithNothing)
    group2 = entities(:anotherGroupWithNothing)
    group3 = entities(:groupWithoutARole)
    
    assert group1.members.length == 0, "group1 should not have any members. Fixture has been modified."
    assert group2.members.length == 0, "group2 should not have any members. Fixture has been modified."
    assert group3.members.length == 0, "group3 should not have any members. Fixture has been modified."
    
    group1.members << group2
    group1.reload
    group2.reload
    
    assert group1.members.length == 1, "group1 should now have one member"
    assert group2.members.length == 0, "group2 should still have no members"
    assert group3.members.length == 0, "group3 should not have any members. Fixture has been modified."
    
    group2.members << group3
    
    assert group1.members.length == 1, "group1 should now have one member"
    assert group2.members.length == 1, "group2 should still have no members"
    assert group3.members.length == 0, "group3 should not have any members. Fixture has been modified."
  end
end
