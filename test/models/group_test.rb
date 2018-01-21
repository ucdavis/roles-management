require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  def setup
    # Clear the cache in case fixtures changed recently (would interfere with flatten test, etc.)
    Rails.cache.clear
  end

  # Test runs as non-admin
  test "group owners can update attributes" do
    p = entities(:personWithNothing)

    grant_user_basic_access(p)
    revoke_user_admin_access(p)

    g = entities(:groupWithNothing)
    assert g.owners.empty?, "group should not have any owners"

    assert p.group_ownerships.empty?, "person should not own any groups"

    go = GroupOwnership.new
    go.entity = p
    go.group = g
    go.save!

    g.reload
    assert g.owners.length == 1, "group should have one owner"

    p.reload
    assert p.group_ownerships.length == 1, "person should own one group"

    begin
      g.description = "something"
      g.save!
    rescue Authorization::NotAuthorized
      assert false, "authorization should not have failed"
    end
  end

  # Test runs as non-admin
  test 'group owners can delete the group' do
    p = entities(:personWithNothing)

    grant_user_basic_access(p)
    revoke_user_admin_access(p)

    g = entities(:groupWithNothing)
    assert g.owners.empty?, 'group should not have any owners'

    assert p.group_ownerships.empty?, 'person should not own any groups'

    go = GroupOwnership.new
    go.entity = p
    go.group = g
    go.save!

    g.reload
    assert g.owners.length == 1, 'group should have one owner'

    p.reload
    assert p.group_ownerships.length == 1, 'person should own one group'

    g.destroy
  end

  # Test runs as non-admin
  test "group owners can add members" do
    p = entities(:personWithNothing)

    grant_user_basic_access(p)
    revoke_user_admin_access(p)

    g = entities(:groupWithNothing)
    assert g.owners.empty?, "group should not have any owners"

    assert p.group_ownerships.empty?, "person should not own any groups"
    assert p.group_operatorships.empty?, "person should not own any groups"

    go = GroupOwnership.new
    go.entity = p
    go.group = g
    go.save!

    g.reload
    assert g.owners.length == 1, "group should have one owner"

    p.reload
    assert p.group_ownerships.length == 1, "person should own one group"

    member = entities(:casuser)

    assert g.members.include?(member) == false, "group should not include casuser"

    begin
      GroupMembership.create!(group: g, entity: member)
    rescue Authorization::NotAuthorized
      assert false, "authorization should not have failed"
    end

    assert g.members.include?(member) == true, "group should include casuser"
  end

  # Test runs as non-admin
  test "group owners can remove members" do
    p = entities(:personWithNothing)

    grant_user_basic_access(p)
    revoke_user_admin_access(p)

    g = entities(:groupWithNothing)
    assert g.owners.empty?, "group should not have any owners"

    assert p.group_ownerships.empty?, "person should not own any groups"
    assert p.group_operatorships.empty?, "person should not own any groups"

    go = GroupOwnership.new
    go.entity = p
    go.group = g
    go.save!

    g.reload
    assert g.owners.length == 1, "group should have one owner"

    p.reload
    assert p.group_ownerships.length == 1, "person should own one group"

    member = entities(:casuser)

    assert g.members.include?(member) == false, "group should not include casuser"

    GroupMembership.create!(group: g, entity: member)

    assert g.members.include?(member) == true, "group should include casuser"

    GroupMembership.find_by(group: g, entity: member).destroy!

    assert g.members.include?(member) == false, "group should not include casuser"
  end

  # Test runs as non-admin
  test "group operators can update attributes" do
    p = entities(:personWithNothing)

    grant_user_basic_access(p)
    revoke_user_admin_access(p)

    g = entities(:groupWithNothing)
    assert g.owners.empty?, "group should not have any owners"

    assert p.group_ownerships.empty?, "person should not own any groups"
    assert p.group_operatorships.empty?, "person should not own any groups"

    go = GroupOperatorship.new
    go.entity = p
    go.group = g
    go.save!

    g.reload
    assert g.operators.length == 1, "group should have one operator"

    p.reload
    assert p.group_operatorships.length == 1, "person should operate one group"

    begin
      g.description = "something"
      g.save!
    rescue Authorization::NotAuthorized
      assert false, "authorization should not have failed"
    end
  end

  # Test runs as non-admin
  test "group operators can add members" do
    p = entities(:personWithNothing)

    grant_user_basic_access(p)
    revoke_user_admin_access(p)

    g = entities(:groupWithNothing)
    assert g.owners.empty?, "group should not have any owners"

    assert p.group_ownerships.empty?, "person should not own any groups"
    assert p.group_operatorships.empty?, "person should not own any groups"

    go = GroupOperatorship.new
    go.entity = p
    go.group = g
    go.save!

    g.reload
    assert g.operators.length == 1, "group should have one operator"

    p.reload
    assert p.group_operatorships.length == 1, "person should operate one group"

    member = entities(:casuser)

    assert g.members.include?(member) == false, "group should not include casuser"

    begin
      GroupMembership.create!(group: g, entity: member)
    rescue Authorization::NotAuthorized
      assert false, "authorization should not have failed"
    end

    assert g.members.include?(member) == true, "group should include casuser"
  end

  # Test runs as non-admin
  test "group operators can remove members" do
    p = entities(:personWithNothing)

    grant_user_basic_access(p)
    revoke_user_admin_access(p)

    g = entities(:groupWithNothing)
    assert g.owners.empty?, "group should not have any owners"

    assert p.group_ownerships.empty?, "person should not own any groups"
    assert p.group_operatorships.empty?, "person should not own any groups"

    go = GroupOperatorship.new
    go.entity = p
    go.group = g
    go.save!

    g.reload
    assert g.operators.length == 1, "group should have one operator"

    p.reload
    assert p.group_operatorships.length == 1, "person should operate one group"

    member = entities(:casuser)

    assert g.members.include?(member) == false, "group should not include casuser"

    GroupMembership.create!(group: g, entity: member)

    assert g.members.include?(member) == true, "group should include casuser"

    GroupMembership.find_by(group: g, entity: member).destroy!

    assert g.members.include?(member) == false, "group should not include casuser"
  end
end
