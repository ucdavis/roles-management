class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # Only the API namespace should respond to XML. Be mindful of this!
  before_filter CASClient::Frameworks::Rails::GatewayFilter, :unless => :requested_api?
  before_filter :login_required, :unless => :requested_api?
  before_filter :set_current_user, :unless => :requested_api?
  skip_before_filter :set_current_user, :only => [:access_denied]

  def set_current_user
    Authorization.current_user = @@user
    
    # Redirect to access denied if the user isn't in our database
    if @@user.nil?
      redirect_to :controller => "site", :action => "access_denied"
    end
  end
  
  def current_user
    @@user
  end

  def login_required
    if session[:cas_user]
      begin
        @@user = Person.find_by_loginid(session[:cas_user])
        return true
      rescue Exception => e
        # User not found
        flash[:warning] = 'You have authenticated but are not allowed access.'
        @@user = nil
      end
    else
      flash[:warning] = 'You must authenticate with CAS to continue.'
      redirect_to CASClient::Frameworks::Rails::Filter.login_url(self)
    end
  
    session[:return_to] = request.fullpath
  
    return false
  end
  
  protected
  
  def requested_api?
    controller_path[0..3] == "api/"
  end
  
  def permission_denied
    flash[:error] = "Sorry, you are not allowed to access that page."
    redirect_to root_url
  end
end
