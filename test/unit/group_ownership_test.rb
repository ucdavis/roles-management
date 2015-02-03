require 'test_helper'

class GroupOwnershipTest < ActiveSupport::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")

    @person = entities(:casuser)
  end

  test "group owners are able to update groups" do
    group = entities(:groupWithARole)

    without_access_control do
      group.owners << @person
    end

    assert group.owners.include?(@person), "casuser should be an owner of groupWithARole"

    Authorization.current_user = @person

    assert group.members.length == 0, "group should not have any members"

    group.members << @person

    assert group.members.length == 1, "group should have one member"

    group.name = "Something New"
    group.save!
  end

  test "ensure a group owner can update a group when that group is an application operator and group owner is not an owner of that application" do
    # FIXME: This test needs to be written
  end

  test "ensure a group owner can remove themselves from ownership" do
    # FIXME: This test needs to be written
  end

  # For some reason (a bug?) if our config/authorization_rules.rb has both
  # :manage in the :groups context and you also specify :update in the :groups
  # context, group.owners will be missing some owners.
  test "avoid GroupOwnership with_permission_to_update bug" do
    assert @person.role_symbols.include?(:access), "casuser should have 'access' role"

    revoke_test_user_admin_access

    @person.reload

    assert @person.role_symbols.include?(:admin) == false, "casuser should not have 'admin' role"

    Authorization.current_user = @person

    group = Group.find(entities(:groupWithNothing).id)
    without_access_control do
      group.owners << @person
      group.owners << entities(:cthielen)
    end

    group = Group.with_permissions_to(:update).find(entities(:groupWithNothing).id)

    assert group.members.length == 0, "group should not have any members"
    assert group.owners.include?(@person), "casuser should be an owner"
    assert group.owners.include?(entities(:cthielen)), "cthielen should be an owner"

    group.members << @person

    assert group.members.length == 1, "group should have one member"

    # group.name = "Something New"
    # group.save!
  end
end
