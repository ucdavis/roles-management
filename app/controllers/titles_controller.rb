class TitlesController < ApplicationController
  before_action :load_titles, only: :index

  def index
    authorize Title

    respond_to do |format|
      format.json { render json: @titles }
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
