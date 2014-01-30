class EnsureOuTableIsRemoved < ActiveRecord::Migration
  def change
    drop_table :ous
  end
end
