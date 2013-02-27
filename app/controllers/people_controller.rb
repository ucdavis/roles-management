class PeopleController < ApplicationController
  include DatabaseExtensions
  filter_access_to :all
  respond_to :json

  # Used by the API and various Person-only token inputs
  # Takes optional 'q' parameter to filter index
  def index
    if params[:q]
      upper_q = params[:q].upcase

      @people = Person.where("upper(loginid) like ? or upper(first) like ? or upper(last) like ? or upper(" + db_concat(:first, ' ', :last) + ") like ? or upper(name) like ?", "%#{upper_q}%", "%#{upper_q}%", "%#{upper_q}%", "%#{upper_q}%", "%#{upper_q}%")

      @people.map()
    else
      @people = Person.all
    end

    respond_with @people
  end

  def show
    @person = Person.find_by_loginid(params[:id])

    respond_with(@person)
  end
  
  
  def update
    @person = Person.find(params[:id])
    @person.update_attributes(params[:person].except(:id, :name, :roles))

    respond_with(@person)
  end
end
