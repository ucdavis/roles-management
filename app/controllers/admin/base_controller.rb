class Admin::BaseController < ApplicationController
  filter_access_to :all

  def permission_denied
    respond_to do |format|
      format.json { render json: [], status: :unprocessable_entity }
    end
  end

  private

  # Ensure /admin/ operations authorize against the actual user,
  # not an impersonated user.
  def current_user
    actual_user
  end
end
