require 'test_helper'

class Admin::ApiKeyUsersControllerTest < ActionController::TestCase
  test "queued jobs index requires admin access" do
    # Ensure unauthorized user has no access
    revoke_all_access
    assert (Authorization.current_user.role_symbols.include? :access) == false, "user should not have access role"
    assert (Authorization.current_user.role_symbols.include? :admin) == false, "user should not have admin role"
  
    get :index, :format => :json
    assert_response :unauthorized
    
    # Ensure authorized non-admin user has no access
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    Authorization.current_user = entities(:casuser)
    grant_test_user_basic_access
    revoke_test_user_admin_access
    
    get :index, :format => :json
    assert_response :forbidden
    
    # Ensure authorized admin users have access
    grant_test_user_admin_access
  
    get :index, :format => :json
    assert_response :success
  end
end
