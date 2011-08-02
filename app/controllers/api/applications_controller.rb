class Api::ApplicationsController < Api::BaseController
  require 'digest/md5'
  
  # GET /applications
  def index
    @applications = Application.all

    respond_to do |format|
      format.xml { render :text => @applications.to_xml( :except => [:api_key, :created_at, :id, :updated_at] ) }
    end
  end

  # GET /applications/1
  def show
    @application = Application.find_by_name(params[:id])

    respond_to do |format|
      format.xml { render :text => @application.to_xml( :except => [:api_key, :created_at, :id, :updated_at] ) }
    end
  end

  # GET /applications/new
  def new
    @application = Application.new

    respond_to do |format|
      format.html # new.html.erb
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
        format.html { redirect_to(@application, :notice => 'Application was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /applications/1
  def update
    @application = Application.find(params[:id])

    respond_to do |format|
      if @application.update_attributes(params[:application])
        format.html { redirect_to(@application, :notice => 'Application was successfully updated.') }
      else
        format.html { render :action => "edit" }
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
  
  private
  
  def generate_api_key(application)
    api_key_settings = YAML.load_file("#{Rails.root.to_s}/config/api_keys.yml")['development']
    
    Digest::MD5.hexdigest(application.name + application.hostname + api_key_settings['key']) # last string should be unique to 
  end
end
