require 'test_helper'

class Admin::ActivityLogsControllerTest < ActionController::TestCase
  setup do
    @activity_log = activity_logs(:one)
  end

  test "should get index" do
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    grant_test_user_admin_access
    
    get :index, format: :json
    assert_response :success
    assert_not_nil assigns(:activity_logs)
  end
end
