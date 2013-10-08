class Admin::ApiKeyUsersController < ApplicationController
  before_filter :new_api_key_user_from_params, :only => :create
  filter_access_to :all, :attribute_check => true
  filter_access_to :index, :attribute_check => true, :load_method => :load_api_keys
  respond_to :json

  def index
    respond_with @api_keys
  end

  def create
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
    @api_key.destroy

    logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Deleted API key '#{@api_key.name}' (#{params[:id]})."

    respond_to do |format|
      format.json { head :no_content }
    end
  end
  
  private
  
  def load_api_keys
    @api_keys = ApiKeyUser.all
  end
  
  def new_api_key_user_from_params
    @api_key_user = ApiKeyUser.new(params[:api_key_user])
  end
end
