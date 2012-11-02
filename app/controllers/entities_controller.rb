class EntitiesController < ApplicationController
  before_filter :load_entity, :only => [:show, :update]
  filter_access_to :all
  respond_to :json

  #wrap_parameters :entity #, :include => [:members]

  def index
    @entities = current_user.manageable_uids
  end

  def show
  end

  def update
    @entity.update_attributes(params[:entity])
    respond_with(@entity)
  end

  protected

  def load_entity
    uid_info = determine_uid(params[:id])

    # Adjust params so update_attributes doesn't think we're changing the ID
    unless params[:entity].nil?
      params[:entity].delete :id
      params[:entity].delete :created_at
    end

    if(uid_info[:type] == UID_PERSON)
      if _permitted_to? :show, :people
        @entity = Person.find_by_id(uid_info[:id])
      end
    elsif(uid_info[:type] == UID_GROUP)
      if _permitted_to? :show, :groups
        @entity = Group.find_by_id(uid_info[:id])
      end
    end

    @entity
  end
end
