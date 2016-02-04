class MajorsController < ApplicationController
  before_filter :load_majors, :only => :index

  def index
    respond_to do |format|
      format.json { render json: @majors }
    end
  end

  private

  def load_majors
    if params[:q]
      majors_table = Major.arel_table
      @majors = Major.where(majors_table[:name].matches("%#{params[:q]}%"))
    else
      @majors = Major.all
    end
  end
end
