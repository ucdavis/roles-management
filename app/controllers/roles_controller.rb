class RolesController < ApplicationController
  filter_access_to :all, :attribute_check => true
  respond_to :json

  # Optionally takes application_id parameter to filter index to only roles from that application
  def index
    if params[:application_id]
      @roles = Role.where(:application_id => params[:application_id])
    else
      @roles = Role.all
    end

    respond_with @roles
  end

  def show
    @role = Role.find_by_id(params[:id])
    respond_with(@role) do |format|
      format.text
    end
  end
  
  # Forces a role to sync
  def sync
    @role = Role.find_by_id(params[:role_id])
    @role.force_sync = true
    @role.sync_ad
    
    respond_with :ok
  end
end
