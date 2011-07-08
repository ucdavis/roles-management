class SiteController < ApplicationController
  def index
  end

  def contact
  end
  
  def logout
    CASClient::Frameworks::Rails::Filter.logout(self)
  end
end
