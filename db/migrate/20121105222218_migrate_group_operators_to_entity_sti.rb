class MigrateGroupOperatorsToEntitySti < ActiveRecord::Migration
  def up
    add_column :group_operator_assignments, :entity_id, :integer

    Authorization.ignore_access_control(true)

    GroupOperatorAssignment.all.each do |goa|
      unless goa.operator_person_id.nil?
        # Person-based
        goa.entity_id = goa.operator_person_id
      else
        # Group-based
        goa.entity_id = goa.operator_group_id
      end

      goa.save
    end

    Authorization.ignore_access_control(false)

    remove_column :group_operator_assignments, :operator_person_id
    remove_column :group_operator_assignments, :operator_group_id
  end

  def down
    puts "This migration is not reversible."
  end
end
