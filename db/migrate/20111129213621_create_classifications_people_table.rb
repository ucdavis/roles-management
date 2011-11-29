class CreateClassificationsPeopleTable < ActiveRecord::Migration
  def change
    create_table :classifications_people do |t|
      t.integer :classification_id
      t.integer :person_id
    end
  end
end
