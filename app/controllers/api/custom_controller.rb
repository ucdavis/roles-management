class Api::CustomController < Api::BaseController
  def search
    @people = Person.where("first like ? or last like ?", "%#{params[:q]}%", "%#{params[:q]}%")
    @groups = Group.where("name like ?", "%#{params[:q]}%")
    @ous = Ou.where("name like ?", "%#{params[:q]}%")
    
    # Return everything (in the search query)
    @everything = []
    
    @people.each do |person|
      @everything << {:id => person.id, :name => person.first + ' ' + person.last, :type => 'p'}
    end
    @groups.each do |group|
      @everything << {:id => group.id, :name => group.name, :type => 'g' }
    end
    @ous.each do |ou|
      @everything << {:id => ou.id, :name => ou.name, :type => 'o'}
    end

    @everything.map()

    respond_to do |format|
      format.xml
      format.json { render :json => @everything, :callback => params[:callback] }
    end
  end
end
