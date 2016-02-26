require 'test_helper'

class Admin::ApiKeyUsersControllerTest < ActionController::TestCase
  test "API key users index requires admin access" do
    # Ensure unauthorized user has no access
    revoke_access
    
    # assert (Authorization.current_user.role_symbols.include? :access) == false, "user should not have access role"
    # assert (Authorization.current_user.role_symbols.include? :admin) == false, "user should not have admin role"
  
    get :index, :format => :json
    assert_response :unauthorized
    
    # Ensure authorized non-admin user has no access
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    grant_test_user_basic_access
    revoke_test_user_admin_access
    
    # assert (Authorization.current_user.role_symbols.include? :access) == true, "user should have access role"
    # assert (Authorization.current_user.role_symbols.include? :admin) == false, "user should not have admin role"
    
    get :index, :format => :json
    assert_response :forbidden
    
    # Ensure authorized admin users have access
    grant_test_user_admin_access
  
    get :index, :format => :json
    assert_response :success
  end
  
  test "creating an API key user requires admin access" do
    # Ensure unauthorized user is unable to create an API key user
    revoke_access
    
    # assert (Authorization.current_user.role_symbols.include? :access) == false, "user should not have access role"
    # assert (Authorization.current_user.role_symbols.include? :admin) == false, "user should not have admin role"
    
    post :create, api_key_user: { name: 'Tester' }, :format => :json
    assert_response :unauthorized
    
    # Ensure authorized non-admin user has no access
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    grant_test_user_basic_access
    revoke_test_user_admin_access
    
    post :create, api_key_user: { name: 'Tester' }, :format => :json
    assert_response :forbidden
    
    # Ensure authorized admin users have access
    grant_test_user_admin_access
  
    post :create, api_key_user: { name: 'Tester' }, :format => :json
    assert_response :created
  end
  
  test "deleting an API key requires admin access" do
    # Ensure unauthorized user is unable to create an API key user
    revoke_access
    
    # assert (Authorization.current_user.role_symbols.include? :access) == false, "user should not have access role"
    # assert (Authorization.current_user.role_symbols.include? :admin) == false, "user should not have admin role"
    
    delete :destroy, id: 1, :format => :json
    assert_response :unauthorized
    
    # Ensure authorized non-admin user has no access
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    grant_test_user_basic_access
    revoke_test_user_admin_access
    
    delete :destroy, id: 1, :format => :json
    assert_response :forbidden
    
    # Ensure authorized admin users have access
    grant_test_user_admin_access
  
    delete :destroy, id: 1, :format => :json
    assert_response :success
  end
end
