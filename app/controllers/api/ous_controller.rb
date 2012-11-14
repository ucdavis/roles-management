class Api::OusController < Api::BaseController
  # GET /api/ous.json
  def index
    @groups = Group.where("name like ? and code not null", "%#{params[:q]}%")

    respond_to do |format|
      format.json { render :json => @groups }
    end
  end
end
