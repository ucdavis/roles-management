class ClassificationsController < ApplicationController
  filter_access_to :all
  respond_to :json

  def index
    if params[:q]
      @classifications = Classification.where("upper(name) like ?", "%#{params[:q].upcase}%")
    else
      @classifications = Classification.all
    end

    respond_with @classifications
  end
end
