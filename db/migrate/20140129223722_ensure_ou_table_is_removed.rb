class EnsureOuTableIsRemoved < ActiveRecord::Migration
  def change
    if defined? Ou
      drop_table :ous
    end
  end
end
