class ApplicationController < ActionController::Base
  include Authentication
  include SafeFilename
  helper :all
  protect_from_forgery

  before_filter :authenticate

  protected

  def permission_denied
    if session[:auth_via] == :cas
      # Human-facing error
      flash[:error] = "Sorry, you are not allowed to access that page."
      redirect_to access_denied_path
    else
      # Machine-facing error
      render :text => "Permission denied.", :status => 403
    end
  end
end
