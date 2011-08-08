class SiteController < ApplicationController
  include ApplicationHelper
  
  def index
    @user = current_user
    
    raise "User could not be found" unless @user.nil? == false
  end

  def contact
  end
  
  def logout
    CASClient::Frameworks::Rails::Filter.logout(self)
  end
end
