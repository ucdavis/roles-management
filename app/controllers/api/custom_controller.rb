class Api::CustomController < Api::BaseController
  def search
    @people = Person.where("first like ? or last like ?", "%#{params[:q]}%", "%#{params[:q]}%")
    @groups = Group.where("name like ?", "%#{params[:q]}%")
    @ous = Ou.where("name like ?", "%#{params[:q]}%")
    
    # Return everything (in the search query)
    @everything = []
    
    @people.each do |person|
      @everything << {:id => ('1' + person.id.to_s).to_i, :name => person.first + ' ' + person.last }
    end
    @groups.each do |group|
      @everything << {:id => ('2' + group.id.to_s).to_i, :name => group.name }
    end
    @ous.each do |ou|
      @everything << {:id => ('3' + ou.id.to_s).to_i, :name => ou.name }
    end

    @everything.map()

    respond_to do |format|
      format.xml
      format.json { render :json => @everything, :callback => params[:callback] }
    end
  end

  # Use resolve sparingly - it's not optimized for speed currently (FIXME, TESTME, CLEANME)
  # Add &email to receive email addresses - implies &flatten as groups and OUs have no emails
  # Add &flatten to flatten groups and OUs into their people
  def resolve
    ids = params[:ids].split(",")
    include_email = params.has_key? :email
    flatten = params.has_key? :flatten
    
    # Include e-mail implies flatten as OUs and groups don't have specific e-mail addresses
    if include_email then flatten = true end
    
    @everything = []
    
    ids.each do |id|
      stripped_id = id[1..-1] # remove leading integer (indicates which object, see README Technical Notes)
      case id.first.to_i
      when 1
        p = Person.find_by_id(stripped_id)
        if include_email
          @everything << {:name => p.first + ' ' + p.last, :id => id, :email => p.email}
        else
          @everything << {:name => p.first + ' ' + p.last, :id => id}
        end
      when 2
        g = Group.find_by_id(stripped_id)
        if flatten
          g.people.each do |person|
            if include_email
              @everything << {:name => person.first + ' ' + person.last, :id => person.id, :email => person.email}
            else
              @everything << {:name => person.first + ' ' + person.last, :id => person.id}
            end
          end
        else
          @everything << {:name => g.name, :id => id}
        end
      when 3
        o = Ou.find_by_id(stripped_id)
        if flatten
          o.members.each do |person|
            if include_email
              @everything << {:name => person.first + ' ' + person.last, :id => person.id, :email => person.email}
            else
              @everything << {:name => person.first + ' ' + person.last, :id => person.id}
            end
          end
        else
          @everything << {:name => o.name, :id => id}
        end
      end
    end
    
    respond_to do |format|
      format.json { render :json => @everything, :callback => params[:callback] }
    end
  end
  
  def org_chart
    if params[:format] == "csv"
      @people = Person.all
    else
      @roots = Ou.top_level
    end

    respond_to do |format|
      format.xml
      format.json
      format.csv { render :csv => @roots }
    end
  end
  
  # Returns JSON against param 'q' to search against loginids
  def loginid
    @people = Person.where("loginid like ?", "%#{params[:q]}%")
    @loginids = @people.map{ |x| x.loginid }
    
    respond_to do |format|
      format.json { render :json => @loginids }
    end
  end
  
  # Returns JSON against param 'q' to search against titles
  def title
    @ts = Title.where("name like ?", "%#{params[:q]}%")
    @titles = @ts.map{ |x| x.name }
    
    respond_to do |format|
      format.json { render :json => @titles }
    end
  end
  
  # Returns JSON against param 'q' to search against majors
  def major
    respond_to do |format|
      format.json { render :json => [] }
    end
  end
  
  # Returns JSON against param 'q' to search against affiliations
  def affiliation
    @as = Affiliation.where("name like ?", "%#{params[:q]}%")
    @affiliations = @as.map{ |x| x.name }
    
    respond_to do |format|
      format.json { render :json => @affiliations }
    end
  end
  
  # Returns JSON against param 'q' to search against classifications
  def classification
    @cs = Classification.where("name like ?", "%#{params[:q]}%")
    @classifications = @cs.map{ |x| x.name }
    
    respond_to do |format|
      format.json { render :json => @classifications }
    end
  end
  
  # Returns JSON against param 'q' to search against ous
  def ou
    @os = Ou.where("name like ?", "%#{params[:q]}%")
    @ous = @os.map{ |x| x.name }
    
    respond_to do |format|
      format.json { render :json => @ous }
    end
  end
end
