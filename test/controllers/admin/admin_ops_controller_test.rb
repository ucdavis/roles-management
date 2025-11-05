require 'test_helper'

class Admin::OpsControllerTest < ActionController::TestCase
  test 'admin access required impersonating' do
    # Ensure unauthorized user has no access
    revoke_access

    get 'impersonate', params: { loginid: 'someone' }, as: :json
    assert_response 401

    # Ensure authorized non-admin user has no access
    fake_cas_login

    grant_test_user_basic_access
    revoke_test_user_admin_access

    get 'impersonate', params: { loginid: 'someone' }, as: :json
    assert_response 403
  end

  test 'admins can impersonate' do
    fake_cas_login

    # Ensure authorized admin users have access
    grant_test_user_admin_access

    get 'impersonate', params: { loginid: 'someone' }
    assert_response :redirect
  end
end
