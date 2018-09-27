class IntegrationMetadata < ActiveRecord::Migration[5.2]
  def change
    create_table :integration_metadata do |t|
      t.string :key
      t.text :value

      t.timestamps
    end
  end
end
