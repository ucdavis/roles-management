require 'test_helper'

# These tests are run using the fake CAS user 'casuser'
class EntitiesControllerTest < ActionController::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake('casuser')

    @person = entities(:casuser)
    @group = entities(:groupA)
  end

  # Sidebar search needs to show inactive entities
  test 'JSON index search request includes inactive entities' do
    grant_test_user_admin_access

    # Last name 'Natinabled' is marked inactive in fixture
    get :index, params: { q: 'Natinabled' }, as: :json

    body = JSON.parse(response.body)

    found_inactive = false

    body.each do |entity|
      assert entity.include?('id'), 'JSON response should include id field'
      assert entity.include?('name'), 'JSON response should include name field'
      assert entity.include?('active'), 'JSON response should include active field'

      if entity['active'] == false
        found_inactive = true
        break
      end
    end

    assert found_inactive == true, 'should have found at least one inactive entity'
  end

  test 'JSON show request for a Group should include certain attributes' do
    grant_test_user_admin_access

    get :show, params: { :id => @group.id }, as: :json

    body = JSON.parse(response.body)

    assert body.include?('id'), 'JSON response should include id field'
    assert body.include?('name'), 'JSON response should include name field'
    assert body.include?('description'), 'JSON response should include description field'
    assert body.include?('type'), 'JSON response should include type field'

    assert body.include?('memberships'), 'JSON response should include memberships'
    body['memberships'].each do |m|
      assert m.key?("calculated"), "JSON response's 'memberships' section should include a calculated flag"
      assert m["entity_id"], "JSON response's 'memberships' section should include an entity_id"
      assert m["id"], "JSON response's 'memberships' section should include a id"
      assert m.key?("loginid"), "JSON response's 'memberships' section should include a loginid"
      assert m["name"], "JSON response's 'memberships' section should include a name"
    end

    assert body.include?('operators'), 'JSON response should include operators'
    body["operators"].each do |o|
      assert o["id"], "JSON response's 'operators' section should include id"
      assert o["loginid"], "JSON response's 'operators' section should include loginid"
      assert o["name"], "JSON response's 'operators' section should include name"
    end

    assert body.include?('owners'), 'JSON response should include owners'
    body["owners"].each do |o|
      assert o["id"], "JSON response's 'owners' section should include id"
      assert o["loginid"], "JSON response's 'owners' section should include loginid"
      assert o["name"], "JSON response's 'owners' section should include name"
    end

    assert body.include?('rules'), 'JSON response should include rules'
    body["rules"].each do |r|
      assert r["id"], "JSON response's 'rules' section should include a name"
      assert r["column"], "JSON response's 'rules' section should include column"
      assert r["condition"], "JSON response's 'rules' section should include condition"
      assert r["value"], "JSON response's 'rules' section should include value"
    end
  end

  test 'JSON show request for a Person should include certain attributes' do
    grant_test_user_admin_access

    get :show, params: { :id => @person.id }, as: :json

    body = JSON.parse(response.body)

    assert body.include?('id'), 'JSON response should include id field'
    assert body.include?('name'), 'JSON response should include name field'
    assert body.include?('type'), 'JSON response should include type field'
    assert body.include?('active'), 'JSON response should include active field'
    assert body.include?('address'), 'JSON response should include address field'
    assert body.include?('byline'), 'JSON response should include byline field'
    assert body.include?('email'), 'JSON response should include email field'
    assert body.include?('first'), 'JSON response should include first field'
    assert body.include?('last'), 'JSON response should include last field'
    assert body.include?('loginid'), 'JSON response should include loginid field'
    assert body.include?('phone'), 'JSON response should include phone field'

    assert body.include?('favorites'), 'JSON response should include favorites'
    body['favorites'].each do |f|
      assert f["id"], "JSON response's 'favorites' section should include a id"
      assert f["type"], "JSON response's 'favorites' section should include a type"
      assert f["name"], "JSON response's 'favorites' section should include a name"
    end

    assert body.include?('group_memberships'), 'JSON response should include group_memberships'
    body["group_memberships"].each do |m|
      assert m["id"], "JSON response's 'group_memberships' section should include id"
      assert m["group_id"], "JSON response's 'group_memberships' section should include group_id"
      assert m.key?("calculated"), "JSON response's 'group_memberships' section should include calculated"
      assert m["name"], "JSON response's 'group_memberships' section should include name"
    end

    assert body.include?('group_operatorships'), 'JSON response should include group_operatorships'
    body["group_operatorships"].each do |m|
      assert m["id"], "JSON response's 'group_operatorships' section should include id"
      assert m["group_id"], "JSON response's 'group_operatorships' section should include group_id"
      assert m["name"], "JSON response's 'group_operatorships' section should include name"
    end

    assert body.include?('group_ownerships'), 'JSON response should include group_ownerships'
    body["group_ownerships"].each do |m|
      assert m["id"], "JSON response's 'group_ownerships' section should include id"
      assert m["group_id"], "JSON response's 'group_ownerships' section should include group_id"
      assert m["name"], "JSON response's 'group_ownerships' section should include name"
    end

    assert body.include?('organizations'), 'JSON response should include organizations'
    body["organizations"].each do |o|
      assert o["id"], "JSON response's 'organizations' section should include id"
      assert o["name"], "JSON response's 'organizations' section should include name"
    end

    assert body.include?('role_assignments'), 'JSON response should include role_assignments'
    body["role_assignments"].each do |a|
      assert a["application_id"], "JSON response's 'role_assignments' section should include application_id"
      assert a["application_name"], "JSON response's 'role_assignments' section should include application_name"
      assert a.key?("calculated"), "JSON response's 'role_assignments' section should include calculated"
      assert a["description"], "JSON response's 'role_assignments' section should include description"
      assert a["entity_id"], "JSON response's 'role_assignments' section should include entity_id"
      assert a["id"], "JSON response's 'role_assignments' section should include id"
      assert a["name"], "JSON response's 'role_assignments' section should include name"
      assert a["role_id"], "JSON response's 'role_assignments' section should include role_id"
      assert a["token"], "JSON response's 'role_assignments' section should include token"
    end
  end

  test 'entities (group) CSV request should not include inactive members' do
    grant_test_user_admin_access

    inactive_p = entities(:inactivePerson)
    active_p = entities(:group_memberA)
    g = entities(:groupA)

    assert g.members.include?(inactive_p), "group should include the inactive person"
    assert inactive_p.active == false, "inactive person should be marked inactive"

    assert g.members.include?(active_p), "group should include an active person"
    assert active_p.active == true, "active person should be marked active"

    get :show, params: { id: g.id }, as: :csv

    assert response.body.include?(inactive_p.loginid) == false, "CSV should not include inactive individual"
    assert response.body.include?(active_p.loginid), "CSV should include an active individual"
  end

  test 'entites#update should allow operators to update group attributes' do
    grant_test_user_basic_access
    revoke_test_user_admin_access



    #assert false, "test not implemented"
  end

  test "entites#update should allow operators to add members" do
    #assert false, "test not implemented"
  end

  test "entites#update should allow operators to remove members" do
    #assert false, "test not implemented"
  end

  test "entites#update should allow owners to update a group" do
    #assert false, "test not implemented"
  end

  test "entites#update should allow owners to add members" do
    #assert false, "test not implemented"
  end

  test "entites#update should allow owners to remove members" do
    #assert false, "test not implemented"
  end

  test "entites#update should not allow non-owners/non-operators to update attributes" do
    #assert false, "test not implemented"
  end

  test "universal operators should not be able to give themselves RM administrator rights" do
    # TODO: This test needs to be rewritten to check this via controllers as the 'pundit'
    #       gem is not focused on non-controller level authorizations.
    # revoke_test_user_basic_access
    # revoke_test_user_admin_access
    # grant_test_user_operate_access

    # rm_app = applications(:dssrm)
    # rm_admin_role = roles(:dssrm_admin)

    # # Ensure 'casuser' is not an RM owner or operator
    # rm_app.owners.destroy @person if rm_app.owners.include? @person
    # rm_app.operators.destroy @person if rm_app.operators.include? @person

    # assert @person.role_symbols.include? :operate
    # assert @person.role_symbols.length == 1

    # exception_thrown = false

    # begin
    #   @person.roles << rm_admin_role
    # rescue Authorization::AttributeAuthorizationError => e
    #   # We're expecting this ...
    #   exception_thrown = true
    # end

    # assert exception_thrown == true, "NotAuthorizated exception should have been thrown."
    # assert @person.roles.include?(rm_admin_role) == false
  end

  # test "universal operators should be able to activate/deactivate individuals" do
  #   assert false, "test not implemented"
  # end
  test 'entities#update should work' do
    grant_test_user_admin_access

    # TODO: It should try to add a member to a group and have it return 200 and
    #       check that the member was added. Maybe rename the test then? The basic
    #       gist is that this basic controller action broke during the Rails 3->4 upgrade
    #       and that really should have been caught.

    @entity = entities(:groupA)

    patch :update, params: { id: @entity, entity: { name: @entity.name, type: @entity.type, description: @entity.description, owner_ids: @entity.owner_ids, operator_ids: @entity.operator_ids, memberships: @entity.memberships } }, as: :json

    assert_response :success
  end
end
