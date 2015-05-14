module Api
  module V1
    # Provides base API functions not strictly related to roles, people, etc.
    class BaseController < ApplicationController
      filter_access_to :all, :attribute_check => false

      # Simply returns 200 to indicate the API key is valid.
      # filter_access_to will return a forbidden if appropriate.
      def validate
        logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Validated key." }

        render :text => "Ok.", :status => 200
      end
    end
  end
end
