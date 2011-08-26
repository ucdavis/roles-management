class Api::OusController < Api::BaseController
  # GET /api/ous.json
  def index
    @ous = Ou.where("name like ?", "%#{params[:q]}%")

    respond_to do |format|
      format.json { render :json => @ous.map(&:attributes) }
    end
  end

  # GET /api/ous/DSS%20Blue%20Cluster.xml
  def show
    @ou = Ou.find_by_name(params[:id])

    respond_to do |format|
      format.xml
    end
  end
end
