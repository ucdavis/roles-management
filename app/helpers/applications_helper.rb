module ApplicationsHelper
  def cache_key_for_applications
    loginid        = current_user.loginid
    count          = Application.count
    max_updated_at = Application.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "#{loginid}/applications/all-#{count}-#{max_updated_at}"
  end

  def cache_key_for_current_user
    loginid        = current_user.loginid
    max_updated_at = current_user.updated_at.try(:utc).try(:to_s, :number)
    "#{loginid}/current_user/#{max_updated_at}"
  end
end
