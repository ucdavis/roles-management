class GroupsController < ApplicationController
  before_filter :new_group_from_params, :only => :create
  before_filter :load_groups, :only => :index

  # Used by the API and various Group-only token inputs
  # Takes optional 'q' parameter to filter index
  def index
    authorize Group
    
    if @groups.count > 0
      @cache_key = 'groups/' + current_user.loginid + '/' + (params[:q] ? params[:q] : '') + '/' + @groups.max_by(&:updated_at).updated_at.try(:utc).try(:to_s, :number).to_s
    end

    respond_to do |format|
      format.json { render "groups/index" }
    end
  end

  def show
    authorize @group
    
    @cache_key = "group/" + @group.id.to_s + '/' + @group.updated_at.try(:utc).try(:to_s, :number)

    respond_to do |format|
      format.json { render "groups/show" }
    end
  end

  def destroy
    authorize @group
    
    @group.destroy

    respond_to do |format|
      format.json { render json: @group }
    end
  end

  protected

    def new_group_from_params
        @group = Group.new(params[:group])
    end

  private

    def load_groups
      if params[:q]
        groups_table = Group.arel_table
        @groups = Group.where(groups_table[:name].matches("%#{params[:q]}%"))
      else
        @groups = Group.all
      end
    end
  
    def group_params
      params.require(:group).permit(:name)
    end
end
