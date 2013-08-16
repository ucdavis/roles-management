class AddIndexes < ActiveRecord::Migration
  def change
    add_index :entities, :loginid
    add_index :entities, :name
    add_index :entities, :code
    add_index :applications, :name
    add_index :api_whitelisted_ip_users, :address
    add_index :api_key_users, [:name, :secret]
    add_index :titles, :code
    add_index :role_assignments, [:role_id, :entity_id]
    add_index :role_assignments, [:role_id, :entity_id, :calculated]
    add_index :majors, :name
    add_index :affiliations, :name
    add_index :classifications, :name
  end
end
