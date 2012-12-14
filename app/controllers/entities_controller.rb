class EntitiesController < ApplicationController
  filter_access_to :all
  respond_to :json

  #def index
    #@entities = Person.all #current_user.manageable_ids

    #respond_with @entities
  #end

  def show
    # SECUREME
    @entity = Entity.find(params[:id])
  end

  def create
    # SECUREME
    # Only allow "Group" and "Person" to be constantized for security
    if (params[:entity][:type] == "Group") || (params[:entity][:type] == "Person")
      @entity = params[:entity][:type].constantize.new(params[:entity])

      @entity.save

      if params[:entity][:type] == "Group"
        @entity.owners << current_user
      end

      render "entities/show"
    end
  end

  def update
    # SECUREME
    @entity = Entity.find(params[:id])

    @entity.update_attributes(params[:entity])
    render "show"
  end

  def destroy
    # SECUREME
    entity = Entity.find(params[:id])

    if entity.type == "Group"
      if entity.owners.include? current_user
        logger.info "#{current_user.loginid}@#{request.remote_ip}: Deleted entity, #{entity}."

        # Must own the group to delete it
        entity.destroy

        render :nothing => true
      end
    end
  end
end
