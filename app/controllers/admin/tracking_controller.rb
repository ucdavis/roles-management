class Admin::TrackingController < Admin::BaseController
  before_action :load_tracked_items, only: :index

  def index
    authorize :tracking, :index?

    respond_to do |format|
      format.json { render json: @tracked_items }
    end
  end

  private

  def load_tracked_items
    @tracked_items = []

    Department.all.each do |d|
      @tracked_items << { type: 'pps_department', name: d.officialName }
    end
  end
end
