require 'test_helper'

class GroupOwnershipTest < ActiveSupport::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")

    @person = entities(:casuser)
  end

  test 'group owners are able to update groups' do
    group = entities(:groupWithARole)

    group.owners << @person

    assert group.owners.include?(@person), 'casuser should be an owner of groupWithARole'

    assert group.members.empty?, 'group should not have any members'

    GroupMembership.create!(group: group, entity: @person)

    assert group.members.length == 1, 'group should have one member'

    group.name = 'Something New'
    group.save!
  end
end
