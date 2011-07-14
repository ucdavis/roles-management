class SiteController < ApplicationController
  include ApplicationHelper
  
  def index
    @user = current_user
    
    @people = Person.includes(:groups).where("groups.id in (?)", @user.groups)
  end

  def contact
  end
  
  def logout
    CASClient::Frameworks::Rails::Filter.logout(self)
  end
end
