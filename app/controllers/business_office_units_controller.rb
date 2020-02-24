class BusinessOfficeUnitsController < ApplicationController
  before_action :load_bous, only: :index

  def index
    authorize BusinessOfficeUnit

    @cache_key = 'business_office_unit/' + Digest::MD5.hexdigest(@bous.map(&:cache_key).to_s)

    respond_to do |format|
      format.json { render 'business_office_units/index' }
    end
  end

  def show_by_code
    @bou = BusinessOfficeUnit.find_by!(org_oid: params[:code])

    authorize @bou

    respond_to do |format|
      format.json { render json: @bou }
    end
  end

  private

  def load_bous
    # 'q' matches on dept_official_name
    if params[:q]
      bous_table = BusinessOfficeUnit.arel_table
      @bous = BusinessOfficeUnit.where(bous_table[:dept_official_name].matches("%#{params[:q]}%"))
    else
      @bous = BusinessOfficeUnit.all
    end
  end
end
