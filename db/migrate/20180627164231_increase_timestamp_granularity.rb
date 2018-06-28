class IncreaseTimestampGranularity < ActiveRecord::Migration[5.2]
  def change
    reversible do |change|
      # Migrate Up
      change.up do
        table_columns do |table, column|
          # MySQL supports time precision down to microseconds -- DATETIME(6)
          change_column table, column, :datetime, limit: 6
        end
      end

      # Migrate Down
      change.down do
        table_columns do |table, column|
          change_column table, column, :datetime
        end
      end

      # NOTE: only MySQL 5.6.4 and above supports DATETIME's with more precision
      # than a second. See https://dev.mysql.com/doc/relnotes/mysql/5.6/en/news-5-6-4.html#mysqld-5-6-4-fractional-seconds
    end
  end

  private

  def table_columns
    # Iterate through all tables in this environment's database
    ActiveRecord::Base.connection.tables.each do |table|
      # Iterate through all columns in table
      ActiveRecord::Base.connection.columns(table).each do |column|
        yield table, column.name if column.type == :datetime && block_given?
      end
    end
  end
end
