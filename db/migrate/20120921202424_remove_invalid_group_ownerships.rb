class RemoveInvalidGroupOwnerships < ActiveRecord::Migration
  def up
    # Remove ownership associations which fail newly added validations:
    #     * Groups cannot own themselves
    #     * Group ownership must have an owner, be it a person or group, but not both
    GroupOwnerAssignment.all.each do |goa|
      goa.delete unless goa.valid?
    end
  end

  def down
    puts "This migration is destructive and cannot be reversed."
  end
end
