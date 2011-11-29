class GroupsController < ApplicationController
  before_filter :load_group, :only => [:show]
  filter_resource_access

  # GET /groups
  def index
    @groups = Group.where("name like ?", "%#{params[:q]}%")

    logger.info "#{current_user.loginid}@#{request.remote_ip}: Loaded group index."

    respond_to do |format|
      format.html
    end
  end

  # GET /groups/1
  def show
    @group = Group.find_by_name(params[:id])

    logger.info "#{current_user.loginid}@#{request.remote_ip}: Loaded group page for #{params[:id]}."

    respond_to do |format|
      format.html
    end
  end

  # GET /groups/new
  def new
    @group = Group.new

    respond_to do |format|
      format.html
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find_by_name(params[:id])
  end

  # POST /groups
  def create
    @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save!
        logger.info "#{current_user.loginid}@#{request.remote_ip}: Created group #{params[:group]}."
        format.html { redirect_to(@group, :notice => 'Group was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /groups/1
  def update
    @group = Group.find_by_name(params[:id])
    
    logger.info "#{current_user.loginid}@#{request.remote_ip}: Updated group #{params[:id]}."

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to(@group, :notice => 'Group was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /groups/1
  def destroy
    @group = Group.find_by_name(params[:id])
    @group.destroy!
    
    logger.info "#{current_user.loginid}@#{request.remote_ip}: Deleted group #{params[:id]}."

    respond_to do |format|
      format.html { redirect_to(groups_url) }
    end
  end
  
  protected
  
  def load_group
    if permitted_to? :show, :groups
      @group = Group.find_by_name(params[:id])
    end
  end
end
