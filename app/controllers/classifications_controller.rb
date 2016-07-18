class ClassificationsController < ApplicationController
  before_filter :load_classifications, :only => :index

  def index
    authorize Classification
    
    respond_to do |format|
      format.json { render json: @classifications }
    end
  end

  private

    def load_classifications
      if params[:q]
        classifications_table = Classification.arel_table
        @classifications = Classification.where(classifications_table[:name].matches("%#{params[:q]}%"))
      else
        @classifications = Classification.all
      end
    end
end
