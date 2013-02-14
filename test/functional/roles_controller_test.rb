require 'test_helper'

# These tests are run using the fake CAS user 'casuser'
class RolesControllerTest < ActionController::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")
  end

  test "JSON request should include certain attributes" do
    grant_test_user_basic_access

    get :show, :format => :json, :id => '1'

    body = JSON.parse(response.body)

    puts body

    assert body.include?('id'), 'JSON response does not include id field'
    assert body.include?('token'), 'JSON response does not include token field'
    assert body.include?('name'), 'JSON response does not include name field'
    assert body.include?('application_id'), 'JSON response does not include application_id field'
    assert body.include?('description'), 'JSON response should include description'
    assert body.include?('entities'), 'JSON response should include entities'
  end
end
