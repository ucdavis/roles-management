class AddIamIdToPerson < ActiveRecord::Migration[5.1]
  def change
    add_column :entities, :iam_id, :integer, default: :nil
  end
end
