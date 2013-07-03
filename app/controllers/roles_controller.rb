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
    respond_with(@role) do |format|
      format.text
    end
  end
  
  def update
    if params[:id] and params[:role]
      @role.update_attributes(params[:role].except(:id))
      
      # Overridden to respond with the object and not a '204 No Content'.
      # See: http://stackoverflow.com/questions/9953887/simple-respond-with-in-rails-that-avoids-204-from-put
      respond_with(@role) do |format|
        format.json { render json: @role }
      end
    else
      respond_with 422
    end
  end
  
  # Forces a role to sync
  def sync
    @role = Role.find_by_id(params[:role_id])
    @role.force_sync = true
    @role.sync_ad
    
    respond_with :ok
  end
  
  private
  
  def load_role
    @role = Role.find_by_id(params[:id])
  end
  
  def load_roles
    if params[:application_id]
      @roles = Role.where(:application_id => params[:application_id])
    else
      @roles = Role.all
    end
  end
end
