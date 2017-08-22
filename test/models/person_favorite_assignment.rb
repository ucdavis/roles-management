require 'test_helper'

class PersonFavoriteAssignmentTest < ActiveSupport::TestCase
  # Ensure only loginid is allowed. This is sometimes necessary when importing from LDAP.
  test "favorite requires valid entity" do
    pfa = PersonFavoriteAssignment.new

    pfa.owner = Person.find_by_id(1)

    assert pfa.valid? == false, "should have required an entity to be set"

    pfa.entity = Person.find_by_id(3)

    assert pfa.valid? == true, "should have been set correctly"
  end
end
