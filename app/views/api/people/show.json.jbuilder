json.uid @person.uid
json.name @person.name
json.roles @person.roles_by_application(session[:current_application].id)
