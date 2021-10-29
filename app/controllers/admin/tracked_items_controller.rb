class Admin::TrackedItemsController < Admin::BaseController
  before_action :load_tracked_items, only: :index

  def index
    authorize :tracked_item, :index?

    @cache_key = 'admin/tracked_items/' + Digest::MD5.hexdigest(@tracked_items.map(&:cache_key).to_s + @departments.map(&:cache_key).to_s)

    respond_to do |format|
      format.json { render 'admin/tracked_items/index' }
    end
  end

  def create
    @tracked_item = TrackedItem.new(tracked_item_params)

    authorize @tracked_item

    if @tracked_item.save
      logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Started tracking item, #{params[:tracked_item]}."
    else
      logger.warn "#{current_user.log_identifier}@#{request.remote_ip}: Failed to track item, #{params[:tracked_item]}."
    end

    respond_to do |format|
      format.json { render json: @tracked_item }
    end
  end

  def destroy
    @tracked_item = TrackedItem.find_by_id!(params[:id])

    @tracked_item = TrackedItem.find(params[:id])

    authorize @tracked_item

    @tracked_item.destroy

    logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Stopped tracking item, #{params[:tracked_item]}."

    respond_to do |format|
      format.json { render json: @tracked_item }
    end
  end

  private

  def load_tracked_items
    @tracked_items = TrackedItem.all
    @departments = Department.all
    @majors = Major.all
  end

  def tracked_item_params
    params.require(:tracked_item).permit(:kind, :item_id)
  end
end
