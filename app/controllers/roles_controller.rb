class RolesController < ApplicationController
  before_action :load_role, only: :show
  before_action :load_roles, only: :index

  # Optionally takes application_id parameter to filter index to only roles from that application
  def index
    authorize Role

    respond_to do |format|
      format.json { render json: @roles }
    end
  end

  def show
    authorize @role

    @cache_key = 'role/' + @role.id.to_s + '/' + @role.updated_at.try(:utc).try(:to_s, :number)

    @role.update_column(:last_accessed, Time.now)

    respond_to do |format|
      format.json { render 'roles/show', status: :ok }
      format.text
    end
  end

  private

  def load_role
    @role = Role.includes(:role_assignments).includes(:entities).find_by_id!(params[:id])
  end

  def load_roles
    @roles = if params[:application_id]
               Role.where(application_id: params[:application_id])
             else
               Role.all
             end
  end
end
