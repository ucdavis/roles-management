class Api::GroupsController < Api::BaseController
  # GET /api/groups.json
  def index
    only_ous = params.has_key? :only_ous

    unless only_ous
      @groups = Group.where("name like ?", "%#{params[:q]}%")
    else
      @groups = Group.where("name like ? and code not null", "%#{params[:q]}%")
    end

    respond_to do |format|
      format.json { render :json => @groups }
    end
  end
end
