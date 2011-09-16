class RecreateTitlesTable < ActiveRecord::Migration
  def up
    create_table :titles do |t|
      t.string :title
    end
  end

  def down
    drop_table :titles
  end
end
