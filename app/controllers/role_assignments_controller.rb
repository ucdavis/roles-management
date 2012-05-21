# Useful with AJAX calls from the CAO interface
class RoleAssignmentsController < ApplicationController
  def create
    unless current_user.can_administer_role? params[:assignment][:role_id] == false    
      @assignment = RoleAssignment.new
      @assignment.role_id = params[:assignment][:role_id]
      
      uid = determine_uid params[:assignment][:uid]
      
      # Person or group?
      if uid[:type] == UID_PERSON
        person_id = uid[:id]
        unless current_user.can_administer_person? person_id == false
          @assignment.person_id = person_id
        end
      else
        group_id = uid[:id]
        unless current_user.can_administer_group? group_id == false
          @assignment.group_id = group_id
        end
      end
    end

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
      uid = determine_uid params[:assignment][:uid]
      
      # Destroying a person-based or group-based role assignment?
      if uid[:type] == UID_PERSON
        # Person
        person_id = params[:assignment][:uid][1..-1].to_i # strip off the UID indicator
        unless current_user.can_administer_person? person_id == false
          @assignment = RoleAssignment.find_by_role_id_and_person_id(params[:assignment][:role_id], person_id)
        end
      else
        # Group
        group_id = params[:assignment][:uid][1..-1].to_i # strip off the UID indicator
        unless current_user.can_administer_group? group_id == false
          @assignment = RoleAssignment.find_by_role_id_and_group_id(params[:assignment][:role_id], group_id)
        end
      end
    
      unless @assignment.nil?
        @assignment.destroy
        logger.info "#{current_user.loginid}@#{request.remote_ip}: Destroyed role assignment of role #{params[:assignment][:role_id]} for entity #{params[:assignment][:uid]}."
      else
        logger.info "#{current_user.loginid}@#{request.remote_ip}: Failed to destroy role assignment of role #{params[:assignment][:role_id]} for entity #{params[:assignment][:uid]}."
      end
    end

    respond_to do |format|
      format.json { head :ok }
    end
  end
end
