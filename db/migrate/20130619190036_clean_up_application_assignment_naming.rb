class CleanUpApplicationAssignmentNaming < ActiveRecord::Migration
  def change
    rename_table :application_operator_assignments, :application_operatorships
    rename_table :application_owner_assignments, :application_ownerships
  end
end
