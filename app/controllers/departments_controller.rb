class DepartmentsController < ApplicationController
  before_action :load_departments, only: :index
  before_action :load_department, only: :show

  # GET /departments.json
  def index
    authorize Department

    @cache_key = 'department/' + Digest::MD5.hexdigest(@departments.map(&:cache_key).to_s)

    respond_to do |format|
      format.json { render 'departments/index' }
    end
  end

  # GET /departments/1.json
  def show
    authorize @department

    respond_to do |format|
      format.json { render json: @department }
    end
  end

  private

  def load_department
    @department = Department.find_by_id!(params[:id])
  end

  def load_departments
    @departments = Department.all
  end
end
