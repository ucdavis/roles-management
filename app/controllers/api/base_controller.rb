class Api::BaseController < ApplicationController
  #skip_before_filter CASClient::Frameworks::Rails::GatewayFilter <-- this doesn't work, so applicationController has a skip_xml?
  # and all controllers avoid offering XML except those in the API namespace
  skip_before_filter :login_required
  
  before_filter :api_authenticate

  protected

  def api_authenticate
    if Rails.env == "development"
      # Pow does not allow for subdomains to be used, so CAS maintain a session,
      # causing trouble for non-RM apps making AJAX requests against it from another
      # Pow-served site. This should not be a problem in production when both RM
      # and the other app are sharing their parent domain (i.e. ucdavis.edu).
      return true
    else
      authenticate_or_request_with_http_basic do |username, password|
        @application = Application.find_by_name(username)
  
        if @application.nil? == false
          # Application exists
          if @application.api_key == password
            return true
          end
        end
  
        raise ActionController::RoutingError.new('Access denied')
  
        return false
      end
    end
  end

end
