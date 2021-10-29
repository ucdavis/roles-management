class AddLastAccessedToRoles < ActiveRecord::Migration[5.2]
  def change
    add_column :roles, :last_accessed, :datetime, limit: 6
  end
end
