class Admin::ActivityLogsController < Admin::BaseController
  filter_access_to :all, :attribute_check => true
  filter_access_to :index, :attribute_check => true, :load_method => :load_activity_logs
  respond_to :json
  
  def index
    respond_with @activity_logs
  end
  
  private
  
  def load_activity_logs
    @activity_logs = ActivityLog.all
  end
end
