class AffiliationsController < ApplicationController
  filter_access_to :all, :attribute_check => true, :load_method => :load_affiliations

  def index
    respond_to do |format|
      format.json { render json: @affiliations }
    end
  end

  private

  def load_affiliations
    if params[:q]
      affiliations_table = Affiliation.arel_table
      @as = Affiliation.with_permissions_to(:read).where(affiliations_table[:name].matches("%#{params[:q]}%"))
    else
      @as = Affiliation.with_permissions_to(:read).all
    end

    @affiliations = @as.map{ |x| { id: x.id, name: x.name } }
  end
end
