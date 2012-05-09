class ApplicationController < ActionController::Base
  include Authentication
  helper :all
  protect_from_forgery
  
  # Only the API namespace should respond to XML. Be mindful of this!
  before_filter CASClient::Frameworks::Rails::GatewayFilter, :unless => :requested_api?
  before_filter :login_required, :unless => :requested_api?
  before_filter :set_current_user, :unless => :requested_api?
  skip_before_filter :set_current_user, :only => [:access_denied]
  
  protected
  
  def requested_api?
    controller_path[0..3] == "api/"
  end
  
  def permission_denied
    flash[:error] = "Sorry, you are not allowed to access that page."
    redirect_to :controller => 'site', :action => 'access_denied'
  end
  
  def allowed_to?(action, controller)
    view_context.allowed_to?(action, controller)
  end
  
  # 'uids' is a list of UIDs (see README)
  # Set flatten to true if you want group membership resolved so the list is only Person objects
  def resolve_uids(uids, flatten = false)
    if flatten
      results = []
    else
      results = {}
      results[:people] = []
      results[:groups] = []
    end
    
    uids.each do |uid|
      id = uid[1..-1]
      if uid[0] == '1'
        p = Person.find_by_id(id)
        if p
          if flatten
            results << p
          else
            results[:people] << p
          end
        end
      elsif uid[0] == '2'
        g = Group.find_by_id(id)
        if g
          if flatten
            g.members.each do |m|
              results << m
            end
          else
            results[:groups] << g
          end
        end
      end
    end
    
    results
  end
end
