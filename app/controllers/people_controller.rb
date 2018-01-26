class PeopleController < ApplicationController
  before_action :load_person, only: :show
  before_action :load_people, only: :index

  ## RESTful ACTIONS

  # Used by the API and various Person-only token inputs
  # Takes optional 'q' parameter to filter index
  def index
    authorize Person

    if @people.count.positive?
      @cache_key = 'people/' + (params[:q] ? params[:q] : '') +
                   '/' + @people.max_by(&:updated_at).updated_at.try(:utc).try(:to_s, :number).to_s
    end

    respond_to do |format|
      format.json { render 'people/index' }
    end
  end

  def show
    authorize @person

    @cache_key = 'person/' + @person.id.to_s + '/' + @person.updated_at.try(:utc).try(:to_s, :number)

    respond_to do |format|
      format.json { render 'people/show' }
    end
  end

  ## Non-RESTful ACTIONS

  # 'search' queries _external_ databases (LDAP, etc.). GET /search?q=loginid (can be partial loginid, * will be appended)
  # If you wish to search the internal databases, use index with GET parameter q=..., e.g. /people?q=somebody
  def search
    authorize Person

    require 'dss_dw'

    @results = DssDw.search_people(params[:term])&.map do |entry|
      OpenStruct.new(
        loginid: entry['userId'],
        email: entry['email'],
        name: entry['dFullName'],
        imported: Person.exists?(loginid: entry['userId'])
      )
    end

    respond_to do |format|
      format.json { render 'people/search' }
    end
  end

  # Imports a specific person from an external database. Use the above 'search' first to find possible imports
  def import
    authorize Person

    if params[:loginid]
      require 'dss_dw'

      @person = DssDw.create_or_update_using_dw(params[:loginid])

      if @person
        @cache_key = 'person/' + @person.id.to_s + '/' + @person.updated_at.try(:utc).try(:to_s, :number)

        respond_to do |format|
          format.json { render 'people/show' }
        end
      else
        logger.error "Could not import person #{params[:loginid]}, no results from DW or error while saving."

        raise ActionController::RoutingError.new('Not Found')
      end
    else
      logger.error 'Invalid request for DW person import. Did not specify loginid.'

      respond_to do |format|
        format.json { render json: nil, status: 400 }
      end
    end
  end

  private

  def load_person
    @person = Person.find_by_loginid(params[:id])
    @person ||= Person.find_by_id!(params[:id])
  end

  def load_people
    if params[:q]
      people_table = Person.arel_table
      # Only show active people in the search. The group membership token input, for example, uses this method
      # to query people but it does not show deactivated people. This hides potential members and if they are
      # added again, it'll throw an error that the membership already exists.
      @people = Person.where(active: true)
                      .where(people_table[:name].matches("%#{params[:q]}%")
                                                .or(people_table[:loginid].matches("%#{params[:q]}%"))
                                                .or(people_table[:first].matches("%#{params[:q]}%"))
                                                .or(people_table[:last].matches("%#{params[:q]}%")))

      @people.map
    else
      @people = Person.all
    end
  end

  def person_params
    params.require(:person).permit(:first, :last, :address, :email)
  end
end
