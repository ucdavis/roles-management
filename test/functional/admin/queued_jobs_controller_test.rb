require 'test_helper'

class Admin::QueuedJobsControllerTest < ActionController::TestCase
  test "queued jobs index rejects non-admin access" do
    # Ensure unauthorized user has no access
    revoke_access
    
    get :index, :format => :json
    assert_response :unauthorized
    
    # Ensure authorized non-admin user has no access
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    grant_test_user_basic_access
    revoke_test_user_admin_access
    
    get :index, :format => :json
    assert_response :forbidden
  end

  test "queued jobs index accepts admin access" do
    # Ensure authorized admin users have access
    grant_test_user_admin_access

    CASClient::Frameworks::Rails::Filter.fake("casuser")
  
    get :index, :format => :json
    assert_response :success
  end

#   test "queued jobs index requires admin access" do
#     # Ensure unauthorized user has no access
#     revoke_access
    
#     get :index, :format => :json
#     assert_response :unauthorized
    
#     # Ensure authorized non-admin user has no access
#     CASClient::Frameworks::Rails::Filter.fake("casuser")
    
#     grant_test_user_basic_access
#     revoke_test_user_admin_access
    
#     get :index, :format => :json
#     assert_response :forbidden
    
#     # Ensure authorized admin users have access
#     grant_test_user_admin_access
    
#     Rails.logger.info "getting index for SUCCESS"
#     Rails.logger.info Person.find_by_loginid('casuser').roles.length
    
#     byebug
  
#     get :index, :format => :json
#     assert_response :success
#   end
end
