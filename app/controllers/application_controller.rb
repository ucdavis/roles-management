class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # Only the API namespace should respond to XML. Be mindful of this!
  before_filter CASClient::Frameworks::Rails::GatewayFilter, :unless => :requested_xml_or_json?
  before_filter :login_required, :unless => :requested_xml_or_json?
  
  before_filter :set_current_user, :unless => :requested_xml_or_json?

  def set_current_user
    Authorization.current_user = @@user
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
  
    session[:return_to] = request.request_uri
  
    return false
  end
  
  protected
  
  def requested_xml_or_json?
    not params[:format].nil? and (params[:format] == "xml" || params[:format] == "json")
  end
  
  def permission_denied
    flash[:error] = "Sorry, you are not allowed to access that page."
    redirect_to root_url
  end
end
