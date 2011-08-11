class PeopleController < ApplicationController
  before_filter :load_person, :only => [:show]
  filter_resource_access
  
  # GET /people
  def index
    @people = Person.where("first like ? or last like ?", "%#{params[:q]}%", "%#{params[:q]}%")

    @people.map()

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @people }
    end
  end

  # GET /people/1
  def show
    @person = Person.find_by_loginid(params[:id])

    respond_to do |format|
      format.html
      #format.xml  { render :xml => @person}#.to_xml( :include => { :groups => { :only => [:name, :code] }, :title => { :only => [:name] } }) }
    end
  end

  # GET /people/new
  def new
    @person = Person.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /people/1/edit
  def edit
    @person = Person.find_by_loginid(params[:id])
  end

  # POST /people
  def create
    @person = Person.new(params[:person])

    respond_to do |format|
      if @person.save
        format.html { redirect_to(@person, :notice => 'Person was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /people/1
  def update
    @person = Person.find_by_loginid(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to(@person, :notice => 'Person was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /people/1
  def destroy
    @person = Person.find_by_loginid(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to(people_url) }
    end
  end
  
  def new_from_ldap
    
  end
  
  protected
  
  def load_person
    if permitted_to? :show, :people
      @person = Person.find_by_loginid(params[:id])
    end
  end
end
