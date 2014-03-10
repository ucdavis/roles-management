module Api
  module V1
    class RolesController < ApplicationController
      before_filter :load_role, :only => :show
      filter_access_to :all, :attribute_check => true

      def show
        if @role
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded role view (show) for #{@role.id}." }
          
          @cache_key = @role.id + '/' + @role.updated_at.try(:utc).try(:to_s, :number)
          
          render "api/v1/roles/show"
        else
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Attempted to load role view (show) for invalid ID #{params[:id]}." }
          render :text => "Invalid role ID '#{params[:id]}'.", :status => 404
        end
      end
  
      private
  
      def load_role
        @role = Role.with_permissions_to(:read).find_by_id(params[:id])
      end
    end
  end
end
