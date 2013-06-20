class GroupsController < ApplicationController
  before_filter :new_group_from_params, :only => :create
  filter_access_to :all, :attribute_check => true
  filter_access_to :index, :attribute_check => true, :load_method => :load_groups
  respond_to :json

  # Used by the API and various Group-only token inputs
  # Takes optional 'q' parameter to filter index
  def index
    respond_with @groups
  end
  
  def create
    @group.save
    respond_with @group
  end
  
  def update
    if params[:id] and params[:group]
      @group = Group.find(params[:id])
      
      # ActiveResource (for API access) sends us members, operators, etc.
      # API access will have to rely on other methods for assocating objects with a group, e.g.
      # setting GroupRule.group_id instead of trying Group.rules << GroupRule.
      @group.update_attributes(params[:group].except(:id, :members, :operators, :owners, :rules))
      
      respond_with @group
    else
      respond_with 422
    end
  end
  
  def show
    respond_with @group
  end
  
  def destroy
    @group.destroy
    
    respond_with @group
  end
  
  protected
  
  def new_group_from_params
    @group = Group.new(params[:group])
  end
  
  private
  
  def load_groups
    if params[:q]
      @groups = Group.where("upper(name) like ? and code is null", "%#{params[:q].upcase}%")
    else
      @groups = Group.all
    end
  end
end
