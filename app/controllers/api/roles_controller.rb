class Api::RolesController < Api::BaseController
  # GET /roles/1.txt
  def show
    @role = Role.find_by_id(params[:id])

    render "roles/show"
    # respond_to do |format|
    #   format.text
    # end
  end
end
