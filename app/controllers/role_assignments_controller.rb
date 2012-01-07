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
  
  def destroy
    # Destroying a person-based or group-based role assignment?
    if params[:assignment][:group_id].nil?
      # Person
      @assignment = RoleAssignment.find_by_role_id_and_person_id(params[:assignment])
    else
      # Group
      @assignment = RoleAssignment.find_by_role_id_and_group_id(params[:assignment])
    end
    @assignment.destroy!
    
    #TODO: Ensure logged in user controls this application and person
    
    logger.info "#{current_user.loginid}@#{request.remote_ip}: Destroyed role assignment #{params[:id]}."

    respond_to do |format|
      format.json { head :ok }
    end
  end
end
