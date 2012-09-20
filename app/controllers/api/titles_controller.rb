class Api::TitlesController < Api::BaseController
  # GET /api/titles.json
  def index
    @titles = Title.where("name like ? or code like ?", "%#{params[:q]}%", "%#{params[:q]}%")

    respond_to do |format|
      format.json { render :json => @titles }
    end
  end
end
