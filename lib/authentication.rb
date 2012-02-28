# Note: This code modified from Ryan Bates' RailsCasts Episode #188
#       http://railscasts.com/episodes/188-declarative-authorization
#
# This module is included in the application controller which makes
# several methods available to all controllers and views. Here's a
# common example:
# 
#   <% if logged_in? %>
#     Welcome <%=h current_user.username %>! Not you?
#     <%= link_to "Log out", logout_path %>
#   <% else %>
#     <%= link_to "Sign up", signup_path %> or
#     <%= link_to "log in", login_path %>.
#   <% end %>
module Authentication
  def self.included(controller)
    #controller.send :helper_method, :current_user, :logged_in?, :redirect_to_target_or_default
  end
  
  def set_current_user
    Authorization.current_user = @@user
    
    # Redirect to access denied if the user isn't in our database
    if @@user.nil?
      redirect_to :controller => "site", :action => "access_denied"
    end
  end
  
  # Returns the current user, which may be an impersonated user.
  # actual_user() will return the actual user, even if impersonating.
  # If you're unsure which to use, just use this one.
  def current_user
    if session[:impersonate]
      Person.find_by_loginid(session[:impersonate])
    else
      @@user
    end
  end
  
  # Only use this if you know you don't want current_user, e.g. "Log out"
  # Most code will want current_user to work transparently with impersonation
  def actual_user
    @@user
  end
  
  # Returns true if we're currently impersonating another user
  def impersonating?
    actual_user == current_user
  end
  
  def login_required
    if session[:cas_user]
      begin
        @@user = Person.find_by_loginid(session[:cas_user])
        return true
      rescue Exception => e
        # User not found
        flash[:error] = 'You have authenticated but are not allowed access.'
        @@user = nil
      end
    else
      flash[:error] = 'You must authenticate with CAS to continue.'
      store_target_location
      redirect_to CASClient::Frameworks::Rails::Filter.login_url(self)
    end
  
    session[:return_to] = request.fullpath
  
    return false
  end
  
  def logged_in?
    current_user
  end
  
  def redirect_to_target_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
  private
  
  def store_target_location
    session[:return_to] = request.url
  end
end
