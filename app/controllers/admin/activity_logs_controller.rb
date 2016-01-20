class Admin::ActivityLogsController < Admin::BaseController
  filter_access_to :all, :attribute_check => true
  filter_access_to :index, :attribute_check => true, :load_method => :load_activity_logs

  def index
    respond_to do |format|
      format.json { render json: @activity_logs }
    end
  end

  private

  def load_activity_logs
    @activity_logs = ActivityLog.all
  end
end
