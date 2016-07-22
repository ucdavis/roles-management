module Api
  module V1
    # Provides base API functions not strictly related to roles, people, etc.
    class BaseController < ApplicationController
      # The API controller use session-less API keys so CSRF is not appropriate here.
      skip_before_action :verify_authenticity_token

      # Simply returns 200 to indicate the API key is valid.
      def validate
        authorize :api_v1, :use?
        
        logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Validated key." }

        render :text => "Ok.", :status => 200
      end
    end
  end
end
