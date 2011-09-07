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
end
