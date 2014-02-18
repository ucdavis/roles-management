# Taken from http://webjazz.blogspot.com/2010/03/how-to-alter-columns-in-postgresql.html, needed for migration 20140214014726_organization_parent_id_parent_org_id_field_should_be_integer

# used to alter columns in postgresql
module AlterColumn
  def alter_column(table_name, column_name, new_type, mapping, default = nil)
    drop_default = %Q{ALTER TABLE #{table_name} ALTER COLUMN #{column_name} DROP DEFAULT;}
    execute(drop_default)
    # puts drop_default
 
    base = %Q{ALTER TABLE #{table_name} ALTER COLUMN #{column_name} TYPE #{new_type} }
    if mapping.kind_of?(Hash)
      contains_else = mapping.has_key?("else")
      else_mapping = mapping.delete("else")
      when_mapping = mapping.map { |k, v| "when '#{k}' then #{v}" }.join("\n")
      
      base += %Q{ USING CASE #{column_name} #{when_mapping} } unless when_mapping.blank?
      base += %Q{ ELSE #{else_mapping} } unless contains_else.blank?
      base += %Q{ END } if !when_mapping.blank? or !contains_else.blank?
    elsif mapping.kind_of?(String)
      base += mapping
    end
    base += ";"
    
    execute(base);
    # puts base
    
    unless default.blank?
      set_default = %Q{ALTER TABLE #{table_name} ALTER COLUMN #{column_name} SET DEFAULT #{default};}
      execute(set_default)
      # puts set_default
    end
  end
  module_function :alter_column
end
