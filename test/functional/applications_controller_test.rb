require 'test_helper'

# These tests are run using the fake CAS user 'casuser'
class ApplicationsControllerTest < ActionController::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")
  end

  test "valid cas user with no roles should get denied" do
    get :index
    assert Authorization.current_user.role_symbols.length == 0, "current_user should not have had any roles for this test"
    assert_redirected_to(:controller => "site", :action => "access_denied")
  end

  test "valid cas user with access role should get index" do
    grant_test_user_basic_access

    get :index

    assert_response :success
    assert_not_nil assigns(:applications)
  end
end
