require 'test_helper'

class ApplicationOwnershipTest < ActiveSupport::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    @person = entities(:casuser)
  end

  test "application associated with ownership appears in user's accessible_apps" do
    p = entities(:casuser)
    
    p.application_ownerships.destroy_all
    p.application_operatorships.destroy_all
    p.role_assignments.destroy_all
    
    grant_test_user_basic_access
    
    assert p.accessible_applications.include?(applications(:regular_app)) == false, "user should not have access to the regular_app yet"
    
    ao = ApplicationOwnership.new
    ao.entity = p
    ao.application = applications(:regular_app)
    ao.save!
    
    assert p.accessible_applications.include?(applications(:regular_app)), "user should have access to application just granted via ownership"
  end

  test "application ownership changes to a group should be reflected in group members' ownerships" do
    # Set up data and ensure it looks correct
    group = entities(:groupWithoutARole)
    
    group.application_ownerships.destroy_all
    assert group.application_ownerships.length == 0, "group should not have any ownerships"
    
    @person.application_ownerships.destroy_all
    assert @person.application_ownerships.length == 0, "test user 'casuser' should not have any application ownerships yet"
    @person.group_memberships.destroy_all
    assert @person.group_memberships.length == 0, "'casuser' should not have group memberships yet"
    
    # Assign the test user to this group with no application ownerships
    
    @person.groups << group
    assert @person.group_memberships.length == 1, "unable to add test user to group"
    
    @person.reload
    
    assert @person.application_ownerships.length == 0, "no ownerships should have been given to the user as the group had no ownerships"
    
    # Give the group an ownership and check that the user gets it
    ao = ApplicationOwnership.new
    ao.entity_id = group.id
    ao.application_id = applications(:regular_app).id
    ao.save!
    group.reload
    
    assert group.application_ownerships.length == 1, "application ownership on group failed"
    
    @person.reload
    
    assert @person.application_ownerships.length == 1, "application ownership assigned to group should have been assigned to group member"
    
    # Now remove that application ownership from the group and ensure the user loses it
    group.application_ownerships[0].destroy
    group.reload
    
    assert group.application_ownerships.length == 0, "application ownership removal on group failed"
    
    @person.reload
    assert @person.application_ownerships.length == 0, "application ownership removed from group should have been removed from group member"
  end
end
