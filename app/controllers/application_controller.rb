class ApplicationController < ActionController::Base
  protect_from_forgery
  
  #before_filter CASClient::Frameworks::Rails::Filter
  
  #@@user = Person.find_by_loginid(session[:cas_user])
end
