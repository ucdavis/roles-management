class ResetModeling < ActiveRecord::Migration
  def self.up
    drop_table :affiliations
    drop_table :assignments
    drop_table :templates
    drop_table :titles
    drop_table :template_assignments
  end

  def self.down
    # Because we intend to change the model drastically, this migration cannot be unapplied in this manner
  end
end
