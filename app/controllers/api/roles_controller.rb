class Api::RolesController < Api::BaseController
  # GET /roles
  def index
    @application = Application.find_by_name(params[:application_id])
    @roles = @application.roles

    respond_to do |format|
      format.xml { render :text => @roles.to_xml( :except => [:created_at, :updated_at, :application_id], :include => [ :role_assignments ]) }
    end
  end

  # GET /roles/1
  def show
    @application = Application.find_by_name(params[:application_id])
    @role = @application.roles.find_by_id(params[:id])

    respond_to do |format|
      format.xml { render :text => @role.to_xml( :except => [:created_at, :updated_at], :include => { :people => { :only => [:first, :last, :loginid, :email] } } ) }
    end
  end

  # GET /roles/new
  def new
    @application = Application.find_by_id(params[:application_id])
    @role = @application.roles.build

    respond_to do |format|
      format.xml
    end
  end

  # GET /roles/1/edit
  def edit
    @application = Application.find_by_name(params[:application_id])
    @role = @application.roles.find_by_id(params[:id])
  end

  # POST /roles
  def create
    @application = Application.find_by_id(params[:application_id])
    @role = @application.roles.build(params[:role])

    respond_to do |format|
      if @role.save
        format.html { redirect_to @application, :notice => 'Role was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /roles/1
  def update
    @role = Role.find(params[:id])

    respond_to do |format|
      if @role.update_attributes(params[:role])
        format.html { redirect_to(@role, :notice => 'Role was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /roles/1
  def destroy
    @role = Role.find(params[:id])
    @role.destroy

    respond_to do |format|
      format.html { redirect_to(roles_url) }
    end
  end
end
