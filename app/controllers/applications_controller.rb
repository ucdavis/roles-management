class ApplicationsController < ApplicationController
  require 'digest/md5'
  
  before_filter :load_application, :only => [:show]
  
  filter_resource_access
  
  # GET /applications
  def index
    @applications = Application.all

    respond_to do |format|
      format.html
    end
  end

  # GET /applications/1
  def show
    respond_to do |format|
      format.html { render :partial => "details", :layout => false }
    end
  end

  # GET /applications/new
  def new
    @application = Application.new

    respond_to do |format|
      format.html
    end
  end

  # GET /applications/1/edit
  def edit
    @application = Application.find(params[:id])
  end

  # POST /applications
  def create
    @application = Application.new(params[:application])
    
    @application.api_key = generate_api_key(@application)

    respond_to do |format|
      if @application.save
        # Also create the mandatory, default "access" role
        r = Role.new
        r.token = "access"
        r.default = false
        r.mandatory = true
        r.descriptor = "Access"
        r.description = "Allow access to this application"
        @application.roles << r
        
        format.html { redirect_to(@application, :notice => 'Application was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /applications/1
  def update
    @application = Application.find(params[:id])

    if params[:commit] == "reset"
      @application.api_key = generate_api_key(@application)
    end
    
    respond_to do |format|
      if @application.update_attributes(params[:application])
        format.html { redirect_to(@application, :notice => 'Application was successfully updated.') }
        format.js { head :ok }
      else
        format.html { render :action => "edit" }
        format.js { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applications/1
  def destroy
    @application = Application.find(params[:id])
    @application.destroy

    respond_to do |format|
      format.html { redirect_to(applications_url) }
    end
  end
  
  protected
  
  def load_application
    if permitted_to? :show, :applications
      @application = Application.find(params[:id])
    end
  end
  
  private
  
  def generate_api_key(application)
    Digest::MD5.hexdigest(application.name + application.hostname + Time.now.to_i.to_s)
  end
end
