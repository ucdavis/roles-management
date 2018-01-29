require 'test_helper'

class ApplicationOperatorshipTest < ActiveSupport::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")

    @person = entities(:casuser)
  end

  test "application associated with operatorship appears in user's accessible_apps" do
    p = entities(:casuser)

    p.application_ownerships.destroy_all
    p.application_operatorships.destroy_all
    p.role_assignments.destroy_all

    grant_test_user_basic_access

    assert p.accessible_applications.include?(applications(:regular_app)) == false, "user should not be able to access applications(:regular_app) at this point"

    ao = ApplicationOperatorship.new
    ao.entity = p
    ao.application = applications(:regular_app)
    p.application_operatorships << ao

    assert p.accessible_applications.include?(applications(:regular_app)), "user should have access to application just granted via operatorship"
  end

  test "application operatorship changes to a group should be reflected in group members' operatorships" do
    # Set up data and ensure it looks correct
    group = entities(:groupWithoutARole)

    group.application_operatorships.destroy_all
    assert group.application_operatorships.length == 0, "group should not have any operatorships"

    @person.application_operatorships.destroy_all
    assert @person.application_operatorships.length == 0, "test user 'casuser' should not have any application operatorships yet"
    @person.group_memberships.destroy_all
    assert @person.group_memberships.length == 0, "'casuser' should not have group memberships yet"

    # Assign the test user to this group with no application ownerships
    GroupMembership.create!(entity_id: @person.id, group_id: group.id)
    @person.reload
    assert @person.group_memberships.length == 1, 'unable to add test user to group'

    @person.reload

    assert @person.application_operatorships.length == 0, "no operatorships should have been given to the user as the group had no ownerships"

    # Give the group an operatorship and check that the user gets it
    ao = ApplicationOperatorship.new
    ao.entity_id = group.id
    ao.application_id = applications(:regular_app).id
    ao.save!
    group.reload

    assert group.application_operatorships.length == 1, "application operatorship on group failed"

    @person.reload

    assert @person.application_operatorships.length == 1, "application operatorship assigned to group should have been assigned to group member"

    # Now remove that application ownership from the group and ensure the user loses it
    group.application_operatorships[0].destroy
    group.reload

    assert group.application_operatorships.length == 0, "application operatorship removal on group failed"

    @person.reload
    assert @person.application_operatorships.length == 0, "application operatorship removed from group should have been removed from group member"
  end

  test "adding/removing a user to a group with an operatorship should grant that user the operatorship" do
    # Set up data and ensure it looks correct
    group = entities(:groupWithAnApplicationOperatorship)

    assert group.application_operatorships.length == 1, "group should have one operatorship"
    assert group.members.length == 0, "group should have no members"

    @person.application_operatorships.destroy_all
    assert @person.application_operatorships.empty?, "test user 'casuser' should not have any application operatorships yet"
    @person.group_memberships.destroy_all
    assert @person.group_memberships.empty?, "'casuser' should not have group memberships yet"

    # Add the user to the group and ensure they gain the group's application operatorship
    GroupMembership.create!(group: group, entity: @person)

    assert group.members.length == 1, "group should now have one member"

    @person.reload

    assert @person.application_operatorships.length == 1, "test user should now have one application operatorship inherited from the group but instead has #{@person.application_operatorships.length}"

    # Now remove the user from the group and ensure the inherited application operatorship goes away
    @person.group_memberships.destroy_all
    assert @person.group_memberships.empty?, "'casuser' should not have group memberships now"

    @person.reload

    assert @person.application_operatorships.empty?, "test user should no longer have an application operatorship but instead has #{@person.application_operatorships.length}"
  end

  test "universal operators are able to assign a person to a role in applications they otherwise do not own or operate" do
    revoke_test_user_basic_access
    revoke_test_user_admin_access
    grant_test_user_operate_access

    an_app = applications(:regular_app)
    an_app_role = roles(:boring_role)

    # Ensure 'casuser' is not an owner or operator
    an_app.owners.destroy @person if an_app.owners.include? @person
    an_app.operators.destroy @person if an_app.operators.include? @person

    assert @person.role_symbols.include?(:operate), "casuser should be a universal operator"
    assert @person.role_symbols.length == 1, "casuser should only be a universal operator"

    random_person = entities(:personWithNothing)

    an_app_role.members << random_person
  end
end
