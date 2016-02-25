require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  def setup
    # Clear the cache in case fixtures changed recently (would interfere with flatten test, etc.)
    Rails.cache.clear
  end

  # Ensure members(:flatten = true) has the correct number of members
  test "members flattens a group correctly" do
    group = Group.first
    # Ensure the group exists
    assert group, "a group must exist for this test"
    # Ensure the group has person members
    assert group.members.select{ |m| m.type == "Person"}.count > 0, "cannot test without people assigned to this group"
    # Ensure the group has group members that are not empty
    assert group.members.select{ |m| m.type == "Group"}.count > 0, "cannot test without groups assigned to this group"

    flattened_members_count = group.flattened_members.count

    # Manually flatten the group and ensure g.members(:flatten = true)'s logic works correctly (the point of this test)
    # Technically this is a recursive test (we rely on g.members(true) working correctly). This should still
    # work but a replacement test version of members(:flatten = true) should be written.
    test_flatten_count = 0
    test_flatten_count += group.members.select{ |m| m.type == "Person"}.count
    group.members.select{ |m| m.type == "Group"}.each do |g|
      test_flatten_count += g.flattened_members.count
    end

    assert test_flatten_count == flattened_members_count, "test flattening (#{test_flatten_count}) and Group.members(:flatten = true) (#{flattened_members_count}) should match count"
  end

  # Test runs as non-admin
  test "group owners can update attributes" do
    p = entities(:personWithNothing)

    grant_user_basic_access(p)
    revoke_user_admin_access(p)

    g = entities(:groupWithNothing)
    assert g.owners.length == 0, "group should not have any owners"

    assert p.group_ownerships.length == 0, "person should not own any groups"

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
  test "group owners can delete the group" do
    p = entities(:personWithNothing)

    grant_user_basic_access(p)
    revoke_user_admin_access(p)

    g = entities(:groupWithNothing)
    assert g.owners.length == 0, "group should not have any owners"

    assert p.group_ownerships.length == 0, "person should not own any groups"

    go = GroupOwnership.new
    go.entity = p
    go.group = g
    go.save!

    g.reload
    assert g.owners.length == 1, "group should have one owner"

    p.reload
    assert p.group_ownerships.length == 1, "person should own one group"

    begin
      g.destroy
    rescue Authorization::NotAuthorized
      assert false, "authorization should not have failed"
    end
  end

  # Test runs as non-admin
  test "group owners can add members" do
    p = entities(:personWithNothing)

    grant_user_basic_access(p)
    revoke_user_admin_access(p)

    g = entities(:groupWithNothing)
    assert g.owners.length == 0, "group should not have any owners"

    assert p.group_ownerships.length == 0, "person should not own any groups"
    assert p.group_operatorships.length == 0, "person should not own any groups"

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
      g.members << member
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
    assert g.owners.length == 0, "group should not have any owners"

    assert p.group_ownerships.length == 0, "person should not own any groups"
    assert p.group_operatorships.length == 0, "person should not own any groups"

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

    g.members << member

    assert g.members.include?(member) == true, "group should include casuser"

    begin
      g.members.destroy(member)
    rescue Authorization::NotAuthorized
      assert false, "authorization should not have failed"
    end

    assert g.members.include?(member) == false, "group should not include casuser"
  end

  # Test runs as non-admin
  test "non-owning, non-operating users cannot update the group" do
    p = entities(:personWithNothing)

    grant_user_basic_access(p)
    revoke_user_admin_access(p)

    g = entities(:groupWithNothing)
    assert g.owners.length == 0, "group should not have any owners"

    assert p.group_ownerships.length == 0, "person should not own any groups"
    assert p.group_operatorships.length == 0, "person should not own any groups"

    unauthorized_exception_count = 0

    begin
      g.description = "something"
      g.save!
    rescue Authorization::NotAuthorized
      unauthorized_exception_count = unauthorized_exception_count + 1
    end

    assert unauthorized_exception_count == 1, "authorization exception should have occurred"
  end

  # Test runs as non-admin
  test "non-owning, non-operating users cannot add group members" do
    p = entities(:personWithNothing)

    grant_user_basic_access(p)
    revoke_user_admin_access(p)

    g = entities(:groupWithNothing)
    assert g.owners.length == 0, "group should not have any owners"

    assert p.group_ownerships.length == 0, "person should not own any groups"
    assert p.group_operatorships.length == 0, "person should not own any groups"

    member = entities(:casuser)

    assert g.members.include?(member) == false, "group should not include casuser"

    unauthorized_exception_count = 0

    begin
      g.members << member
    rescue Authorization::NotAuthorized
      unauthorized_exception_count = unauthorized_exception_count + 1
    end

    assert g.members.include?(member) == false, "group should still not include casuser"

    assert unauthorized_exception_count == 1, "authorization exception should have occurred"
  end

  # Test runs as non-admin
  test "non-owning, non-operating users cannot remove group members" do
    p = entities(:personWithNothing)

    grant_user_basic_access(p)
    revoke_user_admin_access(p)

    g = entities(:groupWithNothing)
    assert g.owners.length == 0, "group should not have any owners"

    assert p.group_ownerships.length == 0, "person should not own any groups"
    assert p.group_operatorships.length == 0, "person should not own any groups"

    member = entities(:casuser)

    assert g.members.include?(member) == false, "group should not include casuser"

    g.members << member

    assert g.members.include?(member) == true, "group should include casuser"

    unauthorized_exception_count = 0

    begin
      g.members.destroy(member)
    rescue Authorization::NotAuthorized
      unauthorized_exception_count = unauthorized_exception_count + 1
    end

    assert g.members.include?(member) == true, "group should still include casuser"

    assert unauthorized_exception_count == 1, "authorization exception should have occurred"
  end

  # Test runs as non-admin
  test "non-owning, non-operating users cannot delete the group" do
    p = entities(:personWithNothing)

    grant_user_basic_access(p)
    revoke_user_admin_access(p)

    g = entities(:groupWithNothing)
    assert g.owners.length == 0, "group should not have any owners"

    assert p.group_ownerships.length == 0, "person should not own any groups"

    unauthorized_exception_count = 0

    begin
      g.destroy
    rescue Authorization::NotAuthorized
      unauthorized_exception_count = unauthorized_exception_count + 1
    end

    assert unauthorized_exception_count == 1, "authorization exception should have occurred"
  end

  # Test runs as non-admin
  test "group operators can update attributes" do
    p = entities(:personWithNothing)

    grant_user_basic_access(p)
    revoke_user_admin_access(p)

    g = entities(:groupWithNothing)
    assert g.owners.length == 0, "group should not have any owners"

    assert p.group_ownerships.length == 0, "person should not own any groups"
    assert p.group_operatorships.length == 0, "person should not own any groups"

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
  test "group operators cannot delete the group" do
    p = entities(:personWithNothing)

    grant_user_basic_access(p)
    revoke_user_admin_access(p)

    g = entities(:groupWithNothing)
    assert g.owners.length == 0, "group should not have any owners"

    assert p.group_ownerships.length == 0, "person should not own any groups"

    go = GroupOperatorship.new
    go.entity = p
    go.group = g
    go.save!

    g.reload
    assert g.operators.length == 1, "group should have one operator"

    p.reload
    assert p.group_operatorships.length == 1, "person should operate one group"

    unauthorized_exception_count = 0

    begin
      g.destroy
    rescue Authorization::NotAuthorized
      unauthorized_exception_count = unauthorized_exception_count + 1
    end

    assert unauthorized_exception_count == 1, "authorization exception should have occurred"
  end

  # Test runs as non-admin
  test "group operators can add members" do
    p = entities(:personWithNothing)

    grant_user_basic_access(p)
    revoke_user_admin_access(p)

    g = entities(:groupWithNothing)
    assert g.owners.length == 0, "group should not have any owners"

    assert p.group_ownerships.length == 0, "person should not own any groups"
    assert p.group_operatorships.length == 0, "person should not own any groups"

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
      g.members << member
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
    assert g.owners.length == 0, "group should not have any owners"

    assert p.group_ownerships.length == 0, "person should not own any groups"
    assert p.group_operatorships.length == 0, "person should not own any groups"

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

    g.members << member

    assert g.members.include?(member) == true, "group should include casuser"

    begin
      g.members.destroy(member)
    rescue Authorization::NotAuthorized
      assert false, "authorization should not have failed"
    end

    assert g.members.include?(member) == false, "group should not include casuser"
  end
end
