class SiteController < ApplicationController
  include ApplicationHelper
  
  def index
    @user = current_user
    
    @people = Person.includes(:groups).where("groups.id in (?)", @user.groups)
    
    @roles = Role.find(:all)
  end

  def contact
  end
  
  def logout
    CASClient::Frameworks::Rails::Filter.logout(self)
  end
end
