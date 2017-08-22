require 'test_helper'

class OrganizationsControllerTest < ActionController::TestCase
  setup do
    @organization = organizations(:toplevel)
    revoke_access
    CASClient::Frameworks::Rails::Filter.fake('casuser')
    revoke_rm_permissions
  end

  test 'unauthenticated user should get no index' do
    get :index, as: :json
    assert_response 302
  end

  test 'should get index' do
    grant_test_user_basic_access
    get :index, as: :json
    assert_response :success
  end

  test 'index should search' do
    grant_test_user_basic_access
    get :index, params: { 'q' => 'Office of Top-Level Org' }, as: :json
    assert_response :success

    body = JSON.parse(response.body)

    assert body.length == 1, 'should only return a single result'
  end

  test 'should not have create action' do
    grant_test_user_basic_access

    begin
      assert_difference('Organization.count') do
        post :create, params: { organization: { dept_code: @organization.dept_code, name: @organization.name } }
      end
    rescue AbstractController::ActionNotFound
      # This is good.
    end
  end

  test 'should show organization' do
    grant_test_user_basic_access
    get :show, params: { id: @organization }, as: :json
    assert_response :success
  end

  test 'should not have update action' do
    grant_test_user_basic_access

    begin
      put :update, params: { id: @organization, organization: { dept_code: @organization.dept_code, name: @organization.name } }
      assert_redirected_to organization_path(assigns(:organization))
    rescue AbstractController::ActionNotFound
      # This is good.
    end
  end

  test "should not have destroy action" do
    grant_test_user_basic_access

    begin
      assert_difference('Organization.count', -1) do
        delete :destroy, params: { id: @organization }
      end

      assert_redirected_to organizations_path
    rescue AbstractController::ActionNotFound
      # This is good.
    end
  end
end
