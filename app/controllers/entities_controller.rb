class EntitiesController < ApplicationController
  before_action :new_entity_from_params, only: :create
  before_action :load_entities, only: :index
  before_action :load_entity, only: [:show, :update]

  def index
    authorize Entity

    @cache_key = "entities/index/#{@entities.maximum(:updated_at).try(:utc).try(:to_s, :number)}/#{params[:q]}"

    respond_to do |format|
      format.json { render 'entities/index', status: :ok }
    end
  end

  def show # rubocop:disable Metrics/AbcSize
    authorize @entity

    @cache_key = 'entity/' + @entity.id.to_s + '/' + @entity.updated_at.try(:utc).try(:to_s, :number)

    respond_to do |format|
      format.json { render 'entities/show', status: :ok }
      format.csv do
        require 'csv'

        # Credit CSV code: http://www.funonrails.com/2012/01/csv-file-importexport-in-rails-3.html
        csv_data = CSV.generate do |csv|
          csv << Person.csv_header
          @entity.members.each do |m|
            csv << m.to_csv if m.active
          end
        end
        send_data csv_data,
                  type: 'text/csv; charset=iso-8859-1; header=present',
                  disposition: 'attachment; filename=' + unix_filename(@entity.name.to_s) + '.csv'
      end
    end
  end

  def create
    authorize @entity

    @entity.save

    @entity.owners << current_user if params[:entity][:type] == 'Group'

    if @entity.group?
      @group = @entity
      render 'groups/create'
    else
      respond_to do |format|
        format.json { render json: @entity }
      end
    end
  end

  def update
    authorize @entity

    # TODO: Will affected_role_ids be needed after service layer work?
    affected_role_ids = @entity.roles.map(&:id) if @entity.group?

    respond_to do |format|
      ep = entity_params
      update_rules_attributes(@entity, ep)
      update_memberships_attributes(@entity, ep)
      update_group_memberships_attributes(@entity, ep)
      if @entity.update_attributes(ep)
        # The update may have only touched associations and not @entity directly,
        # so we'll touch the timestamp ourselves to make sure our caches are
        # invlidated correctly.
        @entity.touch

        if @entity.group?
          affected_role_ids = (affected_role_ids + @entity.roles.map(&:id)).flatten.uniq
          Role.where(id: affected_role_ids).each do |role|
            Rails.logger.debug "Entities(Group)#update will cause role_audit for role #{role.id} / #{role.token}"
            Sync.role_audit(Sync.encode(role))
          end
        end

        @cache_key = 'entity/' + @entity.id.to_s + '/' + @entity.updated_at.try(:utc).try(:to_s, :number)

        format.json { render 'entities/show', status: :ok }
      else
        logger.error "Entity#update failed. Reason(s): #{@entity.errors.full_messages.join(', ')}"
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @entity = Entity.find(params[:id])

    authorize @entity

    if @entity.group?
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

    @activity = @entity.activity
    if @activity
      if @activity.empty?
        @cache_key = nil
      else
        @cache_key = 'entity/' + @entity.id.to_s + '/activity/' + @activity[0].performed_at.try(:utc).try(:to_s, :number)
      end
    else
      @activity = nil
      @cache_key = nil
    end

    respond_to do |format|
      format.json { render 'shared/activity' }
    end
  end

  protected

  def update_rules_attributes(entity, params)
    # Special handler for group rules until we can un-permit "rules_attributes"
    # (frontend needs work to allow this)
    if params['rules_attributes']
      GroupRulesService.save_group_rules_and_sync_member_roles(entity, params['rules_attributes'])
      params.delete(:rules_attributes)
    end
  end

  # Group entities POST a 'memberships_attributes', not to be confused with
  # Person entities which POST a 'group_memberships_attributes'.
  def update_memberships_attributes(entity, params)
    return unless entity.group?

    # Special handler until we can un-permit "memberships_attributes"
    # (frontend needs work to allow this)
    memberships_changed = false
    if params['memberships_attributes']
      params['memberships_attributes'].each do |membership_attribute|
        if membership_attribute['entity_id'] && membership_attribute['_destroy']
          # Removing a group member
          GroupMembershipsService.remove_member_from_group(Entity.find_by(id: membership_attribute['entity_id']), entity)
          memberships_changed = true
        elsif membership_attribute['id'] && membership_attribute['entity_id']
          # Existing group member
          next 
        elsif membership_attribute['entity_id']
          # Adding a group member
          GroupMembershipsService.assign_member_to_group(Entity.find_by(id: membership_attribute['entity_id']), entity)
          memberships_changed = true
        end
      end
    end

    params.delete(:memberships_attributes)

    if memberships_changed
      entity.reload
      entity.touch
    end
  end

  # Person entities POST a 'group_memberships_attributes', not to be confused with
  # Group entities which POST a 'memberships_attributes'.
  def update_group_memberships_attributes(entity, params)
    return unless entity.person?

    # Special handler until we can un-permit "group_memberships_attributes"
    # (frontend needs work to allow this)
    group_memberships_changed = false
    if params['group_memberships_attributes']
      params['group_memberships_attributes'].each do |group_membership_attributes|
        next if group_membership_attributes['calculated']

        if group_membership_attributes['group_id'] && group_membership_attributes['_destroy']
          # Removing a group member
          GroupMembershipsService.remove_member_from_group(entity, Group.find_by(id: group_membership_attributes['group_id']))
          group_memberships_changed = true
        elsif group_membership_attributes['group_id'] && (group_membership_attributes['id'] == nil)
          # Adding a group member
          GroupMembershipsService.assign_member_to_group(entity, Group.find_by(id: group_membership_attributes['group_id']))
          group_memberships_changed = true
        end
      end
    end

    params.delete(:group_memberships_attributes)

    if group_memberships_changed
      entity.reload
      entity.touch
    end
  end

  def new_entity_from_params
    # Explicitly check for "Group" and "Person", avoid using 'constantize' (for security)
    if params[:entity][:type] == 'Group'
      @entity = Group.new(entity_params)
    elsif params[:entity][:type] == 'Person'
      @entity = Person.new(entity_params)
    else
      @entity = nil
    end
  end

  private

  def load_entity
    @entity = Entity.find_by_id!(params[:id])
  end

  def load_entities
    if params[:q]
      entities_table = Entity.arel_table
      @entities = []

      q_parts = params[:q].split(' ')

      if q_parts.length == 2
        # Special case where we probably have first name and last name
        @entities = Entity.where(entities_table[:first].matches("%#{q_parts[0]}%")
                          .and(entities_table[:last].matches("%#{q_parts[1]}%")))
      end

      if @entities.empty?
        # Search login IDs in case of an entity-search but looking for person by login ID
        @entities = Entity.where(entities_table[:name].matches("%#{params[:q]}%")
                                                      .or(entities_table[:loginid].matches("%#{params[:q]}%"))
                                                      .or(entities_table[:first].matches("%#{params[:q]}%"))
                                                      .or(entities_table[:last].matches("%#{params[:q]}%")))
      end
    else
      @entities = Entity.all
    end
  end

  def entity_params
    if params[:entity]
      # Workaround for deep_munge issues (http://stackoverflow.com/questions/20164354/rails-strong-parameters-with-empty-arrays)
      params[:entity][:favorite_ids] ||= [] if params[:entity].key?(:favorite_ids)
      params[:entity][:owner_ids] ||= [] if params[:entity].key?(:owner_ids)
      params[:entity][:operator_ids] ||= [] if params[:entity].key?(:operator_ids)
    end
    params.require(:entity).permit(:name, :type, :description, :first, :last, :address, :email, :loginid,
                                   :phone, :active, { owner_ids: [] }, { favorite_ids: [] }, { operator_ids: [] },
                                   { rules_attributes: [:id, :column, :condition, :value, :_destroy] },
                                   { memberships_attributes: [:id, :calculated, :entity_id, :_destroy] },
                                   { group_memberships_attributes: [:id, :calculated, :group_id, :_destroy] },
                                   { group_ownerships_attributes: [:id, :entity_id, :group_id, :_destroy] },
                                   { group_operatorships_attributes: [:id, :group_id, :entity_id, :_destroy] })
  end
end
