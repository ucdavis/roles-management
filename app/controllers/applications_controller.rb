class ApplicationsController < ApplicationController
  before_filter :load_application, :only => :show
  before_filter :new_application_from_params, :only => :create
  filter_access_to :all, :attribute_check => true
  filter_access_to :index, :attribute_check => true, :load_method => :load_applications
  respond_to :json

  def index
    logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded application index (main page)."

    respond_with @applications do |format|
      format.html
    end
  end

  def show
    logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded application show view for #{params[:id]}."

    respond_with @application do |format|
      format.csv {
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
            csv << ["owner", owner.to_csv].flatten
          end
        end
        send_data csv_data,
          :type => 'text/csv; charset=iso-8859-1; header=present',
          :disposition => "attachment; filename=" + unix_filename("#{@application.name}")
      }
    end
  end

  def new
    @application = Application.new

    respond_with @application
  end

  def create
    if @application.save
      logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Created new application, #{params[:application]}."
    else
      logger.warn "#{current_user.log_identifier}@#{request.remote_ip}: Failed to create new application, #{params[:application]}."
    end

    @application.trigger_sync

    respond_with @application
  end

  def update
    @application = Application.find(params[:id])

    if @application.update_attributes(params[:application])
      logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Updated application with params #{params[:application]}."
    end

    @application.trigger_sync

    respond_with @application do |format|
      format.json { render :json => @application } # A new role may have been created, so we need to render out to reveal the new ID
    end
  end

  def destroy
    @application = Application.find(params[:id])
    @application.destroy

    logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Deleted application, #{params[:application]}."

    respond_with @application
  end

  protected

  def load_application
    @application = Application.with_permissions_to(:read).find(params[:id])
  end

  def load_applications
    manageable_applications = current_user.manageable_applications

    if params[:q]
      apps = Application.arel_table
      @applications = manageable_applications.where(apps[:name].matches("%#{params[:q]}%"))
    else
      @applications = manageable_applications
    end

    @applications = @applications.sort_by(&:created_at)
  end

  def new_application_from_params
    params[:application][:owner_ids] = [] unless params[:application][:owner_ids]
    params[:application][:owner_ids] << current_user.id unless params[:application][:owner_ids].include? current_user.id
    @application = Application.new(params[:application])
  end
end
