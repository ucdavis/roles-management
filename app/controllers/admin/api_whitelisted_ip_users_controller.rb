class Admin::ApiWhitelistedIpUsersController < Admin::BaseController
  before_filter :new_api_whitelisted_ip_user_from_params, :only => :create
  before_filter :load_whitelisted_users, :only => :index

  def index
    respond_to do |format|
      format.json { render json: @addresses }
    end
  end

  # POST /admin/api_whitelisted_ips.json
  def create
    respond_to do |format|
      if @api_whitelisted_ip_user.save
        logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Created new whitelisted IP address, #{params[:api_whitelisted_ip]}."
        format.json { render json: @api_whitelisted_ip_user, status: :created }
      else
        format.json { render json: @api_whitelisted_ip_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/api_whitelisted_ips/1.json
  def destroy
    @address = ApiWhitelistedIpUser.find(params[:id])
    @address.destroy

    logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Deleted whitelisted IP address, #{params[:address]}."

    respond_to do |format|
      format.json { head :no_content, status: :destroyed }
    end
  end

  private

    def load_whitelisted_users
      @addresses = ApiWhitelistedIpUser.all
    end

    def new_api_whitelisted_ip_user_from_params
      @api_whitelisted_ip_user = ApiWhitelistedIpUser.new(api_whitelisted_ip_user_params)
    end

    def api_whitelisted_ip_user_params
      params.require(:api_whitelisted_ip_user).permit(:address, :reason)
    end
end
