class ReaddTemplateTable < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string  :name
    end
  end
end
