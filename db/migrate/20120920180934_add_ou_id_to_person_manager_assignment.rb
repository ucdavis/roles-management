class AddOuIdToPersonManagerAssignment < ActiveRecord::Migration
  def change
    add_column :person_manager_assignments, :ou_id, :integer
  end
end
