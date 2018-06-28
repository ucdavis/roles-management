# Credit: https://gist.github.com/MarkMurphy/93adca601b05acffb8b5601df09f66df

# Save this in config/initializers/mysql.rb (or whatever you want, filename doesn't matter.)

# Creates DATETIME(6) column types by default which support microseconds.
#
# Without it, only regular (second precise) DATETIME columns are created.
module ActiveRecord::ConnectionAdapters
  AbstractMysqlAdapter::NATIVE_DATABASE_TYPES[:datetime][:limit] = 6
end
