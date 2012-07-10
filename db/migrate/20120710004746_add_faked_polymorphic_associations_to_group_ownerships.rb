class AddFakedPolymorphicAssociationsToGroupOwnerships < ActiveRecord::Migration
  def change
    rename_column :group_owner_assignments, :owner_id, :owner_person_id
    add_column :group_owner_assignments, :owner_group_id, :integer
  end
end
