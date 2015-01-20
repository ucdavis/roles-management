class RolesController < ApplicationController
  before_filter :load_role, :only => :show
  filter_access_to :all, :attribute_check => true
  filter_access_to :index, :attribute_check => true, :load_method => :load_roles
  respond_to :json

  # Optionally takes application_id parameter to filter index to only roles from that application
  def index
    respond_with @roles
  end

  def show
    @cache_key = "role/" + @role.id.to_s + '/' + @role.updated_at.try(:utc).try(:to_s, :number)

    respond_with(@role) do |format|
      format.text
    end
  end

  def update
    if params[:id] and params[:role]
      if @role.update_attributes(params[:role].except(:id))
        @role.touch
        # Reload the group in case the after_save callback destroyed role assignments.
        @role.reload

        @cache_key = "role/" + @role.id.to_s + '/' + @role.updated_at.try(:utc).try(:to_s, :number)

        logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Updated role #{@role.id} (#{@role.token})."

        respond_with(@role) do |format|
          format.json { render "roles/show", status: :ok }
        end
      else
        logger.error "#{current_user.log_identifier}@#{request.remote_ip}: Failed to update role #{@role.id}. Reason(s): #{@role.errors.full_messages.join(", ")}"
        respond_with(@role) do |format|
          format.json { render json: @role.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_with 422
    end
  end

  # # Forces a role to sync (used by a button in application modal)
  # def sync
  #   @role = Role.find_by_id(params[:role_id])
  #   @role.trigger_sync!
  #
  #   respond_with :ok
  # end

  private

  def load_role
    @role = Role.with_permissions_to(:read).find_by_id(params[:id])
  end

  def load_roles
    if params[:application_id]
      @roles = Role.with_permissions_to(:read).where(:application_id => params[:application_id])
    else
      @roles = Role.with_permissions_to(:read).all
    end
  end
end
