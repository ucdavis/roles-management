class MigrateGroupPeopleRelationToEntityStiModel < ActiveRecord::Migration
  def up
    rename_column :groups_people, :person_id, :entity_id
    rename_table :groups_people, :entities_groups
  end

  def down
    puts "This migration should not be reversed."
  end
end
