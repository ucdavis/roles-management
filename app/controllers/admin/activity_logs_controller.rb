class Admin::ActivityLogsController < Admin::BaseController
  before_action :load_activity_logs, only: :index

#   def index
#     respond_to do |format|
#       format.json { render json: @activity_logs }
#     end
#   end

  private

    def load_activity_logs
        @activity_logs = ActivityLog.all
    end
end
