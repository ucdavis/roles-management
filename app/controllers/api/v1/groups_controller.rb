module Api
  module V1
    class GroupsController < Api::V1::BaseController
      before_filter :load_group, :only => [:show, :update]

      def show
        authorize :api_v1, :use?
        
        if @group
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded group view (show) for #{@group.id}." }

          @cache_key = "api/groups/" + @group.id.to_s + '/' + @group.updated_at.try(:utc).try(:to_s, :number)

          render "api/v1/groups/show"
        else
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Attempted to load group view (show) for invalid ID #{@group_id}." }

          render :text => "Invalid group ID '#{@group_id}'.", :status => 404
        end
      end

      # IPA will need to ensure all IPA users exist in RM, get their entity_ids, then edit group membership
      # {"entity"=>{"name"=>"My First Group", "memberships_attributes"=>[{"calculated"=>false, "entity_id"=>35}]}, "id"=>"2"}
      def update
        authorize :api_v1, :use?

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
