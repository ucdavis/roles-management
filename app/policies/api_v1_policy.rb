class ApiV1Policy < BasePolicy
  def use?
    return true if user.is_a? ApiKeyUser
    return true if user.is_a? ApiWhitelistedIpUser
    false
  end
end
