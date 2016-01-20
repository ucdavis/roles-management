class MajorsController < ApplicationController
  filter_access_to :all, :attribute_check => true, :load_method => :load_majors

  def index
    respond_to do |format|
      format.json { render json: @majors }
    end
  end

  private

  def load_majors
    if params[:q]
      majors_table = Major.arel_table
      @majors = Major.with_permissions_to(:read).where(majors_table[:name].matches("%#{params[:q]}%"))
    else
      @majors = Major.with_permissions_to(:read).all
    end
  end
end
