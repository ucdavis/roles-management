class RolesController < ApplicationController
  before_filter :load_role, :only => :show
  filter_access_to :all, :attribute_check => true
  filter_access_to :index, :attribute_check => true, :load_method => :load_roles

  # Optionally takes application_id parameter to filter index to only roles from that application
  def index
    respond_to do |format|
      format.json { render json: @roles }
    end
  end

  def show
    @cache_key = "role/" + @role.id.to_s + '/' + @role.updated_at.try(:utc).try(:to_s, :number)

    respond_to do |format|
      format.json { render json: @role }
      format.text
    end
  end

  def update
    if params[:id] and params[:role]
      if @role.update_attributes(role_params)
        @role.touch
        # Reload the group in case the after_save callback destroyed role assignments.
        @role.reload

        @cache_key = "role/" + @role.id.to_s + '/' + @role.updated_at.try(:utc).try(:to_s, :number)

        logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Updated role #{@role.id} (#{@role.token})."

        respond_to do |format|
          format.json { render "roles/show", status: :ok }
        end
      else
        log_message = "#{current_user.log_identifier}@#{request.remote_ip}: Failed to update role #{@role.id}. Reason(s): #{@role.errors.full_messages.join(", ")}"
        logger.error log_message

        AdminMailer.application_error_occurred("dssit-devs-exceptions@ucdavis.edu", log_message).deliver!

        respond_to do |format|
          format.json { render json: @role.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.json { render json: nil, status: 422 }
      end
    end
  end

  private

    def load_role
      # TODO: add equivalent .with_permissions_to(read:)
      @role = Role.find_by_id(params[:id])
    end

    def load_roles
      if params[:application_id]
        # TODO: add equivalent .with_permissions_to(read:)
        @roles = Role.where(:application_id => params[:application_id])
      else
        # TODO: add equivalent .with_permissions_to(read:)
        @roles = Role.all
      end
    end

    def role_params
      params.require(:role).permit(:name, :token, :description, :ad_path,
                                      {role_assignments_attributes: [:id, :entity_id, :role_id, :_destroy]})
    end

end
