require 'test_helper'

class Admin::OpsControllerTest < ActionController::TestCase
  test "admin access required for AD path check" do
    # Ensure unauthorized user has no access
    revoke_all_access
    assert (Authorization.current_user.role_symbols.include? :access) == false, "user should not have access role"
    assert (Authorization.current_user.role_symbols.include? :admin) == false, "user should not have admin role"
      
    get :ad_path_check, { path: 'somewhere', format: :json }
    assert_response 401
    
    # Ensure authorized non-admin user has no access
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    Authorization.current_user = entities(:casuser)
    grant_test_user_basic_access
    revoke_test_user_admin_access
    
    get :ad_path_check, { path: 'somewhere', format: :json }
    assert_response 403
    
    # Ensure authorized admin users have access
    grant_test_user_admin_access
  
    get :ad_path_check, { path: 'somewhere', format: :json }
    assert_response :success
  end

  test "admin access required impersonating" do
    # Ensure unauthorized user has no access
    revoke_all_access
    assert (Authorization.current_user.role_symbols.include? :access) == false, "user should not have access role"
    assert (Authorization.current_user.role_symbols.include? :admin) == false, "user should not have admin role"
    
    get "impersonate", loginid: 'someone'
    assert_response :redirect
    
    # Ensure authorized non-admin user has no access
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    Authorization.current_user = entities(:casuser)
    grant_test_user_basic_access
    revoke_test_user_admin_access
    
    get "impersonate", loginid: 'someone'
    assert_response 406
    
    # Ensure authorized admin users have access
    grant_test_user_admin_access
  
    get "impersonate", loginid: 'someone'
    assert_response :redirect
  end
  
  # test "admin access required for unimpersonating" do
  #   
  #   assert false
  # end
end
