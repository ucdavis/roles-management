require 'test_helper'

# These tests are run using the fake CAS user 'casuser'
class Api::V1::BaseControllerTest < ActionController::TestCase
  test "validate should reutrn HTTP Success on valid key" do
    grant_api_user_access

    get :validate, :format => :json

    assert_response :success
  end

  test "validate should return HTTP Unauthorized on invalid key" do
    revoke_access

    get :validate, :format => :json

    assert_response :unauthorized
  end
end
