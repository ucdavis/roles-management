class ActivityLogTagAssociation < ActiveRecord::Base
  using_access_control

  belongs_to :activity_log
  belongs_to :activity_log_tag
end
