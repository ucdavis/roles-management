class Api::CustomController < Api::BaseController
  def search
    @people = Person.where("first like ? or last like ?", "%#{params[:q]}%", "%#{params[:q]}%")
    @groups = Group.where("name like ?", "%#{params[:q]}%")
    @ous = Ou.where("name like ?", "%#{params[:q]}%")
    
    # Return everything (in the search query)
    @everything = []
    
    @people.each do |person|
      @everything << ['p', person.id, person.first + ' ' + person.last]
    end
    @groups.each do |group|
      @everything << ['g', group.id, group.name]
    end
    @ous.each do |ou|
      @everything << ['o', ou.id, ou.name]
    end

    @everything.map()

    respond_to do |format|
      format.xml
      format.json { render :json => @everything }
    end
  end
end
