class RoleAssignmentsController < ApplicationController
  before_action :new_role_assignment_from_params, only: :create

  def create
    authorize @role_assignment

    if @role_assignment.save
      logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Created new role assignment, #{params[:role_assignment]}."
      @role_assignment.role.touch
    else
      logger.warn "#{current_user.log_identifier}@#{request.remote_ip}: Failed to create new role assignment, #{params[:role_assignment]}."
    end

    @cache_key = 'role_assignments/' + @role_assignment.id.to_s + '/' + @role_assignment.updated_at.try(:utc).try(:to_s, :number)

    respond_to do |format|
      format.json { render 'role_assignments/show', status: :ok }
    end
  end

  def destroy
    @role_assignment = RoleAssignment.find(params[:id])

    authorize @role_assignment

    @role_assignment.destroy

    logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Deleted role assignment, #{params[:role_assignment]}."

    @role_assignment.role.touch

    @cache_key = 'role_assignments/' + @role_assignment.id.to_s + '/' + @role_assignment.updated_at.try(:utc).try(:to_s, :number)

    respond_to do |format|
      format.json { render 'role_assignments/show', status: :ok }
    end
  end

  private

  def new_role_assignment_from_params
    @role_assignment = RoleAssignment.new(role_assignment_params)
  end

  def role_assignment_params
    params.require(:role_assignment).permit(:role_id, :entity_id)
  end
end
