class Admin::ApiKeysController < ApplicationController
  filter_access_to :all
  respond_to :json

  def index
    # SECUREME
    @api_keys = ApiKeyUser.all

    respond_with @api_keys
  end

  def create
    # SECUREME
    @api_key = ApiKeyUser.new(params[:api_key])

    respond_to do |format|
      if @api_key.save
        logger.info "#{current_user.loginid}@#{request.remote_ip}: Created new API key, #{params[:api_key]}."
        format.json { render json: @api_key, status: :created }
      else
        format.json { render json: @api_key.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # SECUREME
    @api_key = ApiKeyUser.find(params[:id])
    @api_key.destroy

    logger.info "#{current_user.loginid}@#{request.remote_ip}: Deleted API key, #{params[:api_key]}."

    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
