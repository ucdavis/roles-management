class Api::CustomController < Api::BaseController
  # Searches for all users and groups visible to current_user
  # (This is all people and only groups owned or operated by current_user)
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

      if authenticated_via? :cas_user
        visible_uids = current_user.manageable_uids.map{ |x| x[:uid] }
      else
        visible_uids = nil
      end

      @people.each do |person|
        @results << {:uid => (UID_PERSON_S + person.id.to_s).to_i, :name => person.first + ' ' + person.last }
      end
      @groups.each do |group|
        g = {:uid => (UID_GROUP_S + group.id.to_s).to_i, :name => group.name }
        if visible_uids
          # If visible_uids exists, it means a user (as opposed to an application) is performing a search.
          # We need to filter the results in this case.
          if visible_uids.include? g[:uid]
            @results << g
          end
        else
          @results << g
        end
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
      include_applications = params.has_key? :applications

      uids.each do |uid|
        id = uid[1..-1] # remove leading integer (indicates which object, see README Technical Notes)
        case uid.first.to_i
        when 1
          p = Person.find_by_id(id)
          unless p.nil?
            p_entity = {:name => p.first + ' ' + p.last, :uid => uid, :email => p.email}
            include_applications ? p_entity.merge!({:applications => p.applications}) : nil
            @entities << p_entity
          end
        when 2
          g = Group.find_by_id(id)
          unless g.nil?
            if flatten
              g.people.each do |person|
                p_entity = {:name => person.first + ' ' + person.last, :uid => UID_PERSON_S + person.id.to_s, :email => person.email}
                include_applications ? p_entity.merge!({:applications => person.applications}) : nil
                @entities << p_entity
              end
            else
              g_entity = {:name => g.name, :uid => uid}
              include_applications ? g_entity.merge!({:applications => g.applications}) : nil
              @entities << g_entity
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
    @majors = Major.where("name like ?", "%#{params[:q]}%")
    #@majors = @majors.map{ |x| x.name }

    respond_to do |format|
      format.json { render :json => @majors }
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
