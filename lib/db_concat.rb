# Database 'helper' methods used in controllers.
# Not easily replicated with ActiveRecord.
module DatabaseExtensions
  # db_concat is from http://stackoverflow.com/questions/2986405/database-independant-sql-string-concatenation-in-rails
  # Symbols should be used for field names, everything else will be quoted as a string
  def db_concat(*args)
    adapter = ActiveRecord::Base.connection.instance_values["config"][:adapter]
    args.map!{ |arg| arg.class==Symbol ? arg.to_s : "'#{arg}'" }

    case adapter
      when :mysql
        "CONCAT(#{args.join(',')})"
      when :sqlserver
        args.join('+')
      else
        args.join('||')
    end
  end
end
