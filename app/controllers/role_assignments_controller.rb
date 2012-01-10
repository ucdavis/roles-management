# Used for AJAX calls from the CAO interface
class RoleAssignmentsController < ApplicationController
  def create
    # assignment = { :person_id (or :group_id), :role_id }
    @assignment = RoleAssignment.new(params[:assignment])

    #TODO: Ensure logged in user controls that application and person

    respond_to do |format|
      if @assignment.save!
        logger.info "#{current_user.loginid}@#{request.remote_ip}: Assigned role #{params[:assignment]}."
        format.json { render json: @assignment, status: :created }
      else
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  #$.ajax({ url: Routes.roles_unassign_path() + ".json", data: {assignment: assignment}, type: 'DELETE'})
  def destroy
    #TODO: Ensure logged in user controls this person
    unless current_user.can_administer_role? params[:assignment][:role_id] == false    
      # Destroying a person-based or group-based role assignment?
      if params[:assignment][:group_id].nil?
        # Person
        unless current_user.can_administer_person? params[:assignment][:person_id] == false
          @assignment = RoleAssignment.find_by_role_id_and_person_id(params[:assignment][:role_id], params[:assignment][:person_id])
        end
      else
        # Group
        unless current_user.can_administer_group? params[:assignment][:group_id] == false
          @assignment = RoleAssignment.find_by_role_id_and_group_id(params[:assignment][:role_id], params[:assignment][:group_id])
        end
      end
    
      unless @assignment.nil? @assignment.destroy
    
      logger.info "#{current_user.loginid}@#{request.remote_ip}: Destroyed role assignment #{params[:assignment][:id]}."
    end

    respond_to do |format|
      format.json { head :ok }
    end
  end
end
