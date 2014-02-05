class OrganizationsController < ApplicationController
  filter_access_to :all, :attribute_check => true
  filter_access_to :index, :attribute_check => true, :load_method => :load_organizations
  respond_to :json

  # GET /organizations.json
  def index
    respond_with @organizations
  end

  # GET /organizations/1.json
  def show
    respond_with @organization
  end

  private
  
  def load_organizations
    if params[:q]
      organizations_table = Organization.arel_table
      
      # Search login IDs in case of an entity-search but looking for person by login ID
      @organizations = Organization.with_permissions_to(:read).where(organizatoins_table[:name].matches("%#{params[:q]}%").or(organizations_table[:code].matches("%#{params[:q]}%")))
      
      logger.debug "Organizations#index searching for '#{params[:q]}'. Found #{@organizations.length} results."
    else
      @organizations = Organization.with_permissions_to(:read).all
    end
  end
end
