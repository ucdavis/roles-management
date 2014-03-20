class ActivityLogTag < ActiveRecord::Base
  using_access_control
  
  attr_accessible :tag
end
