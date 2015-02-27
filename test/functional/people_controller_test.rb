require 'test_helper'

# These tests are run using the fake CAS user 'casuser'
class PeopleControllerTest < ActionController::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")

    @person = entities(:casuser)
  end

  # loginid required for: impersonate dialog, group rule "loginid is"
  # id, name, loginid, email, roles included as per published API spec
  # Should also respond to /people/loginid.json
  test 'JSON show request should include certain attributes' do
    grant_test_user_admin_access

    get :show, :format => :json, :id => 'casuser'

    body = JSON.parse(response.body)

    assert body.include?('id'), 'JSON response should include id field'
    assert body.include?('name'), 'JSON response should include name field'
    assert body.include?('email'), 'JSON response should include email field'
    assert body.include?('type'), 'JSON response should include type field'
    assert body.include?('loginid'), 'JSON response should include loginid field'

    assert body.include?('role_assignments'), 'JSON response should include role_assignments'
    body["role_assignments"].each do |r|
      assert r["role_id"], "JSON response's 'role_assignments' section should include a role_id field" # we cannot call it 'id' because Backbone won't add it twice then, which we _do_ want due to a person possibly having a role both explicitly and non-explicitly
      assert r["token"], "JSON response's 'role_assignments' section should include a token"
      assert r["name"], "JSON response's 'role_assignments' section should include a name"
      assert r["application_id"], "JSON response's 'role_assignments' section should include an application_id"
      assert r.has_key?("calculated"), "JSON response's 'role_assignments' section should include a calculated flag"
    end
  end

  test "assigning a role touches the timestamp on the person" do
    p = Person.find_by_loginid('bob')
    r = Role.first

    assert r.members.include?(p) == false, "person should not have role"
    person_timestamp = p.updated_at

    p.roles << r
    r.reload

    assert r.members.include?(p) == true, "person should have the role now"

    p.reload

    assert p.updated_at > person_timestamp, "person timestamp should have been touched"
  end

  test "un-assigning a role touches the timestamp on the person" do
    p = Person.find_by_loginid('bob')
    r = Role.first

    assert r.members.include?(p) == false, "person should not have role"

    p.roles << r
    r.reload

    assert r.members.include?(p) == true, "person should have the role now"

    p.reload
    person_timestamp = p.updated_at

    p.roles.destroy(r)
    r.reload
    assert r.members.include?(p) == false, "person should not have the role anymore"
    p.reload

    assert p.updated_at > person_timestamp, "person timestamp should have been touched"
  end

  test "creating a favorite touches the timestamp on the person" do
    p = Person.find_by_loginid('bob')
    favorite_person = Person.find_by_loginid('casuser')

    assert p.favorites.include?(favorite_person) == false, "person should not be favorited"
    person_timestamp = p.updated_at

    p.favorites << favorite_person
    p.reload

    assert p.favorites.include?(favorite_person) == true, "person should now be favorited"

    p.reload

    assert p.updated_at > person_timestamp, "person timestamp should have been touched"
  end

  test "deleting a favorite touches the timestamp on the person" do
    p = Person.find_by_loginid('bob')
    favorite_person = Person.find_by_loginid('casuser')

    assert p.favorites.include?(favorite_person) == false, "person should not be favorited"

    p.favorites << favorite_person
    p.reload

    assert p.favorites.include?(favorite_person) == true, "person should now be favorited"

    p.reload
    person_timestamp = p.updated_at

    p.favorites.destroy(favorite_person)
    p.reload

    assert p.updated_at > person_timestamp, "person timestamp should have been touched"
  end

  test "gaining a group membership touches the timestamp on the person" do
    p = Person.find_by_loginid('bob')
    g = entities(:groupWithNothing)

    person_timestamp = p.updated_at

    assert g.members.include?(p) == false, "person should not be in group"

    g.members << p
    g.reload

    assert g.members.include?(p) == true, "person should now be in group"
    p.reload

    assert p.updated_at > person_timestamp, "person timestamp should have been touched"
  end

  test "losing a group membership touches the timestamp on the person" do
    p = Person.find_by_loginid('bob')
    g = entities(:groupWithNothing)

    assert g.members.include?(p) == false, "person should not be in group"

    g.members << p
    g.reload

    assert g.members.include?(p) == true, "person should now be in group"
    p.reload
    person_timestamp = p.updated_at

    g.members.destroy(p)
    g.reload
    assert g.members.include?(p) == false, "person should not be in group"

    p.reload

    assert p.updated_at > person_timestamp, "person timestamp should have been touched"
  end

  test "gaining a group operatorship touches the timestamp on the person" do
    p = Person.find_by_loginid('bob')
    g = entities(:groupWithNothing)

    person_timestamp = p.updated_at

    assert g.operators.include?(p) == false, "person should not be an operator"

    g.operators << p
    g.reload

    assert g.operators.include?(p) == true, "person should now be an operator"
    p.reload

    assert p.updated_at > person_timestamp, "person timestamp should have been touched"
  end

  test "losing a group operatorship touches the timestamp on the person" do
    p = Person.find_by_loginid('bob')
    g = entities(:groupWithNothing)

    assert g.operators.include?(p) == false, "person should not be an operator"

    g.operators << p
    g.reload

    assert g.operators.include?(p) == true, "person should now be an operator"
    p.reload
    person_timestamp = p.updated_at

    g.operators.destroy(p)
    g.reload
    assert g.operators.include?(p) == false, "person should not be an operator"

    p.reload

    assert p.updated_at > person_timestamp, "person timestamp should have been touched"
  end

  test "gaining a group ownership touches the timestamp on the person" do
    p = Person.find_by_loginid('bob')
    g = entities(:groupWithNothing)

    person_timestamp = p.updated_at

    assert g.owners.include?(p) == false, "person should not be an owner"

    g.owners << p
    g.reload

    assert g.owners.include?(p) == true, "person should now be an owner"
    p.reload

    assert p.updated_at > person_timestamp, "person timestamp should have been touched"
  end

  test "losing a group ownership touches the timestamp on the person" do
    p = Person.find_by_loginid('bob')
    g = entities(:groupWithNothing)

    assert g.owners.include?(p) == false, "person should not be an owner"

    g.owners << p
    g.reload

    assert g.owners.include?(p) == true, "person should now be an owner"
    p.reload
    person_timestamp = p.updated_at

    g.owners.destroy(p)
    g.reload
    assert g.owners.include?(p) == false, "person should not be an owner"

    p.reload

    assert p.updated_at > person_timestamp, "person timestamp should have been touched"
  end

  test "gaining an organization touches the timestamp on the person" do
    p = Person.find_by_loginid('bob')
    o = organizations(:orphaned_org)

    person_timestamp = p.updated_at

    assert o.entities.include?(p) == false, "person should not be in the organization"

    o.entities << p
    o.reload

    assert o.entities.include?(p) == true, "person should now be in the organization"
    p.reload

    assert p.updated_at > person_timestamp, "person timestamp should have been touched"
  end

  test "losing an organization touches the timestamp on the person" do
    p = Person.find_by_loginid('bob')
    o = organizations(:orphaned_org)

    assert o.entities.include?(p) == false, "person should not be in organization"

    o.entities << p
    o.reload

    assert o.entities.include?(p) == true, "person should now be in organization"
    p.reload
    person_timestamp = p.updated_at

    o.entities.destroy(p)
    o.reload
    assert o.entities.include?(p) == false, "person should not be in organization"

    p.reload

    assert p.updated_at > person_timestamp, "person timestamp should have been touched"
  end
end
