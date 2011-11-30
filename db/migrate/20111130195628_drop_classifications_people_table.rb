class DropClassificationsPeopleTable < ActiveRecord::Migration
  def change
    drop_table :classifications_people
  end
end
