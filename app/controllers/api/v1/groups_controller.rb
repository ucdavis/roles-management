module Api
  module V1
    class GroupsController < ApplicationController
      before_filter :load_group, :only => :show

      def show
        if @group
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded group view (show) for #{@group.id}." }

          @cache_key = "api/groups/" + @group.id.to_s + '/' + @group.updated_at.try(:utc).try(:to_s, :number)

          respond_to do |format|
            format.json { render "api/v1/groups/show" }
          end
        else
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Attempted to load group view (show) for invalid ID #{@group_id}." }
          repsond_to do |format|
            format.json { render :text => "Invalid group ID '#{@group_id}'.", :status => 404 }
          end
        end
      end

      private

      def load_group
        begin
          @group_id = params[:id].to_i
          @group = Group.find_by_id(@group_id)
        rescue ActiveRecord::RecordNotFound
          # This exception is acceptable. We catch it to avoid triggering the
          # uncaught exceptions handler in ApplicationController.
        end
      end
    end
  end
end
