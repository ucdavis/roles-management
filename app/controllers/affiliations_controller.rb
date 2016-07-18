class AffiliationsController < ApplicationController
  before_filter :load_affiliations, :only => :index

  def index
    authorize Affiliation
    
    respond_to do |format|
      format.json { render json: @affiliations }
    end
  end

  private

    def load_affiliations
      if params[:q]
        affiliations_table = Affiliation.arel_table
        @as = Affiliation.where(affiliations_table[:name].matches("%#{params[:q]}%"))
      else
        @as = Affiliation.all
      end

      @affiliations = @as.map{ |x| { id: x.id, name: x.name } }
    end
end
