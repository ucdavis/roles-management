class EntitiesController < ApplicationController
  before_filter :new_entity_from_params, :only => :create
  filter_access_to :all, :attribute_check => true
  filter_access_to :index, :attribute_check => true, :load_method => :load_entities
  respond_to :json

  def index
    respond_with @entities
  end

  def show
    @entity = Entity.find(params[:id])

    @cache_key = @entity.id.to_s + '/' + @entity.updated_at.try(:utc).try(:to_s, :number)

    logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded entity show view for #{params[:id]}."

    respond_with @entity do |format|
      format.json
      format.csv {
        require 'csv'

        # Credit CSV code: http://www.funonrails.com/2012/01/csv-file-importexport-in-rails-3.html
        csv_data = CSV.generate do |csv|
          csv << Person.csv_header
          @entity.flattened_members.each do |m|
            csv << m.to_csv if m.active
          end
        end
        send_data csv_data,
          :type => 'text/csv; charset=iso-8859-1; header=present',
          :disposition => "attachment; filename=" + unix_filename("#{@entity.name}")
      }
    end
  end

  def create
    @entity.save

    if params[:entity][:type] == "Group"
      without_authorization do
        # It's impossible for the authorization rules to allow this action
        # as we cannot verify they own the group before we assign them
        # as owner of the group.
        # This is safe however as the exception only applies to new groups
        # created by the user with the system deciding they are the owner.
        @entity.owners << current_user
      end
    end

    @entity.trigger_sync

    if @entity.group?
      @group = @entity
      render "groups/create"
    else
      respond_with @entity
    end
  end

  def update
    # declarative_authorization requires we not use polymorphism *headache*
    if params[:entity][:type] == "Group"
      @entity = Group.with_permissions_to(:update).find(params[:id])
    elsif params[:entity][:type] == "Person"
      @entity = Person.with_permissions_to(:update).find(params[:id])
    end

    respond_to do |format|
      if @entity.update_attributes(params[:entity])
        @entity.touch # updating a relation will not alter the 'updated_at' timestamp
                      # but that timestamp is used when caching a JSON view of this entity
                      # which _will_ include those relations, so 'touch' the timestamp
                      # here to ensure JSON cache is invalidated.
                      # Another option is to calculate cache_keys using the updated_at of
                      # all relations but this could potentially take a long time on very
                      # large groups

        logger.debug "Entity#update successful. Triggering sync ..."
        @entity.trigger_sync

        @cache_key = @entity.id.to_s + '/' + @entity.updated_at.try(:utc).try(:to_s, :number)

        format.json { render "entities/show", status: :ok }
      else
        logger.error "Entity#update failed. Reason(s): #{@entity.errors.full_messages.join(", ")}"
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    entity = Entity.find(params[:id])

    if entity.type == "Group"
      logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Deleted entity, #{entity}."

      entity.destroy

      render :nothing => true
    end
  end

  protected

  def new_entity_from_params
    # Explicitly check for "Group" and "Person", avoid using 'constantize' (for security)
    if params[:entity][:type] == "Group"
      @entity = Group.new(params[:entity])
    elsif params[:entity][:type] == "Person"
      @entity = Person.new(params[:entity])
    else
      @entity = nil
    end
  end

  private

  def load_entities
    if params[:q]
      entities_table = Entity.arel_table

      # Search login IDs in case of an entity-search but looking for person by login ID
      @entities = Entity.with_permissions_to(:read).where(entities_table[:name].matches("%#{params[:q]}%").or(entities_table[:loginid].matches("%#{params[:q]}%")).or(entities_table[:first].matches("%#{params[:q]}%")).or(entities_table[:last].matches("%#{params[:q]}%")))

      logger.debug "Entities#index searching for '#{params[:q]}'. Found #{@entities.length} results."
    else
      @entities = Entity.with_permissions_to(:read).all
    end
  end
end
