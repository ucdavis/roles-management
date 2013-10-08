require 'test_helper'

class Admin::ApiKeyUsersControllerTest < ActionController::TestCase
  test "queued jobs index requires admin access" do
    # Ensure unauthorized user has no access
    revoke_all_access
    assert (Authorization.current_user.role_symbols.include? :admin) == false, "user should not have admin role"
  
    get :index
    assert_response 302
    
    # Ensure authorized non-admin user has no access
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    Authorization.current_user = entities(:casuser)
    grant_test_user_basic_access
    
    get :index
    assert_response 302
    
    # Ensure authorized admin users have access
    grant_test_user_admin_access
  
    get :index, :format => :json
    assert_response :success
  end
end
