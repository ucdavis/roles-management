class Admin::BaseController < ApplicationController
  filter_access_to :all
  
  def permission_denied
    respond_to do |format|
      format.json { render json: [], status: :unprocessable_entity }
    end
  end
end
