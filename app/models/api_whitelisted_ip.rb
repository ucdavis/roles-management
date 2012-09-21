class ApiWhitelistedIp < ActiveRecord::Base
  using_access_control

  attr_accessible :address, :reason
end
