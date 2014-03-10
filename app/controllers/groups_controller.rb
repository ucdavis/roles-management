class GroupsController < ApplicationController
  before_filter :new_group_from_params, :only => :create
  filter_access_to :all, :attribute_check => true
  filter_access_to :index, :attribute_check => true, :load_method => :load_groups
  respond_to :json

  # Used by the API and various Group-only token inputs
  # Takes optional 'q' parameter to filter index
  def index
    @cache_key = current_user.loginid + '/' + @groups.max_by(&:updated_at).to_s
    
    render "groups/index"
    #respond_with @groups
  end
  
  # def create
  #   @group.save
  #   render "groups/create"
  #   #respond_with @group
  # end
  
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
    @cache_key = @group.id + '/' + @group.updated_at.try(:utc).try(:to_s, :number)
    
    render "groups/show"
    #respond_with @group
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
      groups_table = Group.arel_table
      @groups = Group.with_permissions_to(:read).where(groups_table[:name].matches("%#{params[:q]}%"))
    else
      @groups = Group.with_permissions_to(:read).all
    end
  end
end
