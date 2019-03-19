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
    GroupMembershipsService.assign_member_to_group(@person, group)
    @person.reload
    assert @person.group_memberships.length == 1, 'unable to add test user to group'

    @person.reload # Need to reload the person for the role assignment created in the RoleAssignment after_save callback to take effect

    assert @person.roles.empty?, 'no roles should have been given to the user as the group had no roles'

    # Give the group a role and check that the user gets it
    RoleAssignmentsService.assign_role_to_entity(group, role)

    assert group.roles.length == 1, 'role assignment on group failed'

    @person.reload

    assert @person.roles.length == 1, 'role assigned to group should have been assigned to group member'

    # Now remove that role from the group and ensure the user loses it
    RoleAssignmentsService.unassign_role_from_entity(group.role_assignments[0])
    group.reload

    assert group.roles.empty?, 'role removal on group failed'

    @person.reload
    assert @person.roles.empty?, 'role removed from group should have been removed from group member'
  end

  test 'role assignments are immutable' do
    ra = RoleAssignmentsService.assign_role_to_entity(@person, roles(:boring_role))

    ra.role_id = 123
    assert ra.valid? == false
    assert ra.errors[:base][0].include? 'role_assignment.attributes.base.immutable'
  end

  test 'person attribute changes which causes group removal should also cause role assignment removal' do
    # person matches a group based on pps affiliation (department)

    # person should have the roles from that group

    # person loses that pps affiliation

    # person should fall out of that group

    # person should also lose those roles
    # assert false
  end

  # # TODO: This test should pass once the audit_inherited_roles issue is taken care of.
  # test "group changes which cause group removal also cause role assignment removal" do
  #   # Ensure a group has a rule
  #   group = entities(:groupWithNothing)

  #   assert group.roles.empty?, 'looks like groupWithNothing has a role'
  #   assert group.rules.empty?, 'looks like groupWithNothing has a rule'
  #   assert group.owners.empty?, 'looks like groupWithNothing has an owner'
  #   assert group.operators.empty?, 'looks like groupWithNothing has an operator'

  #   # Give group a role
  #   role = roles(:boring_role)
  #   RoleAssignmentsService.assign_role_to_entity(group, role)

  #   assert group.roles.include?(role), 'looks like groupWithNothing does not have its role'
  #   assert @person.roles.include?(role) == false, 'looks like person has the role'

  #   # Give person a PPS association so we can match them, then ensure 'login is not' works
  #   title = titles(:programmer)
  #   department = departments(:dssit)

  #   @person.pps_associations.destroy_all
  #   assert @person.pps_associations.count.zero?
  #   pps_association = PpsAssociation.new
  #   pps_association.person_id = @person.id
  #   pps_association.title = title
  #   pps_association.department = department
  #   pps_association.admin_department = department
  #   pps_association.appt_department = department
  #   pps_association.association_rank = 1
  #   pps_association.position_type_code = 2
  #   assert pps_association.valid?
  #   @person.pps_associations << pps_association
  #   assert @person.pps_associations.length == 1

  #   # Test login ID rules
  #   assert group.members.empty?, 'group should have no members'

  #   Rails.logger.debug 'Group is about to gain role'

  #   group_rule = GroupRule.new(column: 'title', condition: 'is', value: titles(:programmer).name, group_id: group.id)
  #   group.rules << group_rule

  #   group.reload

  #   assert group.members.length == 1, 'group should have a member'

  #   @person.reload
  #   assert @person.roles.include?(role), 'looks like person does not have the role'

  #   group_rule = GroupRule.new(column: 'loginid', condition: 'is not', value: @person.loginid, group_id: group.id)
  #   group.rules << group_rule

  #   group.reload

  #   assert group.members.empty?, 'group should have no members'
  # end
end
