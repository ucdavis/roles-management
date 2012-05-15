class PeopleController < ApplicationController
  require 'ldap'
  
  before_filter :load_person, :only => [:show]
  #filter_resource_access
  filter_access_to :all
  
  # GET /people
  def index
    @people = Person.where("first like ? or last like ?", "%#{params[:q]}%", "%#{params[:q]}%")

    @people.map()

    logger.info "#{current_user.loginid}@#{request.remote_ip}: Loaded people index page."

    respond_to do |format|
      format.html
    end
  end

  # GET /people/1
  def show
    @person = Person.find_by_id(params[:id])

    logger.info "#{current_user.loginid}@#{request.remote_ip}: Loaded person page for #{params[:id]}."

    respond_to do |format|
      format.html { render "show", :layout => false }
      format.json { render json: @person }
    end
  end

  # GET /people/new
  def new
    @person = Person.new

    if params[:loginid]
      @person.loginid = params[:loginid]
      
      # Search via LDAP
      # Retrieve LDAP passwords from config/database.yml
      ldap_settings = YAML.load_file("#{Rails.root.to_s}/config/database.yml")['ldap']

      # Connect to LDAP
      conn = LDAP::SSLConn.new( 'ldap.ucdavis.edu', 636 )
      conn.set_option( LDAP::LDAP_OPT_PROTOCOL_VERSION, 3 )
      conn.bind(dn = ldap_settings['base_dn'], password = ldap_settings['base_pw'] )
      
      # Search!
      conn.search('ou=People,dc=ucdavis,dc=edu', LDAP::LDAP_SCOPE_SUBTREE, '(uid=' + params[:loginid] + ')') do |entry|
        @person.first = entry.get_values('givenName').to_s[2..-3]
        @person.last = entry.get_values('sn').to_s[2..-3]
        @person.email = entry.get_values('mail').to_s[2..-3]
        @person.phone = entry.get_values('telephoneNumber').to_s[2..-3]
        if @person.phone != nil
          @person.phone = @person.phone.sub("+1 ", "").gsub(" ", "") # clean up number
        end
        @person.address = entry.get_values('street').to_s[2..-3]
        @person.preferred_name = @person.first + " " + @person.last
      end
      
    end

    respond_to do |format|
      format.html
    end
  end

  # GET /people/1/edit
  def edit
    @person = Person.find_by_id(params[:id])
    
    logger.info "#{current_user.loginid}@#{request.remote_ip}: Loaded edit page for #{params[:id]}."
  end

  # POST /people
  def create
    @person = Person.new(params[:person])

    respond_to do |format|
      if @person.save
        logger.info "#{current_user.loginid}@#{request.remote_ip}: Created new person, #{params[:person]}."
        format.html { redirect_to(@person, :notice => 'Person was successfully created.') }
        format.json { render json: @person, status: :created, location: @person }
      else
        format.html { render :action => "new" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /people/1
  def update
    @person = Person.find_by_id(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        logger.info "#{current_user.loginid}@#{request.remote_ip}: Updated person #{params[:person]}."
        format.html { redirect_to(@person, :notice => 'Person was successfully updated.') }
        format.js { render json: @person, status: :ok }
      else
        format.html { render :action => "edit" }
        format.js { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  def destroy
    @person = Person.find_by_id(params[:id])
    @person.destroy!
    
    logger.info "#{current_user.loginid}@#{request.remote_ip}: Deleted person #{params[:id]}."

    respond_to do |format|
      format.html { redirect_to(people_url) }
    end
  end

  protected
  
  def load_person
    if allowed_to? :show, :people
      @person = Person.find_by_id(params[:id])
    end
  end
end
