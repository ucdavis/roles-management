require 'test_helper'

class ApplicationOwnershipTest < ActiveSupport::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake('casuser')

    @person = entities(:casuser)
  end

  test "application associated with ownership appears in user's accessible_apps" do
    p = entities(:casuser)

    p.application_ownerships.all.each do |ao|
      ApplicationsService.revoke_application_ownership(ao)
    end
    p.application_operatorships.all.each do |ao|
      ApplicationsService.revoke_application_operatorship(ao)
    end
    p.role_assignments.all.each do |ra|
      RoleAssignmentsService.unassign_role_from_entity(ra)
    end

    grant_test_user_basic_access

    assert p.accessible_applications.include?(applications(:regular_app)) == false, "user should not have access to the regular_app yet"

    ApplicationsService.grant_application_ownership(applications(:regular_app), p)

    assert p.accessible_applications.include?(applications(:regular_app)), "user should have access to application just granted via ownership"
  end

  test "application ownership changes to a group should be reflected in group members' ownerships" do
    # Set up data and ensure it looks correct
    group = entities(:groupWithoutARole)

    group.application_ownerships.all.each do |ao|
      ApplicationsService.revoke_application_ownership(ao)
    end
    assert group.application_ownerships.length == 0, "group should not have any ownerships"

    @person.application_ownerships.all.each do |ao|
      ApplicationsService.revoke_application_ownership(ao)
    end
    assert @person.application_ownerships.length == 0, "test user 'casuser' should not have any application ownerships yet"
    @person.group_memberships.all.each do |gm|
      GroupMembershipsService.remove_member_from_group(@person, gm.group)
    end
    assert @person.group_memberships.length == 0, "'casuser' should not have group memberships yet"

    # Assign the test user to this group with no application ownerships
    GroupMembershipsService.assign_member_to_group(@person, group)
    @person.reload
    group.reload
    assert @person.group_memberships.length == 1, 'unable to add test user to group'

    assert @person.application_ownerships.length == 0, "no ownerships should have been given to the user as the group had no ownerships"

    # Give the group an ownership and check that the user gets it
    ApplicationsService.grant_application_ownership(applications(:regular_app), group)
    group.reload

    assert group.application_ownerships.length == 1, "application ownership on group failed"

    @person.reload

    assert @person.application_ownerships.length == 1, "application ownership assigned to group should have been assigned to group member"

    # Now remove that application ownership from the group and ensure the user loses it
    ApplicationsService.revoke_application_ownership(group.application_ownerships[0])
    group.reload

    assert group.application_ownerships.length == 0, "application ownership removal on group failed"

    @person.reload
    assert @person.application_ownerships.length == 0, "application ownership removed from group should have been removed from group member"
  end
end
