class MigrateGroupOwnershipsToEntities < ActiveRecord::Migration
  def up
    add_column :group_owner_assignments, :entity_id, :integer

    GroupOwnerAssignment.all.each do |go|
      unless go.owner_person_id.nil?
        go.entity_id = go.owner_person_id
      else
        go.entity_id = go.owner_group_id
      end
    end

    remove_column :group_owner_assignments, :owner_person_id
    remove_column :group_owner_assignments, :owner_group_id
  end

  def down
    puts "This migration is not reversible."
  end
end
