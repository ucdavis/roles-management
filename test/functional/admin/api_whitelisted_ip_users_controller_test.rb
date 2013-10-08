require 'test_helper'

class Admin::ApiWhitelistedIpUsersControllerTest < ActionController::TestCase
  test "whitelisted IP users index requires admin access" do
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
  
  test "creating a whitelisted IP user requires admin access" do
    # Ensure unauthorized user is unable to create an API key user
    revoke_all_access
    assert (Authorization.current_user.role_symbols.include? :admin) == false, "user should not have admin role"
    
    post :create
    assert_response 302
    
    # Ensure authorized non-admin user has no access
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    Authorization.current_user = entities(:casuser)
    grant_test_user_basic_access
    
    post :create
    assert_response 302
    
    # Ensure authorized admin users have access
    grant_test_user_admin_access

    post :create, api_key_user: { name: 'Tester' }, :format => :json
    assert_response :created
  end
  
  test "deleting a whitelisted IP user requires admin access" do
    # Ensure unauthorized user is unable to create an API key user
    revoke_all_access
    assert (Authorization.current_user.role_symbols.include? :admin) == false, "user should not have admin role"
    
    delete :destroy, id: 1
    assert_response 302
    
    # Ensure authorized non-admin user has no access
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    Authorization.current_user = entities(:casuser)
    grant_test_user_basic_access
    
    delete :destroy, id: 1
    assert_response 302
    
    # Ensure authorized admin users have access
    grant_test_user_admin_access

    delete :destroy, id: 1
    assert_response 406
  end
end
