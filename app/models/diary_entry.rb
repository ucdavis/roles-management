class DiaryEntry < ActiveRecord::Base
  def self.write!(diary_uid_id, message)
    DiaryEntry.create({ :diary_uid_id => diary_uid_id, :message => message, :severity => 0 })
  end
end
