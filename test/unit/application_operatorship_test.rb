require 'test_helper'

class ApplicationOperatorshipTest < ActiveSupport::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    @person = entities(:casuser)
  end

  test "application associated with operatorship appears in user's accessible_apps" do
    Authorization.current_user = entities(:casuser)
    
    p = entities(:casuser)
    
    without_access_control do
      p.application_ownerships.destroy_all
      p.application_operatorships.destroy_all
      p.role_assignments.destroy_all
    end
    
    grant_test_user_basic_access
    
    assert p.accessible_applications.include?(applications(:regular_app)) == false, "user should not be able to access applications(:regular_app) at this point"
    
    without_access_control do
      ao = ApplicationOperatorship.new
      ao.entity = p
      ao.application = applications(:regular_app)
      p.application_operatorships << ao
    end
    
    assert p.accessible_applications.include?(applications(:regular_app)), "user should have access to application just granted via operatorship"
  end

  test "application operatorship changes to a group should be reflected in group members' operatorships" do
    without_access_control do
      # Set up data and ensure it looks correct
      group = entities(:groupWithoutARole)
      
      group.application_operatorships.destroy_all
      assert group.application_operatorships.length == 0, "group should not have any operatorships"
      
      @person.application_operatorships.destroy_all
      assert @person.application_operatorships.length == 0, "test user 'casuser' should not have any application operatorships yet"
      @person.group_memberships.destroy_all
      assert @person.group_memberships.length == 0, "'casuser' should not have group memberships yet"
      
      # Assign the test user to this group with no application ownerships
      
      @person.groups << group
      assert @person.group_memberships.length == 1, "unable to add test user to group"
      
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
  end
end
