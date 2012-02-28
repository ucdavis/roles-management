class SiteController < ApplicationController
  #include ApplicationHelper
  
  def index
    logger.info "#{current_user.loginid}@#{request.remote_ip}: Loaded front page."
  end

  def administrate
    @ous = Ou.top_level
    @applications = Application.all

    logger.info "#{current_user.loginid}@#{request.remote_ip}: Loaded administrate page."
  end

  def access_denied
    logger.info "#{request.remote_ip}: Loaded access denied page."
  end
  
  def logout
    logger.info "#{current_user.loginid}@#{request.remote_ip}: Loaded log out page."
    CASClient::Frameworks::Rails::Filter.logout(self)
  end
end
