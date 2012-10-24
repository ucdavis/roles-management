class EntitiesController < ApplicationController
  before_filter :load_entity, :only => [:show]
  filter_access_to :all
  respond_to :json

  wrap_parameters :entity #, :include => [:assignments_attributes, :title, :complete]

  def index
    @entities = current_user.manageable_uids
  end

  def show

  end

  def update
    #task = current_user.tasks.find(params[:id])
    #task.update_attributes(params[:task])
    #respond_with(task)
  end

  protected

  def load_entity
    uid_info = determine_uid(params[:id])

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
