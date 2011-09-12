module ApplicationHelper
  def current_controller?(options)
      options[:controller] == controller_name
  end
  
  def current_user
    Person.find_by_loginid(session[:cas_user])
  end
end
