class Admin::ApiKeyUsersController < Admin::BaseController
  before_action :new_api_key_user_from_params, only: :create
  before_action :load_api_keys, only: :index

  def index
    authorize ApiKeyUser

    @cache_key = 'admin/api_key_users/' + Digest::MD5.hexdigest(@api_keys.map(&:cache_key).to_s)

    respond_to do |format|
      format.json { render 'admin/api_key_users/index' }
    end
  end

  def create
    authorize @api_key_user

    respond_to do |format|
      if @api_key_user.save
        logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Created new API key, #{params[:api_key_user]}."
        format.json { render json: @api_key_user, status: :created }
      else
        format.json { render json: @api_key_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @api_key = ApiKeyUser.find_by_id(params[:id])

    authorize @api_key

    @api_key.destroy

    logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Deleted API key '#{@api_key.name}' (#{params[:id]})."

    respond_to do |format|
      format.json { head :no_content, status: :destroyed }
    end
  end

  private

  def load_api_keys
    @api_keys = ApiKeyUser.all
  end

  def new_api_key_user_from_params
    @api_key_user = ApiKeyUser.new(api_key_params)
  end

  def api_key_params
    params.require(:api_key_user).permit(:name)
  end
end
