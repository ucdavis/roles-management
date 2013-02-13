class TitlesController < ApplicationController
  filter_access_to :all
  respond_to :json

  def index
    if params[:q]
      @titles = Title.where("upper(name) like ? or code like ?", "%#{params[:q].upcase}%", "%#{params[:q]}%")
    else
      @titles = Title.all
    end

    respond_with @titles
  end
end
