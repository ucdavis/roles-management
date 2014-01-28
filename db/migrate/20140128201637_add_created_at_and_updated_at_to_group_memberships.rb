class AddCreatedAtAndUpdatedAtToGroupMemberships < ActiveRecord::Migration
  def change
    add_column(:group_memberships, :created_at, :datetime)
    add_column(:group_memberships, :updated_at, :datetime)
  end
end
