class Api::RolesController < Api::BaseController
  # Searches all the roles for a given application
  def index
    @roles = Role.where(:application_id => params[:app_id])

    render "api/roles/index"
  end

  # GET /roles/1.txt
  def show
    @role = Role.find_by_id(params[:id])

    render "roles/show"
  end
end
