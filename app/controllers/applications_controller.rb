class ApplicationsController < ApplicationController
  before_filter :load_application, :only => [:show]
  filter_access_to :all

  # GET /applications
  def index
    @applications = Application.all

    respond_to do |format|
      format.html
    end
  end

  # GET /applications/1
  def show
    respond_to do |format|
      format.html { render "show", :layout => false }
      format.csv {
        require 'csv'

        # Credit CSV code: http://www.funonrails.com/2012/01/csv-file-importexport-in-rails-3.html
        csv_data = CSV.generate do |csv|
          csv << Application.csv_header
          csv << @application.to_csv
        end
        send_data csv_data,
          :type => 'text/csv; charset=iso-8859-1; header=present',
          :disposition => "attachment; filename=rm_application_#{@application.to_param}.csv"
      }
    end
  end

  # GET /applications/new
  def new
    @application = Application.new

    respond_to do |format|
      format.html
    end
  end

  # GET /applications/1/edit
  def edit
    @application = Application.find(params[:id])
  end

  # POST /applications
  def create
    @application = Application.new(params[:application])

    respond_to do |format|
      if @application.save
        logger.info "#{current_user.loginid}@#{request.remote_ip}: Created new application, #{params[:application]}."
        format.html { redirect_to(@application, :notice => 'Application was successfully created.') }
        format.json { render json: @application, status: :created, location: @application }
      else
        format.html { render :action => "new" }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /applications/1
  def update
    @application = Application.find(params[:id])

    respond_to do |format|
      if @application.update_attributes(params[:application])
        logger.info "#{current_user.loginid}@#{request.remote_ip}: Updated application, #{params[:application]}."
        format.html { redirect_to(@application, :notice => 'Application was successfully updated.') }
        format.js { render json: @application, status: :ok }
      else
        format.html { render :action => "edit" }
        format.js { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applications/1
  def destroy
    @application = Application.find(params[:id])
    @application.destroy

    logger.info "#{current_user.loginid}@#{request.remote_ip}: Deleted application, #{params[:application]}."

    respond_to do |format|
      format.html { redirect_to(applications_url) }
    end
  end

  protected

  def load_application
    if permitted_to?(:show, :applications)
      @application = Application.find(params[:id])
    else
      @application = nil
      logger.info "#{current_user.loginid}@#{request.remote_ip}: Tried loading an application without permission."
    end
  end
end
