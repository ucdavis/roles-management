require 'test_helper'

class RoleAssignmentTest < ActiveSupport::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")

    @person = entities(:casuser)
  end

  test "role assignment changes to a group should be reflected in group members' roles" do
    without_access_control do
      # Set up data and ensure it looks correct
      group = entities(:groupWithoutARole)
      role = roles(:boring_role)

      assert group.roles.length == 0, "looks like groupWithoutARole actually has some roles - somebody messed with the fixtures"

      @person.role_assignments.destroy_all
      assert @person.roles.length == 0, "Looks like our test user 'casuser' has roles already - somebody messed with the fixtures"

      @person.group_memberships.destroy_all
      assert @person.group_memberships.length == 0, "'casuser' must not have group memberships for this test"

      # Assign the test user to this group with no roles
      @person.groups << group
      assert @person.group_memberships.length == 1, "unable to add test user to group"

      @person.reload # Need to reload the person for the role assignment created in the RoleAssignment after_save callback to take effect

      assert @person.roles.length == 0, "no roles should have been given to the user as the group had no roles"

      # Give the group a role and check that the user gets it
      group.roles << role

      assert group.roles.length == 1, "role assignment on group failed"

      @person.reload

      assert @person.roles.length == 1, "role assigned to group should have been assigned to group member"

      # Now remove that role from the group and ensure the user loses it
      group.roles.delete(role)
      group.reload

      assert group.roles.length == 0, "role removal on group failed"

      @person.reload
      assert @person.roles.length == 0, "role removed from group should have been removed from group member"
    end
  end

  test "assigning a role fires off 'add_to_role' trigger" do
    without_access_control do
      p = entities(:casuser)
      r = roles(:boring_role)

      Sync.reset_trigger_test_counts

      assert p.roles.include?(r) == false, "casuser should not have boring_role at the start of the test"
      p.roles << r

      assert Sync.trigger_test_count(:add_to_role) == 1, "add_to_role should have been triggered"
    end
  end

  test "unassigning a role fires off 'remove_from_role' trigger" do
    without_access_control do
      p = entities(:casuser)
      r = roles(:boring_role)

      assert p.roles.include?(r) == false, "casuser should not have boring_role at the start of the test"
      p.roles << r

      Sync.reset_trigger_test_counts

      p.roles.delete(r)

      assert Sync.trigger_test_count(:remove_from_role) == 1, "remove_from_role should have been triggered"
    end
  end

  test "assigning/unassigning a role to a group should fire off add_to_role/remove_from_role for its group members" do
    without_access_control do
      Sync.reset_trigger_test_counts

      # Set up data and ensure it looks correct
      group = entities(:groupWithoutARole)
      role = roles(:boring_role)

      assert group.roles.length == 0, "looks like groupWithoutARole actually has some roles - somebody messed with the fixtures"
      assert group.members.length == 0, "looks like groupWithoutARole actually has some members - somebody messed with the fixtures"

      @person.role_assignments.destroy_all
      assert @person.roles.length == 0, "Looks like our test user 'casuser' has roles already - somebody messed with the fixtures"

      @person.group_memberships.destroy_all
      assert @person.group_memberships.length == 0, "'casuser' must not have group memberships for this test"

      # Assign the test user to this group with no roles
      @person.groups << group
      assert @person.group_memberships.length == 1, "unable to add test user to group"

      group.reload

      assert group.members.length == 1, "groupWithoutARole should have casuser as its only member"

      @person.reload # Need to reload the person for the role assignment created in the RoleAssignment after_save callback to take effect

      assert @person.roles.length == 0, "no roles should have been given to the user as the group had no roles"

      # Give the group a role and check that the user gets it
      group.roles << role

      assert group.roles.length == 1, "role assignment on group failed"

      @person.reload

      assert @person.roles.length == 1, "role assigned to group should have been assigned to group member"

      assert Sync.trigger_test_count(:add_to_role) == 1, "add_to_role should have been triggered"

      Sync.reset_trigger_test_counts

      # Now remove that role from the group and ensure the user loses it
      group.roles.delete(role)
      group.reload

      assert group.roles.length == 0, "role removal on group failed"

      @person.reload
      assert @person.roles.length == 0, "role removed from group should have been removed from group member"

      assert Sync.trigger_test_count(:remove_from_role) == 1, "remove_from_role should have been triggered but it is #{Sync.trigger_test_count(:remove_from_role)}"
    end
  end

  test "assigning/unassigning a role to a group should not fire off add_to_role/remove_from_role for an inactive group member" do
    assert false, "Test not implemented."
  end
end
