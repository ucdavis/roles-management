class Admin::BaseController < ApplicationController
  private
    # Ensure /admin/ operations authorize against the actual user,
    # not an impersonated user.
    def current_user
      Authentication.actual_user
    end
end
