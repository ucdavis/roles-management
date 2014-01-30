class OrganizationsController < ApplicationController
  filter_access_to :all, :attribute_check => true
  filter_access_to :index, :attribute_check => true, :load_method => :load_organizations
  respond_to :json

  # GET /organizations
  # GET /organizations.json
  def index
    respond_with @organizations
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
    respond_with @organization
  end

  # GET /organizations/new
  # GET /organizations/new.json
  def new
    @organization = Organization.new
    
    respond_with @organization
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(params[:organization])

    respond_to do |format|
      if @organization.save
        format.json { render json: @organization, status: :created, location: @organization }
      else
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /organizations/1
  # PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update_attributes(params[:organization])
        format.json { head :no_content }
      else
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
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
