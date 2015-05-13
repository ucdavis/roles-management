class ApiWhitelistedIpUser < ActiveRecord::Base
  using_access_control

  #attr_accessible :address, :reason

  def log_identifier
    "Whitelisted(#{address})"
  end

  # Whitelisted API users are automatically given regular access
  def role_symbols
    [:access, :api_whitelist]
  end
end
