class ApplicationController < ActionController::Base
  include Authentication
  include SafeFilename
  helper :all
  protect_from_forgery

  before_filter :authenticate
  before_filter :no_cache_for_dev_mode

  protected

  def permission_denied
    flash[:error] = "Sorry, you are not allowed to access that page."
    redirect_to :controller => 'site', :action => 'access_denied'
  end
  
  def no_cache_for_dev_mode
    if Rails.env.development?
      response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    end
  end
end
