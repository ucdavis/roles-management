class DiaryUid < ActiveRecord::Base
  has_many :entries, :class_name => "DiaryEntry"
end
