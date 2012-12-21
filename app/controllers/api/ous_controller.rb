class Api::OusController < Api::BaseController
  # GET /api/ous.json
  def index
    @groups = Group.where(Group.arel_table[:code].not_eq(nil)).where("name like ?", "%#{params[:q]}%")

    respond_to do |format|
      format.json { render :json => @groups }
    end
  end
end
