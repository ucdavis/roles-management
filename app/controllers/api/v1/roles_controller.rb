module Api
  module V1
    class RolesController < Api::V1::BaseController
      before_action :load_role, only: [:show, :update]

      def show
        if @role
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded role view (show) for #{@role.id}." }

          @cache_key = 'api/role/' + @role.id.to_s + '/' + @role.updated_at.try(:utc).try(:to_s, :number)

          render 'api/v1/roles/show'
        else
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Attempted to load role view (show) for invalid ID #{@role_id}." }
          render plain: "Invalid role ID '#{@role_id}'.", status: 404
        end
      end

      def update
        if @role
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Updating role for #{@role.id}." }

          if @role.update_attributes(role_params)
            @role.touch

            render json: {}, status: 200
          else
            logger.debug 'Bad api/roles UPDATE request. Errors:'
            logger.debug @role.errors.full_messages
            render plain: "Found role but could not update for ID '#{@role_id}'.", status: 500
          end
        else
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Attempted to update role for invalid ID #{@role_id}." }
          render plain: "Invalid role ID '#{@role_id}'.", status: 404
        end
      end

      private

      def load_role
        @role_id = params[:id].to_i # sanitize
        @role = Role.includes(:role_assignments).includes(:entities).find_by_id(@role_id)
      end

      def role_params
        params.require(:role).permit(role_assignments_attributes: [:id, :role_id, :entity_id, :_destroy])
      end
    end
  end
end
