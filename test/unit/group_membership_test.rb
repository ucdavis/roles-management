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
  
  test "group membership may not be include other groups" do
    group = entities(:groupWithNothing)
    another_group = entities(:anotherGroupWithNothing)
    
    assert group.members.length == 0, "group should not have any members. Fixture has been modified."
    assert another_group.members.length == 0, "another_group should not have any members. Fixture has been modified."
    
    begin
      group.members << another_group
    rescue ActiveRecord::RecordInvalid
      # This is correct
    end
    
    assert group.valid? == false, "group should not be valid, having a group as its member"
  end
end
