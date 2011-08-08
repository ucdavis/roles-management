class SiteController < ApplicationController
  include ApplicationHelper
  
  def index
    @user = current_user
    
    raise "User could not be found. Ensure user is in the database and that initial user population has taken place." unless @user.nil? == false
  end

  def contact
  end
  
  def logout
    CASClient::Frameworks::Rails::Filter.logout(self)
  end
end
