require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  def setup
    # Clear the cache in case fixtures changed recently (would interfere with flatten test, etc.)
    Rails.cache.clear
  end

  # Ensure only loginid is allowed. This is sometimes necessary when importing from LDAP.
  test "blank first, last, and name are allowed" do
    p = Person.new

    p.first = nil
    p.last = nil
    p.name = nil
    p.loginid = "deleteme"

    assert p.valid? == true, "should be valid with only loginid set"
  end

  test "creating a person fires off 'add_to_system' trigger" do
    without_access_control do
      p = Person.new

      p.first = nil
      p.last = nil
      p.name = nil
      p.loginid = "deleteme"

      p.save!

      assert Sync.trigger_test_count(:add_to_system) == 1, "add_to_system should have been triggered"
    end
  end

  test "deleting a person fires off 'remove_from_system' trigger" do
    without_access_control do
      p = Person.new

      p.first = nil
      p.last = nil
      p.name = nil
      p.loginid = "deleteme"

      p.save!

      p.destroy

      assert Sync.trigger_test_count(:remove_from_system) == 1, "remove_from_system should have been triggered"
    end
  end

  test "activating a person fires off the 'person_added_to_role' and 'person_added_to_organization' sync signals for each of their roles" do
    without_access_control do
      p = entities(:casuser)

      assert p.organizations.count == 1, "casuser should have exactly one organization but has #{p.organizations.count}"
      assert p.roles.count == 2, "casuser should have exactly two roles but has #{p.roles.count}"

      p.active = false

      p.save!

      Sync.reset_trigger_test_counts

      p.active = true

      p.save!

      assert Sync.trigger_test_count(:add_to_role) == 2, "add_to_role should have been triggered twice"
      assert Sync.trigger_test_count(:add_to_organization) == 1, "add_to_organization should have been triggered"
    end
  end

  test "deactivating a person fires off the 'person_removed_from_role' and 'person_removed_from_organization' sync signals for each of their roles" do
    without_access_control do
      p = entities(:casuser)

      assert p.organizations.count == 1, "casuser should have exactly one organization but has #{p.organizations.count}"
      assert p.roles.count == 2, "casuser should have exactly two roles but has #{p.roles.count}"

      p.active = true

      p.save!

      Sync.reset_trigger_test_counts

      p.active = false

      p.save!

      assert Sync.trigger_test_count(:remove_from_role) == 2, "remove_from_role should have been triggered twice"
      assert Sync.trigger_test_count(:remove_from_organization) == 1, "remove_from_organization should have been triggered"
    end
  end

  test "setting or changing a person's organization fires off 'add_to_organization' or 'remove_from_organization' sync signals" do
    without_access_control do
      p = entities(:casuser)

      assert p.organizations.count == 1, "casuser should have exactly one organization but has #{p.organizations.count}"
      assert p.roles.count == 2, "casuser should have exactly two roles but has #{p.roles.count}"

      Sync.reset_trigger_test_counts

      p.organizations.destroy(p.organizations.first)

      p.save!
      p.reload

      assert p.organizations.count == 0, "casuser should have no organizations but has #{p.organizations.count}"

      assert Sync.trigger_test_count(:remove_from_organization) == 1, "remove_from_organization should have been triggered once but was triggered #{Sync.trigger_test_count(:remove_from_organization)} times"

      p.organizations << Organization.first

      p.save!
      p.reload

      assert p.organizations.count == 1, "casuser should have exactly one organization but has #{p.organizations.count}"

      assert Sync.trigger_test_count(:add_to_organization) == 1, "remove_from_organization should have been triggered once but was triggered #{Sync.trigger_test_count(:remove_from_organization)} times"
    end
  end
end
