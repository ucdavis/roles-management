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
    entity = Entity.new( params[:entity] )
    entity.save

    if params[:entity][:type] == "Group"
      Group.find(entity.id).owners << current_user # cannot add to 'entity' directly b/c of Rails' limited STI
    end

    respond_with entity
  end

  def update
    @entity = Entity.find(params[:id])

    @entity.update_attributes(params[:entity])
    render "show"
  end
end
