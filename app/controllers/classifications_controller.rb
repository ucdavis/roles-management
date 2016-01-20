class ClassificationsController < ApplicationController
  filter_access_to :all, :attribute_check => true
  filter_access_to :index, :attribute_check => true, :load_method => :load_classifications

  def index
    respond_to do |format|
      format.json { render json: @classifications }
    end
  end

  private

  def load_classifications
    if params[:q]
      classifications_table = Classification.arel_table
      @classifications = Classification.with_permissions_to(:read).where(classifications_table[:name].matches("%#{params[:q]}%"))
    else
      @classifications = Classification.with_permissions_to(:read).all
    end
  end
end
