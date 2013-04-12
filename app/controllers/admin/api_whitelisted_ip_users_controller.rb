class Admin::ApiWhitelistedIpUsersController < ApplicationController
  before_filter :new_api_whitelisted_ip_user_from_params, :only => :create
  filter_access_to :all, :attribute_check => true
  filter_access_to :index, :attribute_check => true, :load_method => :load_whitelisted_users
  respond_to :json

  def index
    # SECUREME
    respond_with @addresses
  end

  # POST /admin/api_whitelisted_ips.json
  def create
    # SECUREME
    respond_to do |format|
      if @api_whitelisted_ip_user.save
        logger.info "#{current_user.loginid}@#{request.remote_ip}: Created new whitelisted IP address, #{params[:api_whitelisted_ip]}."
        format.json { render json: @api_whitelisted_ip_user, status: :created }
      else
        format.json { render json: @api_whitelisted_ip_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/api_whitelisted_ips/1.json
  def destroy
    # SECUREME
    @address = ApiWhitelistedIpUser.find(params[:id])
    @address.destroy

    logger.info "#{current_user.loginid}@#{request.remote_ip}: Deleted whitelisted IP address, #{params[:address]}."

    respond_to do |format|
      format.json { head :no_content }
    end
  end
  
  private
  
  def load_whitelisted_users
    @addresses = ApiWhitelistedIpUser.all
  end
  
  def new_api_whitelisted_ip_user_from_params
    @api_whitelisted_ip_user = ApiWhitelistedIpUser.new(params[:api_whitelisted_ip_user])
  end
end
