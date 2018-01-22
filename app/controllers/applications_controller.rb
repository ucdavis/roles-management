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
        csv_data = CSV.generate do |csv|
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
        send_data csv_data,
                  type: 'text/csv; charset=iso-8859-1; header=present',
                  disposition: 'attachment; filename=' + unix_filename(@application.name.to_s)
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
      if @application.update_attributes(application_params)
        logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Updated application with params #{params[:application]}."

        # format.json { render json: @application }
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
end
