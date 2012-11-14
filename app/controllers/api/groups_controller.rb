class Api::GroupsController < Api::BaseController
  # GET /api/groups.json
  def index
    @groups = Group.where("name like ? and code is null", "%#{params[:q]}%")

    respond_to do |format|
      format.json { render :json => @groups }
    end
  end
end
