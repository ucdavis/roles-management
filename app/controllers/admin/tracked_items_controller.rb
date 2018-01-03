class Admin::TrackedItemsController < Admin::BaseController
  before_action :load_tracked_items, only: :index

  def index
    authorize :tracking, :index?

    @cache_key = 'admin/tracked_items/' + Digest::MD5.hexdigest(@tracked_items.map(&:cache_key).to_s + @departments.map(&:cache_key).to_s)

    respond_to do |format|
      format.json { render 'admin/tracked_items/index' }
    end
  end

  private

  def load_tracked_items
    @tracked_items = TrackedItem.all
    @departments = Department.all
  end
end
