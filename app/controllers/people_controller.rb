class PeopleController < ApplicationController
  before_filter :load_person, :only => :show
  filter_access_to :all, :attribute_check => true
  filter_access_to :index, :attribute_check => true, :load_method => :load_people
  filter_access_to [:search, :import], :attribute_check => false
  respond_to :json

  ## RESTful ACTIONS

  # Used by the API and various Person-only token inputs
  # Takes optional 'q' parameter to filter index
  def index
    respond_with @people
  end

  def show
    respond_with(@person)
  end

  def update
    if params[:id] and params[:person]
      @person = Person.find(params[:id])
      @person.update_attributes(params[:person].except(:id, :name, :roles))

      respond_with @person
    else
      respond_with 422
    end
  end

  ## Non-RESTful ACTIONS

  # 'search' queries _external_ databases (LDAP, etc.). GET /search?q=loginid (can be partial loginid, * will be appended)
  # If you wish to search the internal databases, use index with GET parameter q=..., e.g. /people?q=somebody
  def search
    require 'ldap_helper'
    require 'ostruct'

    @results = []

    if params[:term]
      ldap = LdapHelper.new
      ldap.connect

      ldap.search("(|(uid=#{params[:term]}*)(cn=#{params[:term]}*)(sn=#{params[:term]}*))") do |result|
        if result.get_values('uid')
          p = OpenStruct.new

          p.loginid = result.get_values('uid')[0]
          p.first = result.get_values('givenName')[0]
          p.last = result.get_values('sn')[0]
          p.email = result.get_values('mail').to_s[2..-3]
          p.phone = result.get_values('telephoneNumber').to_s[2..-3]
          unless p.phone.nil?
            p.phone = p.phone.sub("+1 ", "").gsub(" ", "") # clean up number
          end
          p.address = result.get_values('street').to_s[2..-3]
          p.name = result.get_values('displayName')[0]
          p.imported = Person.exists?(:loginid => p.loginid)

          @results << p
        end
      end

      ldap.disconnect
    end

    render "people/search"
    #respond_with @results
  end

  # Imports a specific person from an external database. Use the above 'search' first to find possible imports
  def import
    if params[:loginid]
      require 'ldap'
      require 'ldap_helper'
      require 'ldap_person_helper'

      logger.tagged "people#import(#{params[:loginid]})" do
        logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Importing user with loginid #{params[:loginid]}."

        import_start = Time.now

        # We allow creating people (and titles, etc.) for the purpose of import.
        # User must still have authorization for people#import
        disable_authorization

        if params[:loginid]
          ldap_import_start = Time.now

          ldap = LdapHelper.new
          ldap.connect

          ldap.search("(uid=" + params[:loginid] + ")") do |result|
            @p = LdapPersonHelper.create_or_update_person_from_ldap(result, Rails.logger)
          end

          logger.debug @p.inspect

          ldap.disconnect

          ldap_import_finish = Time.now
        end

        if @p
          @p.save

          enable_authorization

          import_finish = Time.now

          logger.info "Finished LDAP import request. LDAP operations took #{ldap_import_finish - ldap_import_start}s while the entire operation took #{import_finish - import_start}s."

          respond_with @p
        else
          enable_authorization

          logger.error "Could not import person #{params[:loginid]}, no results from LDAP."

          raise ActionController::RoutingError.new('Not Found')
        end
      end
    else
      logger.error "Invalid request for LDAP person import. Did not specify loginid."

      respond_with 400
    end
  end

  private

  def load_person
    @person = Person.with_permissions_to(:read).find_by_loginid(params[:id])
    @person = Person.with_permissions_to(:read).find_by_id(params[:id]) unless @person
  end

  def load_people
    if params[:q]
      people_table = Person.arel_table
      # Only show active people in the search. The group membership token input, for example, uses this method
      # to query people but it does not show deactivated people. This hides potential members and if they are
      # added again, it'll throw an error that the membership already exists.
      @people = Person.with_permissions_to(:read).where(:active => true).where(people_table[:name].matches("%#{params[:q]}%").or(people_table[:loginid].matches("%#{params[:q]}%")).or(people_table[:first].matches("%#{params[:q]}%")).or(people_table[:last].matches("%#{params[:q]}%")))

      @people.map()
    else
      @people = Person.with_permissions_to(:read).all
    end
  end
end
