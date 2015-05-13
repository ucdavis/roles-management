class ActivityLogTagAssociation < ActiveRecord::Base
  using_access_control

  #attr_accessible :activity_log_id, :activity_log_tag_id
  
  belongs_to :activity_log
  belongs_to :activity_log_tag
end
