class AffiliationsController < ApplicationController
  filter_access_to :all, :attribute_check => true
  respond_to :json

  def index
    if params[:q]
      @as = Affiliation.where("upper(name) like ?", "%#{params[:q].upcase}%")
    else
      @as = Affiliation.all
    end

    @affiliations = @as.map{ |x| { id: x.id, name: x.name } }

    respond_with @affiliations
  end
end
