class PeopleController < ApplicationController
  include DatabaseExtensions
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
    load 'LdapHelper.rb'
    require 'ostruct'
    
    @results = []
    
    if params[:term]
      ldap = LdapHelper.new
      ldap.connect
    
      ldap.search("(uid=" + params[:term] + "*)") do |result|
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
      
      ldap.disconnect
    end
    
    respond_with @results
  end
  
  # Imports a specific person from an external database. Use the above 'search' first to find possible imports
  def import
    load 'LdapHelper.rb'
    load 'LdapPersonHelper.rb'
    
    logger.info "#{current_user.loginid}@#{request.remote_ip}: Importing user with loginid #{params[:loginid]}."

    # We allow creating people (and titles, etc.) for the purpose of import.
    # User must still have authorization for people#import
    Authorization.ignore_access_control(true)
    
    if params[:loginid]
      ldap = LdapHelper.new
      ldap.connect
    
      ldap.search("(uid=" + params[:loginid] + ")") do |result|
        log = StringIO.new
        @p = LdapPersonHelper.create_or_update_person_from_ldap(result, log)
        Rails.logger.info log.string
      end
    
      ldap.disconnect
    end
  
    @p.save
    
    Authorization.ignore_access_control(false)
    
    respond_with @p
  end
  
  private
  
  def load_person
    @person = Person.find_by_loginid(params[:id])
    @person = Person.find_by_id(params[:id]) unless @person
  end
  
  def load_people
    if params[:q]
      upper_q = params[:q].upcase

      @people = Person.where("upper(loginid) like ? or upper(first) like ? or upper(last) like ? or upper(" + db_concat(:first, ' ', :last) + ") like ? or upper(name) like ?", "%#{upper_q}%", "%#{upper_q}%", "%#{upper_q}%", "%#{upper_q}%", "%#{upper_q}%")

      @people.map()
    else
      @people = Person.all
    end
  end
end
