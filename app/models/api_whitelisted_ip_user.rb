class ApiWhitelistedIpUser < ActiveRecord::Base
  def log_identifier
    "Whitelisted(#{address})"
  end

  # Whitelisted API users are automatically given regular access
  def role_symbols
    [:access, :api_whitelist]
  end
end
