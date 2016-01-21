class EntitiesController < ApplicationController
  before_filter :new_entity_from_params, :only => :create
  filter_access_to :all, :attribute_check => true
  filter_access_to :index, :attribute_check => true, :load_method => :load_entities

  def index
    respond_to do |format|
      format.json { render json: @entities }
    end
  end

  def show
    @entity = Entity.find(params[:id])

    @cache_key = "entity/" + @entity.id.to_s + '/' + @entity.updated_at.try(:utc).try(:to_s, :number)

    logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded entity show view for #{params[:id]}."

    respond_to do |format|
      format.json  { render json: @entity }
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
    # declarative_authorization requires we not use polymorphism *headache*
    if params[:entity][:type] == "Group"
      # with_permission_to appears to be buggy. It changes the number of
      # group owners loaded even when permissions appear correct.
      #@entity = Group.with_permissions_to(:update).find(params[:id])
      @entity = Group.find(params[:id])
    elsif params[:entity][:type] == "Person"
      # with_permission_to appears to be buggy. See similar comment above.
      #@entity = Person.with_permissions_to(:update).find(params[:id])
      @entity = Person.find(params[:id])
    end

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
    entity = Entity.find(params[:id])

    if entity.type == "Group"
      logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Deleted entity, #{entity}."

      entity.destroy

      render :nothing => true
    end

    respond_to do |format|
      format.json { render json: nil }
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

    def entity_params
      params.require(:entity).permit(:name, :type, :description, :owner_ids, :first, :last, :address, :email, :loginid,
                                    :phone, :active, :owner_ids, :favorite_ids, :operator_ids, {rules_attributes: [ :id, :column, :condition, :value ]},
                                    {memberships_attributes: [:id, :calculated, :entity_id, :_destroy]},
                                    {group_memberships_attributes: []}, {group_ownerships_attributes: []}, {role_assignments_attributes: [ :id, :role_id, :entity_id ]})
    end
end
