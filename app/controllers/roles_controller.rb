class RolesController < ApplicationController
  # GET /roles
  def index
    @application = Application.find_by_name(params[:application_id])
    @roles = @application.roles

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /roles/1
  def show
    @application = Application.find_by_name(params[:application_id])
    @role = @application.roles.find_by_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /roles/new
  def new
    @application = Application.find_by_name(params[:application_id])
    @role = @application.roles.build

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /roles/1/edit
  def edit
    @application = Application.find_by_name(params[:application_id])
    @role = @application.roles.find_by_id(params[:id])
    
    debugger
  end

  # POST /roles
  def create
    @application = Application.find_by_name(params[:application_id])
    @role = @application.roles.build(params[:role])

    respond_to do |format|
      if @role.save
        format.html { redirect_to application_roles_path(@application), :notice => 'Role was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /roles/1
  def update
    @application = Application.find_by_name(params[:application_id])
    @role = @application.roles.find_by_id(params[:id])

    respond_to do |format|
      if @role.update_attributes(params[:role])
        format.html { redirect_to([@application, @role], :notice => 'Role was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /roles/1
  def destroy
    @application = Application.find_by_name(params[:application_id])
    @role = @application.roles.find_by_id(params[:id])
    @role.destroy

    respond_to do |format|
      format.html { redirect_to([@application, @role], :notice => 'Role was successfully destroyed.') }
    end
  end
end
