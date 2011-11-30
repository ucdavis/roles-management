class Api::TitlesController < Api::BaseController
  # GET /api/titles.json
  def index
    @titles = Title.where("name like ?", "%#{params[:q]}%")

    respond_to do |format|
      format.json { render :json => @titles.map(&:attributes) }
    end
  end
end
