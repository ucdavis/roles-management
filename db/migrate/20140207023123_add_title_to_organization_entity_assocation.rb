class AddTitleToOrganizationEntityAssocation < ActiveRecord::Migration
  def change
    add_column :organization_entity_associations, :title_id, :integer
  end
end
