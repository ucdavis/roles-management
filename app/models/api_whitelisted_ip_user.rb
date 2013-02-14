class ApiWhitelistedIpUser < ActiveRecord::Base
  using_access_control

  attr_accessible :address, :reason

  def role_symbols
    [:access]
  end
end
