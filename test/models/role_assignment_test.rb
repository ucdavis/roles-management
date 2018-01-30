require 'test_helper'

class RoleAssignmentTest < ActiveSupport::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake('casuser')

    @person = entities(:casuser)
  end

  test "role assignment changes to a group should be reflected in group members' roles" do
    # Set up data and ensure it looks correct
    group = entities(:groupWithoutARole)
    role = roles(:boring_role)

    assert group.roles.empty?, 'looks like groupWithoutARole actually has some roles - somebody messed with the fixtures'

    @person.role_assignments.destroy_all
    assert @person.roles.empty?, "Looks like our test user 'casuser' has roles already - somebody messed with the fixtures"

    @person.group_memberships.destroy_all
    assert @person.group_memberships.empty?, "'casuser' must not have group memberships for this test"

    # Assign the test user to this group with no roles
    GroupMembership.create!(entity_id: @person.id, group_id: group.id)
    @person.reload
    assert @person.group_memberships.length == 1, 'unable to add test user to group'

    @person.reload # Need to reload the person for the role assignment created in the RoleAssignment after_save callback to take effect

    assert @person.roles.empty?, 'no roles should have been given to the user as the group had no roles'

    # Give the group a role and check that the user gets it
    group.roles << role

    assert group.roles.length == 1, 'role assignment on group failed'

    @person.reload

    assert @person.roles.length == 1, 'role assigned to group should have been assigned to group member'

    # Now remove that role from the group and ensure the user loses it
    group.roles.delete(role)
    group.reload

    assert group.roles.empty?, 'role removal on group failed'

    @person.reload
    assert @person.roles.empty?, 'role removed from group should have been removed from group member'
  end

  test 'role assignments are immutable' do
    ra = RoleAssignment.new
    ra.entity_id = @person.id
    ra.role_id = roles(:boring_role).id
    ra.save!

    ra.role_id = 123
    assert ra.valid? == false
    assert ra.errors[:base][0].include? 'role_assignment.attributes.base.immutable'
  end
end
