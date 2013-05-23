class MajorsController < ApplicationController
  filter_access_to :all, :attribute_check => true, :load_method => :load_majors
  respond_to :json

  def index
    respond_with @majors
  end
  
  private
  
  def load_majors
    if params[:q]
      @majors = Major.where("upper(name) like ?", "%#{params[:q]}%")
    else
      @majors = Major.all
    end
  end
end
