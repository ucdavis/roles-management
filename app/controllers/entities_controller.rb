class EntitiesController < ApplicationController
  filter_access_to :all
  respond_to :json

  def index
    @entities = current_user.manageable_uids
  end

  def show
    @entity = Entity.find(params[:id])
  end

  def update
    entity = Entity.find(params[:id])
    entity.update_attributes(params[:entity])
    respond_with(entity)
  end
end
