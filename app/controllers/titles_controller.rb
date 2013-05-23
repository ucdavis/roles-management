class TitlesController < ApplicationController
  filter_access_to :all, :attribute_check => true, :load_method => :load_titles
  respond_to :json

  def index
    respond_with @titles
  end
  
  private
  
  def load_titles
    if params[:q]
      @titles = Title.where("upper(name) like ? or code like ?", "%#{params[:q].upcase}%", "%#{params[:q]}%")
    else
      @titles = Title.all
    end
  end
end
