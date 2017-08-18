module Api
  module V1
    class GroupsController < Api::V1::BaseController
      before_action :load_group, only: [:show, :update]

      def show
        if @group
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded group view (show) for #{@group.id}." }

          @cache_key = "api/groups/" + @group.id.to_s + '/' + @group.updated_at.try(:utc).try(:to_s, :number)

          render "api/v1/groups/show"
        else
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Attempted to load group view (show) for invalid ID #{@group_id}." }

          render :text => "Invalid group ID '#{@group_id}'.", :status => 404
        end
      end

      def update
        if @group
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Updating group for #{@group.id}." }

          if @group.update_attributes(group_params)
            @group.touch

            render json: {}, status: 200
          else
            logger.debug "Bad api/group UPDATE request. Errors:"
            logger.debug @group.errors.full_messages
            render :text => "Found group but could not update for ID '#{@group_id}'.", :status => 500
          end
        else
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Attempted to update group for invalid ID #{@group_id}." }
          render :text => "Invalid group ID '#{@group_id}'.", :status => 404
        end
      end

      private

        def load_group
          begin
            @group_id = params[:id].to_i
            @group = Group.find_by_id(@group_id)
            @group = Group.find_by_name(params[:id].to_s) unless @group
          rescue ActiveRecord::RecordNotFound
            # This exception is acceptable. We catch it to avoid triggering the
            # uncaught exceptions handler in ApplicationController.
          end
        end

        def group_params
          params.require(:group_attributes).permit(:name)
        end
    end
  end
end
