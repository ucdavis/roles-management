class DiaryEntry < ActiveRecord::Base
  belongs_to :context, :class_name => "DiaryUid", :foreign_key => "diary_uid_id"
  
  def self.write!(diary_uid_id, message)
    DiaryEntry.create({ :diary_uid_id => diary_uid_id, :message => message, :severity => 0 })
  end
end
