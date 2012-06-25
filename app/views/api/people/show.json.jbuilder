json.uid @person.uid
json.name @person.name
json.email @person.email
# If they authenticated via the API key (and not CAS), show only the roles associated
# with that application's API key
if session[:current_application]
  json.roles @person.roles_by_application(session[:current_application].id)
end
