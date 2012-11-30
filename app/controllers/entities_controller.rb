class EntitiesController < ApplicationController
  filter_access_to :all
  respond_to :json

  def index
    @entities = current_user.manageable_ids
  end

  def show
    @entity = Entity.find(params[:id])
  end

  def create
    # Only allow "Group" and "Person" to be constantized for security
    if (params[:entity][:type] == "Group") || (params[:entity][:type] == "Person")
      entity = params[:entity][:type].constantize.new(params[:entity])

      entity.save

      if params[:entity][:type] == "Group"
        entity.owners << current_user
      end

      respond_with entity
    end
  end

  def update
    @entity = Entity.find(params[:id])

    @entity.update_attributes(params[:entity])
    render "show"
  end
end
