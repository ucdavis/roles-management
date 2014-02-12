require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    @person = entities(:casuser)
  end
  
  test "organization cannot be its own parent" do
    assert false, "implement me"
  end
  
  test "organization cannot be its own child" do
    assert false, "implement me"
  end
  
  # Test for an invalid loop commonly found in the data
  test "organization cannot be a parent of its parent" do
    assert false, "implement me"
  end
  
  # test "members added or removed should have group's roles added or removed" do
  #   without_access_control do
  #     # Set up data and ensure it looks correct
  #     group = entities(:groupWithARole)
  #     
  #     assert group.roles.length == 1, "looks like groupWithARole doesn't have its one role"
  #     
  #     @person.role_assignments.destroy_all
  #     assert @person.roles.length == 0, "Looks like our test user 'casuser' has roles already - somebody messed with the fixtures"
  #     
  #     @person.group_memberships.destroy_all
  #     assert @person.group_memberships.length == 0, "'casuser' must not have group memberships for this test"
  #     
  #     # Assign test user to group, confirm they gain group's roles
  #     @person.groups << group
  #     assert @person.group_memberships.length == 1, "unable to add test user to group"
  #     
  #     @person.reload # Need to reload the person for the role assignment created in the RoleAssignment after_save callback to take effect
  #     
  #     assert @person.roles.length == 1, "assigning person to group should have given the person that group's role"
  #     
  #     # Remove the user from the group, ensure they lose group's roles
  #     @person.groups[0].destroy
  #     assert @person.group_memberships.length == 0, "unable to remove test user from group"
  #     
  #     @person.reload
  #     assert @person.roles.length == 0, "removing person from group should have removed the person that group's role"
  #   end
  # end
end
