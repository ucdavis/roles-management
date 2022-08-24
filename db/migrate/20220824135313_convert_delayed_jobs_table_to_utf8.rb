class ConvertDelayedJobsTableToUtf8 < ActiveRecord::Migration[5.2]
  def up
    execute "ALTER TABLE delayed_jobs CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci;"
  end

  def down
    execute "ALTER TABLE delayed_jobs CONVERT TO CHARACTER SET latin1 COLLATE latin1_swedish_ci;"
  end
end
