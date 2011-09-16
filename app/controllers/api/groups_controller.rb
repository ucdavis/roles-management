class Api::GroupsController < Api::BaseController
  # GET /api/groups.json
  def index
    @groups = Group.where("name like ?", "%#{params[:q]}%")

    respond_to do |format|
      format.json { render :json => @groups.map(&:attributes) }
    end
  end

  # GET /api/groups/1.xml
  def show
    @group = Group.find_by_name(params[:id])

    respond_to do |format|
      format.xml
      format.text
    end
  end
end
