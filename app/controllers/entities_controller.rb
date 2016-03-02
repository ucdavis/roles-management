class EntitiesController < ApplicationController
  before_filter :new_entity_from_params, :only => :create
  before_filter :load_entities, :only => :index
  before_filter :load_entity, :only => [:show, :update]

  def index
    authorize Entity
    
    respond_to do |format|
      format.json { render json: @entities }
    end
  end

  def show
    authorize @entity

    @cache_key = "entity/" + @entity.id.to_s + '/' + @entity.updated_at.try(:utc).try(:to_s, :number)

    logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded entity show view for #{params[:id]}."

    respond_to do |format|
      format.json { render "entities/show", status: :ok }
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
    authorize @entity
    
    @entity.save

    if params[:entity][:type] == "Group"
      @entity.owners << current_user
    end

    if @entity.group?
      @group = @entity
      render "groups/create"
    else
      respond_to do |format|
        format.json { render json: @entity }
      end
    end
  end

  def update
    authorize @entity
    
    respond_to do |format|
      if @entity.update_attributes(entity_params)
        # The update may have only touched associations and not @entity directly,
        # so we'll touch the timestamp ourselves to match sure our caches are
        # invlidated correctly.
        @entity.touch

        logger.debug "Entity#update successful."

        @cache_key = "entity/" + @entity.id.to_s + '/' + @entity.updated_at.try(:utc).try(:to_s, :number)
        
        format.json { render "entities/show", status: :ok }
      else
        logger.error "Entity#update failed. Reason(s): #{@entity.errors.full_messages.join(", ")}"
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @entity = Entity.find(params[:id])
    
    authorize @entity

    if @entity.type == "Group"
      logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Deleted entity, #{@entity}."

      @entity.destroy
    end

    respond_to do |format|
      format.json { render json: nil }
    end
  end
  
  def activity
    @entity = Entity.find(params[:id])
    
    authorize @entity
    
    @activity = @entity.activity(8)
    tag = ActivityLogTag.find_by_tag("#{@entity.class.to_s.downcase}_#{@entity.id}")
    if tag
      logs = tag.activity_logs.order(performed_at: :desc)
      if logs.length > 0
        @cache_key = "entity/" + @entity.id.to_s + '/activity/' + logs[0].performed_at.try(:utc).try(:to_s, :number)
      else
        @cache_key = nil
      end
    else
      @cache_key = nil
    end

    respond_to do |format|
      format.json { render "entities/activity" }
    end
  end

  protected

    def new_entity_from_params
      # Explicitly check for "Group" and "Person", avoid using 'constantize' (for security)
      if params[:entity][:type] == "Group"
        @entity = Group.new(entity_params)
      elsif params[:entity][:type] == "Person"
        @entity = Person.new(entity_params)
      else
        @entity = nil
      end
    end

  private
  
    def load_entity
      @entity = Entity.find(params[:id])
    end

    def load_entities
      if params[:q]
        entities_table = Entity.arel_table

        # Search login IDs in case of an entity-search but looking for person by login ID
        @entities = Entity.where(entities_table[:name].matches("%#{params[:q]}%").or(entities_table[:loginid].matches("%#{params[:q]}%")).or(entities_table[:first].matches("%#{params[:q]}%")).or(entities_table[:last].matches("%#{params[:q]}%")))

        logger.debug "Entities#index searching for '#{params[:q]}'. Found #{@entities.length} results."
      else
        @entities = Entity.all
      end
    end

    def entity_params
      if params[:entity]
        # Workaround for deep_munge issues (http://stackoverflow.com/questions/20164354/rails-strong-parameters-with-empty-arrays)
        params[:entity][:favorite_ids] ||= [] if params[:entity].has_key?(:favorite_ids)
        params[:entity][:owner_ids] ||= [] if params[:entity].has_key?(:owner_ids)
        params[:entity][:operator_ids] ||= [] if params[:entity].has_key?(:operator_ids)
      end
      params.require(:entity).permit(:name, :type, :description, :first, :last, :address, :email, :loginid,
                                    :phone, :active, {owner_ids: []}, {favorite_ids: []}, {operator_ids: []},
                                    {rules_attributes: [:id, :column, :condition, :value, :_destroy]},
                                    {memberships_attributes: [:id, :calculated, :entity_id, :_destroy]},
                                    {group_memberships_attributes: [:id, :calculated, :group_id, :_destroy]},
                                    {group_ownerships_attributes: [:id, :entity_id, :group_id, :_destroy]},
                                    {role_assignments_attributes: [:id, :role_id, :entity_id, :_destroy]},
                                    {group_operatorships_attributes: [:id, :group_id, :entity_id, :_destroy]})
    end
end
