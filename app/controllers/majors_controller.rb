class MajorsController < ApplicationController
  filter_access_to :all, :attribute_check => true
  respond_to :json

  def index
    if params[:q]
      @majors = Major.where("upper(name) like ?", "%#{params[:q]}%")
    else
      @majors = Major.all
    end

    respond_with @majors
  end
end
