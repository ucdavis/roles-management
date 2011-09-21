class SiteController < ApplicationController
  include ApplicationHelper
  
  def index
  end

  def contact
  end
  
  def access_denied
  end
  
  def logout
    CASClient::Frameworks::Rails::Filter.logout(self)
  end
end
