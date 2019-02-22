class TitlesController < ApplicationController
  before_action :load_titles, only: :index

  def index
    authorize Title

    respond_to do |format|
      format.json { render json: @titles }
    end
  end

  def show_by_code
    @title = Title.find_by!(code: params[:code])

    authorize @title

    respond_to do |format|
      format.json { render json: @title }
    end
  end

  private

  def load_titles
    if params[:q]
      titles_table = Title.arel_table
      @titles = Title.where(titles_table[:name].matches("%#{params[:q]}%").or(titles_table[:code].matches("%#{params[:q]}%")))
    else
      @titles = Title.all
    end
  end
end
