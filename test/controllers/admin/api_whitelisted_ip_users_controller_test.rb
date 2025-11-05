require 'test_helper'

class Admin::ApiWhitelistedIpUsersControllerTest < ActionController::TestCase
  test 'unauthenticated users cannot access whitelisted IP users index' do
    # Ensure unauthorized user has no access
    revoke_access

    get :index, as: :json
    assert_response :unauthorized
  end

  test 'authenticated but unauthorized users cannot access whitelisted IP users index' do
    # Ensure authorized non-admin user has no access
    fake_cas_login

    grant_test_user_basic_access
    revoke_test_user_admin_access

    get :index, as: :json
    assert_response :forbidden
  end

  test 'authorized admin users can access whitelisted IP users index' do
    # Ensure authorized admin users have access
    fake_cas_login
    grant_test_user_admin_access

    get :index, as: :json
    assert_response :success
  end

  test "creating a whitelisted IP user requires admin access" do
    # Ensure unauthorized user is unable to create an API key user
    revoke_access

    post :create, params: { api_whitelisted_ip_user: { name: 'Tester' } }, as: :json
    assert_response :unauthorized

    # Ensure authorized non-admin user has no access
    fake_cas_login

    grant_test_user_basic_access
    revoke_test_user_admin_access

    post :create, params: { api_whitelisted_ip_user: { name: 'Tester' } }, as: :json
    assert_response :forbidden

    # Ensure authorized admin users have access
    grant_test_user_admin_access

    post :create, params: { api_whitelisted_ip_user: { name: 'Tester' } }, as: :json
    assert_response :created
  end

  test 'unauthenticated user cannot delete a whitelisted IP user' do
    # Ensure unauthorized user is unable to create an API key user
    revoke_access

    delete :destroy, params: { id: 1 }, as: :json
    assert_response :unauthorized
  end

  test 'unauthorized but authenticated user cannot delete a whitelisted IP user' do
    # Ensure authorized non-admin user has no access
    fake_cas_login

    grant_test_user_basic_access
    revoke_test_user_admin_access

    delete :destroy, params: { id: 1 }, as: :json
    assert_response :forbidden
  end

  test 'authorized users can delete a whitelisted IP user' do
    fake_cas_login

    # Ensure authorized admin users have access
    grant_test_user_admin_access

    delete :destroy, params: { id: 1 }, as: :json
    assert_response :success
  end
end
