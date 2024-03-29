class ApplicationsController < ApplicationController
  before_action :load_application, only: [:show, :activity]
  before_action :new_application_from_params, only: :create
  before_action :load_applications, only: :index

  def index
    authorize Application

    respond_to do |format|
      format.html
      format.json { render json: @applications }
    end
  end

  def show
    authorize @application

    @cache_key = 'application/' + @application.id.to_s + '/' + @application.updated_at.try(:utc).try(:to_s, :number)

    respond_to do |format|
      format.json { render 'applications/show', status: :ok }
      format.csv do
        require 'csv'

        logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Downloaded CSV of application, #{params[:application]}."

        # Credit CSV code: http://www.funonrails.com/2012/01/csv-file-importexport-in-rails-3.html
        csv_data = Rails.cache.fetch("#{@cache_key}") do
          CSV.generate do |csv|
            # Add the header
            csv << Application.csv_header
            # Add members of each role
            @application.roles.each do |r|
              r.to_csv.each do |row|
                csv << row
              end
            end
            # Add the owners
            @application.owners.each do |owner|
              csv << ['owner', owner.to_csv].flatten
            end
          end
        end
        send_data csv_data,
                  type: 'text/csv; charset=iso-8859-1; header=present',
                  disposition: 'attachment; filename=' + unix_filename(@application.name.to_s) + '.csv'
      end
    end
  end

  def new
    authorize Application

    @application = Application.new

    respond_to do |format|
      format.json { render json: @application }
    end
  end

  def create
    authorize @application

    if @application.save
      logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Created new application, #{params[:application]}."
    else
      logger.warn "#{current_user.log_identifier}@#{request.remote_ip}: Failed to create new application, #{params[:application]}."
    end

    respond_to do |format|
      format.json { render json: @application }
    end
  end

  def update
    @application = Application.find(params[:id])

    authorize @application

    respond_to do |format|
      ap = application_params
      update_roles_attributes(@application, ap)
      update_owners_attributes(@application, ap)
      if @application.update(ap)
        logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Updated application with params #{params[:application]}."

        @cache_key = 'application/' + @application.id.to_s + '/' + @application.updated_at.try(:utc).try(:to_s, :number)

        format.json { render 'applications/show', status: :ok }
      else
        logger.error "Applications#update failed. Reason(s): #{@application.errors.full_messages.join(', ')}"
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @application = Application.find(params[:id])

    authorize @application

    @application.roles.each do |role|
      RolesService.destroy_role(role)
    end
    @application.destroy

    logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Deleted application, #{params[:application]}."

    respond_to do |format|
      format.json { render json: @application }
    end
  end

  def activity
    authorize @application

    @activity = @application.activity
    if @activity
      if @activity.empty? == false
        @cache_key = "application/#{@application.id}/activity/#{@activity[0].performed_at.try(:utc).try(:to_s, :number)}"
      else
        @cache_key = nil
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

  def load_application
    @application = Application.find_by_id!(params[:id])
  end

  def load_applications
    manageable_applications = current_user.manageable_applications

    if params[:q]
      apps = Application.arel_table
      @applications = manageable_applications.where(apps[:name].matches("%#{params[:q]}%"))
    else
      @applications = manageable_applications
    end
  end

  def new_application_from_params
    params[:application][:owner_ids] = [] unless params[:application][:owner_ids]
    params[:application][:owner_ids] << current_user.id unless params[:application][:owner_ids].include? current_user.id
    @application = Application.new(application_params)
  end

  def application_params
    if params[:application]
      # Workaround for deep_munge issues (http://stackoverflow.com/questions/20164354/rails-strong-parameters-with-empty-arrays)
      params[:application][:owner_ids] ||= [] if params[:application].key?(:owner_ids)
    end
    params.require(:application).permit(:name, :description, :url,
                                      { roles_attributes: [:id, :token, :name, :description, :ad_path, :_destroy]}, {owner_ids: []},
                                      { operatorships_attributes: [:id, :entity_id, :application_id, :_destroy]} )
  end

  def update_roles_attributes(application, params)
    # Special handler for roles until we can un-permit "roles_attributes"
    # (frontend needs work to allow this)
    if params['roles_attributes']
      roles_changed = false
      params['roles_attributes'].each do |role_attribute|
        if role_attribute['id'] && role_attribute['_destroy']
          # Destroy an existing role
          role = Role.find_by(id: role_attribute['id'])
          RolesService.destroy_role(role)
          roles_changed = true
        elsif role_attribute['id']
          # Updating an existing role
          roles_changed = RolesService.update_role(Role.find_by(id: role_attribute['id']), role_attribute['name'], role_attribute['token'], role_attribute['description'], role_attribute['ad_path'])
          roles_changed = true
        else
          # Creating a new role
          RolesService.create_role(application.id, role_attribute['name'], role_attribute['token'], role_attribute['description'], role_attribute['ad_path'])
          roles_changed = true
        end
      end

      params.delete(:roles_attributes)

      if roles_changed
        application.reload
        application.touch
      end
    end
  end

  def update_owners_attributes(application, params)
    return unless params['owner_ids']

    # Special handler for roles until we can un-permit "owner_ids"
    # (frontend needs work to allow this)
    existing_owner_ids = application.owners.map(&:id)

    owner_ids_to_add = params['owner_ids'] - existing_owner_ids
    owner_ids_to_remove = existing_owner_ids - params['owner_ids']

    owner_ids_to_add.each do |owner_id|
      ApplicationsService.grant_application_ownership(application, Entity.find_by(id: owner_id))
    end
    owner_ids_to_remove.each do |owner_id|
      ao = ApplicationOwnership.find_by(application_id: application.id, entity_id: owner_id, parent_id: nil)
      ApplicationsService.revoke_application_ownership(ao)
    end

    params.delete(:owner_ids)

    if (owner_ids_to_add.length > 0) || (owner_ids_to_remove.length > 0)
      application.reload
      application.touch
    end
  end
end
