class ApiV1Policy < BasePolicy
  def use?
    return true if user.is_a? ApiKeyUser
    false
  end
end