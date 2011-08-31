class Api::PeopleController < Api::BaseController
  # GET /api/people.xml
  def index
    @people = Person.where("first like ? or last like ?", "%#{params[:q]}%", "%#{params[:q]}%")

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

    respond_to do |format|
      format.xml
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
end
