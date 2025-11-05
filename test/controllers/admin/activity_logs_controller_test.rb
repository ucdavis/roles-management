require 'test_helper'

class Admin::ActivityLogsControllerTest < ActionController::TestCase
  setup do
    @activity_log = activity_logs(:one)
  end

#   test "should get index" do
#     fake_cas_login
#     grant_test_user_admin_access
    
#     get :index, format: :json
#     assert_response :success
#     assert_not_nil assigns(:activity_logs)
#   end
end
