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
end
