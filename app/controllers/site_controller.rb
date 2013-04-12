class SiteController < ApplicationController
  layout 'site'
  respond_to :html

  def welcome
  end

  def faq
  end

  def contact
  end

  def request_access
  end
  
  # Check for HTTP 200 at /status.json for application issues
  # Use this for future checks
  def status
    respond_to do |format|
      format.json { render :json => { status: 'ok' } }
    end
  end

  def access_denied
    logger.info "#{request.remote_ip}: Loaded access denied page."
    render :status => :forbidden
  end

  def logout
    logger.info "#{current_user.loginid}@#{request.remote_ip}: Loaded log out page."
    CASClient::Frameworks::Rails::Filter.logout(self)
  end

  def about
    # SECUREME
    respond_to do |format|
      format.html { render :partial => "about", :layout => false }
    end
  end
end
