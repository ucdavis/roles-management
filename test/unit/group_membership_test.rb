require 'test_helper'

class GroupMembershipTest < ActiveSupport::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    @person = entities(:casuser)
  end
  
  test "members added or removed should have group's roles added or removed" do
    without_access_control do
      # Set up data and ensure it looks correct
      group = entities(:groupWithARole)
      
      assert group.roles.length == 1, "looks like groupWithARole doesn't have its one role"
      
      assert @person.roles.length == 0, "Looks like our test user 'casuser' has roles already - somebody messed with the fixtures"
      assert @person.group_memberships.length == 0, "Looks like our test user 'casuser' has group memberships already - somebody messed with the fixtures"
      
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
  end
end
