module Api
  module V1
    class RolesController < ApplicationController
      before_filter :load_role, :only => :show
      filter_access_to :all, :attribute_check => true

      def show
        if @role
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded role view (show) for #{@role.id}." }

          @cache_key = "api/role/" + @role.id.to_s + '/' + @role.updated_at.try(:utc).try(:to_s, :number)

          render "api/v1/roles/show"
        else
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Attempted to load role view (show) for invalid ID #{params[:id]}." }
          render :text => "Invalid role ID '#{params[:id]}'.", :status => 404
        end
      end

      def update
        if @role
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Updating role for #{@role.id}." }

          if @role.update_attributes(role_params)
            @role.touch

            render json: {}, status: 200
          else
            render :text => "Found role but could not update for ID '#{params[:id]}'.", :status => 500
          end
        else
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Attempted to update role for invalid ID #{params[:id]}." }
          render :text => "Invalid role ID '#{params[:id]}'.", :status => 404
        end
      end

      private

      def load_role
        # TODO: add equivalent .with_permissions_to(read:)
        @role = Role.find_by_id(params[:id])
      end
      
      def role_params
        params.permit(:name, :token, :description, :application_id,
                                        {role_assignments_attributes: [:role_id, :entity_id, :_destroy]})
      end
    end
  end
end
