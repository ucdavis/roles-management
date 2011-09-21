class Api::BaseController < ApplicationController
  before_filter :api_authenticate

  protected

  def api_authenticate
    if session[:cas_user].nil?
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
