require 'test_helper'

class DatabasesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get ldap" do
    get :ldap
    assert_response :success
  end

end
