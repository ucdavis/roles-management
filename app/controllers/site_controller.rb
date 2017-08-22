class SiteController < ApplicationController
  layout 'site'
  skip_before_action :authenticate, only: [:status, :welcome, :access_denied, :logout]
  skip_after_action :verify_authorized, only: [:status, :welcome, :access_denied, :help, :logout]

  def welcome
    respond_to do |format|
      format.html
    end
  end

  def help
    respond_to do |format|
      format.html
    end
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
    @show_unimpersonate_link = impersonating?
    render :status => :forbidden
  end

  def logout
    if current_user
      logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded log out page."
    else
      logger.info "#{request.remote_ip}: Loaded log out page."
    end
    CASClient::Frameworks::Rails::Filter.logout(self)
  end
end
