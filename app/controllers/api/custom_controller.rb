class Api::CustomController < Api::BaseController
  def search
    @people = Person.where("first like ? or last like ?", "%#{params[:q]}%", "%#{params[:q]}%")
    @groups = Group.where("name like ?", "%#{params[:q]}%")
    @ous = Ou.where("name like ?", "%#{params[:q]}%")
    
    # Return everything (in the search query)
    @everything = []
    
    @people.each do |person|
      @everything << {:type => 'p', :id => person.id, :name => person.first + ' ' + person.last}
    end
    @groups.each do |group|
      @everything << {:type => 'g', :id => group.id, :name => group.name}
    end
    @ous.each do |ou|
      @everything << {:type => 'o', :id => ou.id, :name => ou.name}
    end

    @everything.map()

    respond_to do |format|
      format.xml
      format.json { render :json => @everything }
    end
  end
end
