class PeopleController < ApplicationController
  include DatabaseExtensions
  filter_access_to :all
  respond_to :json

  ## RESTful ACTIONS

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
    @person = Person.find_by_id(params[:id]) unless @person

    respond_with(@person)
  end
  
  def update
    @person = Person.find(params[:id])
    @person.update_attributes(params[:person].except(:id, :name, :roles))

    respond_with(@person)
  end
  
  ## Non-RESTful ACTIONS
  
  # 'search' queries _external_ databases (LDAP, etc.)
  # If you wish to search the internal databases, use index with GET parameter q=..., e.g. /people?q=somebody
  def search
    
  end
  
  # Imports a specific person from an external database. Use the above 'search' first to find possible imports
  def import
    
  end
end
