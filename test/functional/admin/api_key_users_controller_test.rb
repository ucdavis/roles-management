require 'test_helper'

class Admin::ApiKeyUsersControllerTest < ActionController::TestCase
  test "API key users index requires admin access (1/3)" do
    # Ensure unauthorized user has no access
    revoke_access
    
    get :index, :format => :json
    assert_response :unauthorized
  end

  test "API key users index requires admin access (2/3)" do    
    # Ensure authorized non-admin user has no access
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    grant_test_user_basic_access
    revoke_test_user_admin_access
    
    get :index, :format => :json
    assert_response :forbidden
  end
  
  test "API key users index requires admin access (3/3)" do
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    # Ensure authorized admin users have access
    grant_test_user_admin_access
  
    get :index, :format => :json
    assert_response :success
  end
  
  test "creating an API key user requires admin access (1/3)" do
    # Ensure unauthorized user is unable to create an API key user
    revoke_access
    
    post :create, api_key_user: { name: 'Tester' }, :format => :json
    assert_response :unauthorized
  end

  test "creating an API key user requires admin access (2/3)" do    
    # Ensure authorized non-admin user has no access
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    grant_test_user_basic_access
    revoke_test_user_admin_access
    
    post :create, api_key_user: { name: 'Tester' }, :format => :json
    assert_response :forbidden
  end
  
  test "creating an API key user requires admin access (3/3)" do
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    # Ensure authorized admin users have access
    grant_test_user_admin_access
  
    post :create, api_key_user: { name: 'Tester' }, :format => :json
    assert_response :created
  end
  
  test "deleting an API key requires admin access (1/3)" do
    # Ensure unauthorized user is unable to create an API key user
    revoke_access
    
    delete :destroy, id: 1, :format => :json
    assert_response :unauthorized
  end

  test "deleting an API key requires admin access (2/3)" do    
    # Ensure authorized non-admin user has no access
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    grant_test_user_basic_access
    revoke_test_user_admin_access
    
    delete :destroy, id: 1, :format => :json
    assert_response :forbidden
  end

  test "deleting an API key requires admin access (3/3)" do    
    CASClient::Frameworks::Rails::Filter.fake("casuser")
  
    # Ensure authorized admin users have access
    grant_test_user_admin_access
  
    delete :destroy, id: 1, :format => :json
    assert_response :success
  end
end
