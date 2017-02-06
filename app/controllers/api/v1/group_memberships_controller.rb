module Api
  module V1
    class GroupMembershipsController < Api::V1::BaseController
      before_action :set_group_membership, :only => [:destroy]

      def create
        @group_membership = GroupMembership.new(group_membership_params)

        respond_to do |format|
          if @group_membership.save
            @cache_key = "api/group_memberships/" + @group_membership.id.to_s + '/' + @group_membership.updated_at.try(:utc).try(:to_s, :number)

            format.json { render :show, status: :created }
          else
            format.json { render json: @group_membership.errors, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @group_membership.destroy!

        logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Deleted group membership, #{@group_membership}."

        respond_to do |format|
          format.json { head :no_content }
        end
      end

      private

        def set_group_membership
          @group_membership = GroupMembership.find(params[:id])
        end

        def group_membership_params
          params.permit(:id, :entity_id, :group_id)
        end
    end
  end
end
