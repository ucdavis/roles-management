module Api
  module V1
    class RolesController < ApplicationController
      before_filter :load_role, :only => [:show, :update]

      def show
        authorize :api_v1, :use?
        
        if @role
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded role view (show) for #{@role.id}." }

          @cache_key = "api/role/" + @role.id.to_s + '/' + @role.updated_at.try(:utc).try(:to_s, :number)

          render "api/v1/roles/show"
        else
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Attempted to load role view (show) for invalid ID #{@role_id}." }
          render :text => "Invalid role ID '#{@role_id}'.", :status => 404
        end
      end

      def update
        authorize :api_v1, :use?
        
        if @role
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Updating role for #{@role.id}." }

          if @role.update_attributes(role_params)
            @role.touch

            render json: {}, status: 200
          else
            render :text => "Found role but could not update for ID '#{@role_id}'.", :status => 500
          end
        else
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Attempted to update role for invalid ID #{@role_id}." }
          render :text => "Invalid role ID '#{@role_id}'.", :status => 404
        end
      end

      private

        def load_role
            @role_id = params[:id].to_i # sanitize
            @role = Role.find_by_id(@role_id)
        end
        
        def role_params
            params.permit(:name, :token, :description, :application_id,
                                            {role_assignments_attributes: [:role_id, :entity_id, :_destroy]})
        end

    end
  end
end
