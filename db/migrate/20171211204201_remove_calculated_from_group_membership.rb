class RemoveCalculatedFromGroupMembership < ActiveRecord::Migration[5.1]
  def change
    GroupMembership.where(calculated: true).destroy_all

    remove_column :group_memberships, :calculated
  end
end
