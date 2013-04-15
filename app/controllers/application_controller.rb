class ApplicationController < ActionController::Base
  include Authentication
  include SafeFilename
  helper :all
  protect_from_forgery

  before_filter :authenticate

  protected

  def permission_denied
    flash[:error] = "Sorry, you are not allowed to access that page."
    redirect_to :controller => 'site', :action => 'access_denied'
  end
end
