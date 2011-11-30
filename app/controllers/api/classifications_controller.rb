class Api::ClassificationsController < Api::BaseController
  # GET /api/classifications.json
  def index
    @classifications = Classification.where("name like ?", "%#{params[:q]}%")

    respond_to do |format|
      format.json { render :json => @classifications.map(&:attributes) }
    end
  end
end
