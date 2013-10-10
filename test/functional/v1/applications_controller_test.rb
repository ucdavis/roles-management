require 'test_helper'

class Api::V1::ApplicationsControllerTest < ActionController::TestCase
  setup do
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(api_key_users(:apiuser).name, api_key_users(:apiuser).secret)
  end

  # test "JSON index request should include certain attributes" do
  #   grant_test_user_admin_access
  # 
  #   get :index, :format => :json
  # 
  #   body = JSON.parse(response.body)[0]
  # 
  #   assert body.include?('id'), 'JSON response does not include id field'
  #   assert body.include?('name'), 'JSON response does not include name field'
  #   refute body.include?('description'), 'JSON response does not include description field'
  #   assert body.include?('roles'), 'JSON response should include roles'
  #   
  #   # body['roles'] should include entities which include name and id (for frontend interface role assignment, applicaiton saving, and new role creation saving (temp ID -> real ID), etc.)
  #   body['roles'].each do |r|
  #     assert r["id"], "JSON response's 'roles' section should include an ID field"
  #     refute r["name"], "JSON response's 'roles' section should not include a name field"
  #     assert r["token"], "JSON response's 'roles' section should include a token field"
  #     refute r["description"], "JSON response's 'roles' section should not include a description field"
  #     # ad_path may be nil so check for existence not value
  #     assert r.has_key?("ad_path"), "JSON response's 'roles' section should include an ad_path field"
  #   end
  # 
  #   assert body["owners"], "JSON response should include an 'owners' section"
  #   body["owners"].each do |o|
  #     pp o
  #     assert o["id"], "JSON response's 'owners' section should include an ID"
  #     assert o["name"], "JSON response's 'owners' section should include a name"
  #   end
  # 
  #   assert body["operators"], "JSON response should include an 'operators' section"    
  #   body["operators"].each do |o|
  #     assert o["id"], "JSON response's 'roles' section's 'members' should include an ID"
  #     assert o["name"], "JSON response's 'roles' section's 'members' should include a name"
  #   end
  # end
  # 
  # test "JSON index request should not include disabled entities" do
  #   disabledEntity = entities(:disabledPerson)
  # 
  #   grant_test_user_admin_access
  # 
  #   get :index, :format => :json
  # 
  #   applications = JSON.parse(response.body)
  #   
  #   applications.each do |a|
  #     a["owners"].each do |o|
  #       assert o["id"].to_i != disabledEntity.id, "JSON response should not include disabled entity"
  #     end
  # 
  #     a["operators"].each do |o|
  #       assert o["id"].to_i != disabledEntity.id, "JSON response should not include disabled entity"
  #     end
  #   end
  # end
  # 
  # test "JSON show request should include certain attributes" do
  #   grant_test_user_admin_access
  # 
  #   get :show, :format => :json, :id => '1'
  # 
  #   body = JSON.parse(response.body)
  # 
  #   assert body.include?('id'), 'JSON response does not include id field'
  #   assert body.include?('name'), 'JSON response does not include name field'
  #   assert body.include?('description'), 'JSON response does not include description field'
  #   assert body.include?('url'), 'JSON response does not include url field'
  #   assert body.include?('icon'), 'JSON response does not include icon field'
  #   assert body.include?('roles'), 'JSON response should include roles'
  #   
  #   # body['roles'] should include entities which include name and id (for frontend interface role assignment, applicaiton saving, and new role creation saving (temp ID -> real ID), etc.)
  #   body['roles'].each do |r|
  #     assert r["id"], "JSON response's 'roles' section should include an ID field"
  #     refute r["name"], "JSON response's 'roles' section should not include a name field"
  #     assert r["token"], "JSON response's 'roles' section should include a token field"
  #     refute r["description"], "JSON response's 'roles' section should not include a description field"
  #     # ad_path may be nil so check for existence not value
  #     assert r.has_key?("ad_path"), "JSON response's 'roles' section should include an ad_path field"
  #   end
  # 
  #   assert body["owners"], "JSON response should include an 'owners' section"
  #   body["owners"].each do |o|
  #     assert o["id"], "JSON response's 'owners' section's 'members' should include an ID"
  #     assert o["name"], "JSON response's 'owners' section's 'members' should include a name"
  #   end
  # 
  #   assert body["operators"], "JSON response should include an 'operators' section"    
  #   body["operators"].each do |o|
  #     assert o["id"], "JSON response's 'roles' section's 'members' should include an ID"
  #     assert o["name"], "JSON response's 'roles' section's 'members' should include a name"
  #   end
  # end
  
  test "JSON show request should not include disabled entities" do
    disabledEntity = entities(:disabledPerson)

    assert disabledEntity.application_ownerships.length > 0, "disabled entity fixture needs at least one application ownership"
    assert disabledEntity.application_operatorships.length > 0, "disabled entity fixture needs at least one application operatorship"

    grant_test_user_admin_access

    get :show, :format => :json, :id => disabledEntity.application_ownerships[0].id

    application = JSON.parse(response.body)

    application["owners"].each do |o|
      assert o["id"].to_i != disabledEntity.id, "JSON response should not include disabled entity"
    end

    get :show, :format => :json, :id => disabledEntity.application_operatorships[0].id

    application = JSON.parse(response.body)

    application["operators"].each do |o|
      assert o["id"].to_i != disabledEntity.id, "JSON response should not include disabled entity"
    end
  end
end
