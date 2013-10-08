module Api
  module V1
    class ApplicationsController < ApplicationController
      before_filter :load_application, :only => :show
      filter_access_to :all, :attribute_check => true
      filter_access_to :index, :attribute_check => true, :load_method => :load_applications

      # GET /applications
      def index
        logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded or searched applications index." }
        
        render "api/v1/applications/index"
      end

      # GET /applications/1
      def show
        if @application
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded application view (show) for #{@application.id}." }
          render "api/v1/applications/show"
        else
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Attempted to load application view (show) for invalid ID #{params[:id]}." }
          render :text => "Invalid application ID '#{params[:id]}'.", :status => 404
        end
      end

      private

      def load_application
        @application = Application.with_permissions_to(:read).find_by_id(params[:id])
      end

      def load_applications
        if params[:q]
          apps = Application.arel_table
          @applications = Application.with_permissions_to(:read).includes(:roles).where(apps[:name].matches("%#{params[:q]}%"))
        else
          @applications = Application.with_permissions_to(:read).includes(:roles)
        end
      end
    end
  end
end
