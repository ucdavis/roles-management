class CreateOrganizationEntityAssociations < ActiveRecord::Migration
  def change
    create_table :organization_entity_associations do |t|
      t.integer :organization_id
      t.integer :entity_id

      t.timestamps
    end
  end
end
