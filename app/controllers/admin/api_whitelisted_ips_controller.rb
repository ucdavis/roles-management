class Admin::ApiWhitelistedIpsController < ApplicationController
  filter_access_to :all, :attribute_check => true
  respond_to :json

  def index
    # SECUREME
    @addresses = ApiWhitelistedIpUser.all

    respond_with @addresses
  end

  # POST /admin/api_whitelisted_ips.json
  def create
    # SECUREME
    @address = ApiWhitelistedIpUser.new(params[:api_whitelisted_ip])

    respond_to do |format|
      if @address.save
        logger.info "#{current_user.loginid}@#{request.remote_ip}: Created new whitelisted IP address, #{params[:address]}."
        format.json { render json: @address, status: :created }
      else
        format.json { render json: @address.errors, status: :unprocessable_entity }
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
end
