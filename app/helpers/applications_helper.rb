module ApplicationsHelper
  def cache_key_for_applications
    # Admins share the same application list
    loginid        = 'access-' + current_user.loginid
    count          = Application.count
    max_updated_at = Application.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "#{loginid}/applications/all-#{count}-#{max_updated_at}"
  end

  def cache_key_for_current_user
    loginid        = current_user.loginid
    max_updated_at = current_user.updated_at.try(:utc).try(:to_s, :number)
    "#{loginid}/current_user/#{max_updated_at}"
  end

  # This helper exists under 'applications' because the 'About' dialog is
  # technically served by Applications#index. Not great but not bad either.
  #
  # Attempts to obtain the last updated date by asking git
  def get_last_updated
    return nil
    # begin
    #   output = IO.popen('git show --pretty=%cD')
    #   return output.readline.gsub(/\n/, "") # git show ends with two newline characters
    # rescue Errno::ENOENT => e
    #   return nil # Command not found, oh well ...
    # end
  end
end
