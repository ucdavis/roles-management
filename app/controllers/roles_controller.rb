class RolesController < ApplicationController
  filter_resource_access

  # GET /roles
  def index
    # SECUREME
    @application = Application.find_by_name(params[:application_id])
    @roles = @application.roles

    respond_to do |format|
      format.html
    end
  end

  # GET /roles/1
  def show
    # SECUREME
    @role = Role.find_by_id(params[:id])

    if @role.nil?
      logger.warn "Request made for non-existent role: #{params}"
    end

    respond_to do |format|
      format.text
      format.json { render json: @role }
    end
  end

  # GET /roles/new
  def new
    # SECUREME
    @application = Application.find_by_name(params[:application_id])
    @role = @application.roles.build

    respond_to do |format|
      format.html
    end
  end

  # GET /roles/1/edit
  def edit
    # SECUREME
    @application = Application.find_by_name(params[:application_id])
    @role = @application.roles.find_by_id(params[:id])
  end

  # POST /roles
  def create
    # SECUREME
    @application = Application.find_by_name(params[:application_id])
    @role = @application.roles.build(params[:role])

    respond_to do |format|
      if @role.save
        logger.info "#{current_user.loginid}@#{request.remote_ip}: Created new role, #{params[:role]}."
        format.html { redirect_to application_roles_path(@application), :notice => 'Role was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /roles/1
  def update
    # SECUREME
    @application = Application.find_by_name(params[:application_id])
    @role = @application.roles.find_by_id(params[:id])

    respond_to do |format|
      if @role.update_attributes(params[:role])
        logger.info "#{current_user.loginid}@#{request.remote_ip}: Updated role, #{params[:role]}."
        format.html { redirect_to([@application, @role], :notice => 'Role was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /roles/1
  def destroy
    # SECUREME
    @application = Application.find_by_name(params[:application_id])
    @role = @application.roles.find_by_id(params[:id])
    @role.destroy

    logger.info "#{current_user.loginid}@#{request.remote_ip}: Deleted role, #{params[:role]}."

    respond_to do |format|
      format.html { redirect_to([@application, @role], :notice => 'Role was successfully destroyed.') }
    end
  end
end
