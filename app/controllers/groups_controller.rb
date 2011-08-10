class GroupsController < ApplicationController
  filter_resource_access

  # GET /groups
  def index
    @groups = Group.where("name like ?", "%#{params[:q]}%")

    respond_to do |format|
      format.html
      format.json { render :json => @groups.map(&:attributes) }
    end
  end

  # GET /groups/1
  def show
    @group = Group.find_by_name(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      #format.xml  { render :xml => @group.to_xml( :include => { :people => { :only => [:first, :last, :loginid, :title_id, :status, :preferred_name, :email] } }) }
    end
  end

  # GET /groups/new
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
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
      if @group.save
        format.html { redirect_to(@group, :notice => 'Group was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /groups/1
  def update
    @group = Group.find_by_name(params[:id])

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
    @group.destroy

    respond_to do |format|
      format.html { redirect_to(groups_url) }
    end
  end
end
