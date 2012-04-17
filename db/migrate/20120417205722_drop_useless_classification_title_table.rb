class DropUselessClassificationTitleTable < ActiveRecord::Migration
  def up
    drop_table :classifications_titles
  end

  def down
    puts "This migration is not reversible."
  end
end
