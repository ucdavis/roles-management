# Used for AJAX calls from the CAO interface
class RoleAssignmentsController < ApplicationController
  def create
    @assignment = RoleAssignment.new
    
    @assignment.role_id = params[:assignment][:role_id]
    # Person or group?
    if params[:assignment][:entity_id][0] == '1'
      @assignment.person_id = params[:assignment][:entity_id][1..-1].to_i
    else
      @assignment.group_id = params[:assignment][:entity_id][1..-1].to_i
    end

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
    unless current_user.can_administer_role? params[:assignment][:role_id] == false    
      # Destroying a person-based or group-based role assignment?
      if params[:assignment][:entity_id][0] == '1'
        # Person
        person_id = params[:assignment][:entity_id][1..-1].to_i # strip off the UID indicator
        unless current_user.can_administer_person? person_id == false
          @assignment = RoleAssignment.find_by_role_id_and_person_id(params[:assignment][:role_id], person_id)
        end
      else
        # Group
        group_id = params[:assignment][:entity_id][1..-1].to_i # strip off the UID indicator
        unless current_user.can_administer_group? group_id == false
          @assignment = RoleAssignment.find_by_role_id_and_group_id(params[:assignment][:role_id], group_id)
        end
      end
    
      unless @assignment.nil?
        @assignment.destroy
      end
      
      logger.info "#{current_user.loginid}@#{request.remote_ip}: Destroyed role assignment #{params[:assignment][:id]}."
    end

    respond_to do |format|
      format.json { head :ok }
    end
  end
end
