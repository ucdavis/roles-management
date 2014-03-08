module Api
  module V1
    class ApplicationsController < ApplicationController
      before_filter :load_application, :only => :show
      filter_access_to :all, :attribute_check => true
      filter_access_to :index, :attribute_check => true, :load_method => :load_applications

      # GET /applications
      def index
        logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded or searched applications index." }
        
        # API users currently share access to all resources. If this changes, we will need to alter our
        # cache_key to avoid leaking data across accounts via stale caches.
        @cache_key = (params[:q] ? params[:q] : '') + '/' + @applications.max_by(&:updated_at).to_s
        
        render "api/v1/applications/index"
      end

      # GET /applications/1
      def show
        if @application
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded application view (show) for #{@application.id}." }
          
          @cache_key = @application.updated_at.try(:utc).try(:to_s, :number)
          
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
