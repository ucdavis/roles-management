class Api::BaseController < ApplicationController
  #skip_before_filter CASClient::Frameworks::Rails::GatewayFilter <-- this doesn't work, so applicationController has a skip_xml?
  # and all controllers avoid offering XML except those in the API namespace
  skip_before_filter :login_required
  
  before_filter :api_authenticate

  protected

  def api_authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "foo" && password == "bar"
    end
  end
end
