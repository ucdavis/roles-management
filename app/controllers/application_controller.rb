class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter CASClient::Frameworks::Rails::Filter
  
  before_filter :login_required
  
  def login_required
    if session[:cas_user]
      begin
        @@user = Person.find_by_loginid(session[:cas_user])
        return true
      rescue Exception => e
        # User not found
        flash[:warning] = 'You have authenticated but are not in the database.'
        @@user = nil
      end
    else
      flash[:warning] = 'You must authenticate with CAS to continue.'
    end
    
    session[:return_to] = request.request_uri
    
    redirect_to :controller => "site", :action => "index"
    
    return false 
  end
end
