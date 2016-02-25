class Admin::BaseController < ApplicationController
#   def permission_denied
#     respond_to do |format|
#       format.json { render json: {}, status: :forbidden }
#     end
#   end

  private

    # Ensure /admin/ operations authorize against the actual user,
    # not an impersonated user.
    def current_user
      Authentication.actual_user
    end
end
