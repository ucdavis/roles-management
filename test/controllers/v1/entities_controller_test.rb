require 'test_helper'

# These tests are run using the fake CAS user 'casuser'
class Api::V1::EntitiesControllerTest < ActionController::TestCase
#   test "unauthenticated user should redirected to cas" do
#     revoke_access

#     assert @request.env['REMOTE_ADDR'] != '1.2.3.4'
#     assert session[:auth_via] != :cas, "authentication should not be set"

#     # We have to pass 'auth_via' as '' to ensure it is set to an empty string
#     # in the session. Deleting session keys doesn't appear to work nor does
#     # setting 'auth_via' to nil. I'd love to know why.
#     get :index, nil, { 'auth_via' => '' }, nil

#     assert_response 403
#   end

  test "valid API whitelisted user should get index" do
    grant_whitelisted_access

    get :index, :format => :json

    assert_response :success
    assert_not_nil assigns(:entities)
  end

#   # loginid required for: impersonate dialog, group rule "loginid is"
#   # id, name, loginid, email, roles included as per published API spec
#   # Should also respond to /people/loginid.json
#   test 'JSON index request should include certain attributes' do
#     grant_api_user_access

#     get :index, :format => :json

#     body = JSON.parse(response.body)[0]

#     assert body.include?('id'), 'JSON response should include id field'
#     assert body.include?('name'), 'JSON response should include name field'
#     assert body.include?('type'), 'JSON response should include type field'
#     assert body.include?('loginid'), 'JSON response should include loginid field'
#     assert body.include?('member_count'), 'JSON response should include member_count field'
#   end

#   test 'JSON show request should include certain attributes when entity is a person' do
#     grant_api_user_access

#     get :show, :format => :json, :id => 1

#     body = JSON.parse(response.body)

#     assert body.include?('id'), 'JSON response should include id field'
#     assert body.include?('name'), 'JSON response should include name field'
#     assert body.include?('type'), 'JSON response should include type field'
#     assert body.include?('email'), 'JSON response should include email field'
#     assert body.include?('loginid'), 'JSON response should include loginid field'

#     refute body.include?('members'), 'JSON response should not include members'
#   end

#   test 'JSON show request should include certain attributes when entity is a group' do
#     grant_api_user_access

#     get :show, :format => :json, :id => 2

#     body = JSON.parse(response.body)

#     assert body.include?('id'), 'JSON response should include id field'
#     assert body.include?('name'), 'JSON response should include name field'
#     assert body.include?('type'), 'JSON response should include type field'
#     refute body.include?('loginid'), 'JSON response should not include loginid field'

#     assert body.include?('members'), 'JSON response should include members'
#     body["members"].each do |m|
#       assert m["id"], "JSON response's 'members' section should include an id"
#       assert m["type"], "JSON response's 'members' section should include a type"
#     end
#   end

#   test "JSON index request should not include inactive entities" do
#     grant_api_user_access

#     get :index, :format => :json

#     inactiveEntity = entities(:inactivePerson)

#     entities = JSON.parse(response.body)

#     entities.each do |e|
#       assert e["id"].to_i != inactiveEntity.id, 'JSON response should not include inactive entities'
#     end
#   end

#   test "JSON show request should not include inactive entities" do
#     grant_api_user_access

#     inactiveEntity = entities(:inactivePerson)

#     get :show, :format => :json, :id => inactiveEntity.id

#     assert_response :missing
#   end
end
