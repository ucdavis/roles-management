class Api::PeopleController < Api::BaseController
  # GET /api/people.xml
  def index
    adapter = ActiveRecord::Base.connection.instance_values["config"][:adapter].to_sym

    case adapter
    when :sqlite3
      @people = Person.where("first like ? or last like ? or " + db_concat(:first, ' ', :last) + " like ? or name like ?", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%")
    else
      @people = Person.where("first ilike ? or last ilike ? or " + db_concat(:first, ' ', :last) + " ilike ? or name ilike ?", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%")
    end

    @people.map()

    respond_to do |format|
      format.xml  { render :xml => @people }
      format.json { render :json => @people }
    end
  end

  # GET /api/people/1.xml or /api/people/cthielen.xml
  def show
    if params[:id].to_i.to_s == params[:id]
      # Numeric only, assume id
      # Convert universal ID to person ID
      id = params[:id][1..-1]
      @person = Person.find_by_id(id)
    else
      # Not numeric only, assume loginid
      @person = Person.find_by_loginid(params[:id])
    end
  end

  # GET /api/people/new.xml
  def new
    @person = Person.new

    respond_to do |format|
      format.xml  { render :xml => @person }
    end
  end

  # GET /api/people/1/edit
  def edit
    @person = Person.find_by_loginid(params[:id])
  end

  # POST /api/people.xml
  def create
    @person = Person.new(params[:person])

    respond_to do |format|
      if @person.save
        format.xml  { render :xml => @person, :status => :created, :location => @person }
      else
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /api/people/1.xml
  def update
    @person = Person.find_by_loginid(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.xml  { head :ok }
      else
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /api/people/1.xml
  def destroy
    @person = Person.find_by_loginid(params[:id])
    @person.destroy

    respond_to do |format|
      format.xml  { head :ok }
    end
  end

  # GET /api/people/[loginid]/exists
  def exists
    exists = (not Person.find_by_loginid(params[:person_id]).nil?)

    respond_to do |format|
      format.json { render json: exists, status: :created }
    end
  end
end
