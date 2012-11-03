class ApplicationController < ActionController::Base
  include Authentication
  helper :all
  protect_from_forgery

  before_filter CASClient::Frameworks::Rails::GatewayFilter, :unless => :requested_api?
  before_filter :set_current_user # it's okay that they might not be using CAS
  before_filter :login_required, :unless => :requested_api?
  skip_before_filter :login_required, :only => [:access_denied]

  protected

  def requested_api?
    controller_path[0..3] == "api/"
  end

  def permission_denied
    flash[:error] = "Sorry, you are not allowed to access that page."
    redirect_to :controller => 'site', :action => 'access_denied'
  end

  def _permitted_to?(action, controller)
    view_context._permitted_to?(action, controller)
  end
end
