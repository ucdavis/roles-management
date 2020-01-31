class RoleAssignmentsController < ApplicationController
  before_action :new_role_assignment_from_params, only: :create

  def create
    authorize @role_assignment

    role = Role.find_by(id: role_assignment_params['role_id'])
    entity = Entity.find_by(id: role_assignment_params['entity_id'])

    @role_assignment = RoleAssignmentsService.assign_role_to_entity(entity, role)

    logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Created new role assignment, #{params[:role_assignment]}."

    @cache_key = 'role_assignments/' + @role_assignment.id.to_s + '/' + @role_assignment.updated_at.try(:utc).try(:to_s, :number)

    respond_to do |format|
      format.json { render 'role_assignments/show', status: :ok }
    end
  end

  def destroy
    @role_assignment = RoleAssignment.find(params[:id])

    authorize @role_assignment

    RoleAssignmentsService.unassign_role_from_entity(@role_assignment)

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
