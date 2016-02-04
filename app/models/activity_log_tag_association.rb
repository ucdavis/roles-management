class ActivityLogTagAssociation < ActiveRecord::Base
  belongs_to :activity_log
  belongs_to :activity_log_tag
end
