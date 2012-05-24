class GroupsController < ApplicationController
  before_filter :load_group, :only => [:show]
  filter_access_to :all

  # GET /groups
  def index
    @groups = Group.where("name like ?", "%#{params[:q]}%")

    logger.info "#{current_user.loginid}@#{request.remote_ip}: Loaded group index."

    respond_to do |format|
      format.html
      format.json { render json: @group }
    end
  end

  # GET /groups/1
  def show
    logger.info "#{current_user.loginid}@#{request.remote_ip}: Loaded group page for #{params[:id]}."

    respond_to do |format|
      format.html { render "show", :layout => false }
      format.json { render json: @group }
    end
  end

  # GET /groups/new
  def new
    @group = Group.new

    3.times do
      @group.rules.build
    end

    respond_to do |format|
      format.html
      format.json { render json: @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find_by_id(params[:id])
  end

  # POST /groups
  def create
    @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save!
        logger.info "#{current_user.loginid}@#{request.remote_ip}: Created group #{params[:group]}."
        format.html { redirect_to(@group, :notice => 'Group was successfully created.') }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render :action => "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  def update
    @group = Group.find_by_id(params[:id])
    
    logger.info "#{current_user.loginid}@#{request.remote_ip}: Updated group #{params[:id]}."

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to(@group, :notice => 'Group was successfully updated.') }
        format.js { head :ok }
      else
        format.html { render :action => "edit" }
        format.js { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  def destroy
    unless current_user.can_administer_group? params[:id] == false
      @group = Group.find_by_id(params[:id])
      @group.destroy
    
      logger.info "#{current_user.loginid}@#{request.remote_ip}: Deleted group #{params[:id]}."
    else
      logger.info "#{current_user.loginid}@#{request.remote_ip}: Attempted to delete group #{params[:id]} but does not have permission."
    end

    respond_to do |format|
      format.html { redirect_to(groups_url) }
      format.json { head :ok }
    end
  end
  
  protected
  
  def load_group
    if _permitted_to? :show, :groups
      @group = Group.find_by_id(params[:id])
    end
  end
end
