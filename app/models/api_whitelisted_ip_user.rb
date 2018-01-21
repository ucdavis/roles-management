class ApiWhitelistedIpUser < ApplicationRecord
  def log_identifier
    "Whitelisted(#{address})"
  end

  def has_access?
    return true
  end

  def is_operator?
    return true
  end

  def is_admin?
    true
  end

  # Whitelisted API users are automatically given regular access
  def role_symbols
    [:access, :api_whitelist]
  end
end
