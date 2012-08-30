class ApiWhitelistedIp < ActiveRecord::Base
  attr_accessible :address, :reason
end
