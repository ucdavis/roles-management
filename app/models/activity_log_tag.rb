class ActivityLogTag < ActiveRecord::Base
  using_access_control

  has_many :activity_log_tag_associations
  has_many :activity_logs, :through => :activity_log_tag_associations
end
