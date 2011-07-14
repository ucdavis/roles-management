class SiteController < ApplicationController
  include ApplicationHelper
  
  def index
    @user = current_user
    
    
  end

  def contact
  end
  
  def logout
    CASClient::Frameworks::Rails::Filter.logout(self)
  end
end
