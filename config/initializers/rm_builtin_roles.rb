# The 'built-in' RM roles must exist for proper functionality.
# Check for existence and store them in RM_ROLES (used in person.rb)

application = Application.includes(:roles).find_by_name("DSS Roles Management")

if application
  RM_ROLES = application.roles
  RM_ROLES_IDS = RM_ROLES.map{ |r| r.id }
else
  # This initializer runs before fixtures are loaded in test
  # so we'll just assume the fixtures are correct (includes application called 'DSS Roles Management' with 'access' and 'admin' roles)
  unless Rails.env == "test"
    puts "WARNING: Built-in RM roles are not set up. The application will not run currently."
    puts "         Run rake db:seed to ensure built-in roles exist."
  end
end
