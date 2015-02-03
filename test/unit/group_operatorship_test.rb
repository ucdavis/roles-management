require 'test_helper'

class GroupOperatorshipTest < ActiveSupport::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")

    @person = entities(:casuser)
  end

  test "non-admin group operators can add members, implying role assignments for applications they do not control" do
    # FIXME: Write this test
  end

  test "non-admin group operators are able to add group members" do
    assert @person.role_symbols.include?(:access), "casuser should have 'access' role"

    revoke_test_user_admin_access

    @person.reload

    assert @person.role_symbols.include?(:admin) == false, "casuser should not have 'admin' role"

    group = entities(:groupWithARole)

    without_access_control do
      group.operators << @person
      group.roles.destroy_all
    end

    assert group.owners.include?(@person) == false, "casuser should not be an owner of groupWithARole"
    assert group.operators.include?(@person), "casuser should be an operator of groupWithARole"

    assert group.owners.length == 0, "group should not have any owners"
    assert group.operators.length == 1, "group should only have one operator"

    Authorization.current_user = @person

    assert group.members.length == 0, "group should not have any members"

    group.members << @person

    assert group.members.length == 1, "group should have one member"
  end
end
