require 'test_helper'

class ApplicationOperatorshipTest < ActiveSupport::TestCase
  test "application associated with operatorship appears in user's accessible_apps" do
    Authorization.current_user = entities(:casuser)
    
    p = entities(:casuser)
    grant_test_user_basic_access
    
    without_access_control do
      p.application_ownerships.destroy_all
      p.application_operatorships.destroy_all
    end
    
    assert p.accessible_applications.length == 0, "user should not have any accessible applications at this point in the test #{p.accessible_applications.length}"
    
    without_access_control do
      ao = ApplicationOperatorship.new
      ao.entity = p
      ao.application = applications(:regular_app)
      ao.save!
    end
    
    assert p.accessible_applications.include?(applications(:regular_app)), "user should have access to application just granted via operatorship"
  end
end
