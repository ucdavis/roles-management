class MajorsController < ApplicationController
  filter_access_to :all, :attribute_check => true, :load_method => :load_majors
  respond_to :json

  def index
    respond_with @majors
  end
  
  private
  
  def load_majors
    if params[:q]
      majors_table = Major.arel_table
      @majors = Major.with_permissions_to(:read).where(majors_table[:name].matches("%#{params[:q]}%"))
    else
      @majors = Major.all
    end
  end
end
