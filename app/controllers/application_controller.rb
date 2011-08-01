class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter CASClient::Frameworks::Rails::GatewayFilter, :unless => :requested_xml?
  before_filter :login_required, :unless => :requested_xml?
  
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
    #else
    #  flash[:warning] = 'You must authenticate with CAS to continue.'
    end
  
    #session[:return_to] = request.request_uri
  
    redirect_to CASClient::Frameworks::Rails::Filter.login_url(self)
  
    return false
  end
  
  protected
  
  def requested_xml?
    #%w(PeopleController).include? params[:controller]
    not params[:format].nil? and params[:format] == "xml"
  end
end
