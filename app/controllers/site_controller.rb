class SiteController < ApplicationController
  include ApplicationHelper
  
  def index
    logger.info "#{current_user.loginid}@#{request.remote_ip}: Loaded front page."
  end

  def administrate
    logger.info "#{current_user.loginid}@#{request.remote_ip}: Loaded administrate page."
  end

  def contact
  end
  
  def access_denied
    logger.info "#{request.remote_ip}: Loaded access denied page."
  end
  
  def logout
    logger.info "#{current_user.loginid}@#{request.remote_ip}: Loaded log out page."
    CASClient::Frameworks::Rails::Filter.logout(self)
  end
end
