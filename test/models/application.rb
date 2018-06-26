require 'test_helper'

class ApplicationTest < ActiveSupport::TestCase
  test 'updating a role touches its application' do
    r = roles(:dssrm_access)
    a = r.application

    # Timing granularity is only within a second with MySQL-based
    # tests, so we need to ensure the "old timestamp" is at least
    # a second ago. Another option is sleep(1), which is less preferred.
    a.updated_at -= 1
    a.save!
    app_last_updated = a.updated_at

    r.touch
    a.reload
    assert a.updated_at > app_last_updated, 'application should have been touched'
  end

  test "creating/destroying a role assignment touches the role's application" do
    r = roles(:dssrm_access)
    a = r.application

    # Timing granularity is only within a second with MySQL-based
    # tests, so we need to ensure the "old timestamp" is at least
    # a second ago. Another option is sleep(1), which is less preferred.
    a.updated_at -= 1
    a.save!
    app_last_updated = a.updated_at

    ra = RoleAssignment.new
    ra.role_id = r.id
    ra.entity_id = 1
    ra.save!

    a.reload
    assert a.updated_at > app_last_updated, 'application should have been touched'

    a.updated_at -= 1
    a.save!
    app_last_updated = a.updated_at

    ra.destroy
    a.reload
    assert a.updated_at > app_last_updated, 'application should have been touched'
  end

  # test "adding/removing a member to/from a group assigned to a role touches the role's application" do
  # end

  # test "adding/removing a rule to/from a group assigned to a role touches the role's application" do
  # end

  # test "a person attribute change creating/destroying group membership for a group assigned to a role touches the role's application" do
  # end
end
