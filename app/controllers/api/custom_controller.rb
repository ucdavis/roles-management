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

  # Use resolve sparingly - it's not optimized for speed currently (FIXME, TESTME)
  def resolve
    ids = params[:ids].split(",")
    
    @everything = []
    
    ids.each do |id|
      stripped_id = id[1..-1] # remove leading integer (indicates which object, see README Technical Notes)
      case id.first.to_i
      when 1
        p = Person.find_by_id(stripped_id)
        @everything << {:email => p.email, :name => p.first + ' ' + p.last}
      when 2
        g = Group.find_by_id(stripped_id)
        g.people.each do |p|
          @everything << {:email => p.email, :name => p.first + ' ' + p.last}
        end
      when 3
        o = Ou.find_by_id(stripped_id)
        o.members.each do |p|
          @everything << {:email => p.email, :name => p.first + ' ' + p.last}
        end
        o.managers.each do |p|
          @everything << {:email => p.email, :name => p.first + ' ' + p.last}
        end
      end
    end
    
    respond_to do |format|
      format.json { render :json => @everything, :callback => params[:callback] }
    end
  end
end
