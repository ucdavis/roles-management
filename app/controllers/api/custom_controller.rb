class Api::CustomController < Api::BaseController
  def search
    @results = []

    unless params[:q].nil?
      adapter = ActiveRecord::Base.connection.instance_values["config"][:adapter].to_sym
      
      case adapter
      when :sqlite3
        @people = Person.where("first like ? or last like ? or " + db_concat(:first, ' ', :last) + " like ?", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%")
        @groups = Group.where("name like ?", "%#{params[:q]}%")
      else
        @people = Person.where("first ilike ? or last ilike ? or " + db_concat(:first, ' ', :last) + " ilike ?", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%")
        @groups = Group.where("name ilike ?", "%#{params[:q]}%")
      end
    
      @people.each do |person|
        @results << {:uid => ('1' + person.id.to_s).to_i, :name => person.first + ' ' + person.last }
      end
      @groups.each do |group|
        @results << {:uid => ('2' + group.id.to_s).to_i, :name => group.name }
      end

      @results.map()
    end

    respond_to do |format|
      format.json { render :json => @results, :callback => params[:callback] }
    end
  end

  # Use resolve sparingly - it's not optimized for speed currently (FIXME, TESTME, CLEANME)
  # Add &email to receive email addresses - implies &flatten as groups and OUs have no emails
  # Add &flatten to flatten groups and OUs into their people
  def resolve
    @entities = []
    
    unless params[:uids].nil?
      uids = params[:uids].split(",")
      flatten = params.has_key? :flatten
    
      uids.each do |uid|
        id = uid[1..-1] # remove leading integer (indicates which object, see README Technical Notes)
        case uid.first.to_i
        when 1
          p = Person.find_by_id(id)
          unless p.nil?
            @entities << {:name => p.first + ' ' + p.last, :uid => uid, :email => p.email}
          end
        when 2
          g = Group.find_by_id(id)
          unless g.nil?
            if flatten
              g.people.each do |person|
                @entities << {:name => person.first + ' ' + person.last, :uid => '1' + person.id.to_s, :email => person.email}
              end
            else
              @entities << {:name => g.name, :uid => uid}
            end
          end
        end
      end
    end
    
    respond_to do |format|
      format.json { render :json => @entities, :callback => params[:callback] }
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
  
  # Returns JSON against param 'q' to search against ous
  def ou
    @os = Ou.where("name like ?", "%#{params[:q]}%")
    @ous = @os.map{ |x| x.name }
    
    respond_to do |format|
      format.json { render :json => @ous }
    end
  end
end
