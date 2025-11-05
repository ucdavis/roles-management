require 'test_helper'

class Admin::QueuedJobsControllerTest < ActionController::TestCase
  test "queued jobs index rejects non-admin access" do
    # Ensure unauthorized user has no access
    revoke_access

    get :index, as: :json
    assert_response :unauthorized

    # Ensure authorized non-admin user has no access
    fake_cas_login

    grant_test_user_basic_access
    revoke_test_user_admin_access

    get :index, as: :json
    assert_response :forbidden
  end

  test "queued jobs index accepts admin access" do
    # Ensure authorized admin users have access
    grant_test_user_admin_access

    fake_cas_login

    get :index, as: :json
    assert_response :success
  end

  test "queued jobs index requires admin access (1/3)" do
    # Ensure unauthorized user has no access
    revoke_access

    get :index, as: :json
    assert_response :unauthorized
  end

  test "queued jobs index requires admin access (2/3)" do
    # Ensure authorized non-admin user has no access
    fake_cas_login

    grant_test_user_basic_access
    revoke_test_user_admin_access

    get :index, as: :json
    assert_response :forbidden
  end

  test "queued jobs index requires admin access (3/3)" do
    fake_cas_login

    # Ensure authorized admin users have access
    grant_test_user_admin_access

    get :index, as: :json
    assert_response :success
  end
end
