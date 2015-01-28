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

  test "activating a person fires off 'person_added_to_role' for each of their roles" do
    without_access_control do
      # p = entities(:casuser)
      #
      # p.active = false
      #
      # p.save!
      #
      # Sync.reset_trigger_test_counts
      #
      # p.active = true
      #
      # p.save!
      #
      # assert Sync.trigger_test_count(:activate_person) == 1, "activate_person should have been triggered"

      assert false, "test not implemented"
    end
  end

  test "deactivating a person fires off 'person_removed_from_role' for each of their roles" do
    without_access_control do
      # p = entities(:casuser)
      #
      # p.active = true
      #
      # p.save!
      #
      # Sync.reset_trigger_test_counts
      #
      # p.active = false
      #
      # p.save!
      #
      # assert Sync.trigger_test_count(:deactivate_person) == 1, "deactivate_person should have been triggered"
      
      assert false, "test not implemented"
    end
  end
end
