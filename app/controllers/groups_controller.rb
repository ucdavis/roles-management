class GroupsController < ApplicationController
  filter_access_to :all, :attribute_check => true
  respond_to :json

  # Used by the API and various Group-only token inputs
  # Takes optional 'q' parameter to filter index
  def index
    if params[:q]
      @groups = Group.where("upper(name) like ? and code is null", "%#{params[:q].upcase}%")
    else
      @groups = Group.all
    end

    respond_with @groups
  end
  
  def create
    @group = Group.new(params[:group])

    @group.save
    respond_with @group
  end
  
  def update
    if params[:id] and params[:group]
      @group = Group.find(params[:id])
      @group.update_attributes(params[:group].except(:id))

      respond_with @group
    else
      respond_with 422
    end
  end
  
  def show
    @group = Group.find(params[:id])
    
    respond_with @group
  end
end
