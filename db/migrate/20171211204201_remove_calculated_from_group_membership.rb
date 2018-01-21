class RemoveCalculatedFromGroupMembership < ActiveRecord::Migration[5.1]
  def change
    GroupMembership.where(calculated: true).delete_all

    remove_column :group_memberships, :calculated

    Group.all.each(&:touch)
  end
end
