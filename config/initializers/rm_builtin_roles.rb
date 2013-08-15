# The 'built-in' RM roles must exist for proper functionality.
# Check for existence and store them in RM_ROLES (used in person.rb)

application = Application.includes(:roles).find_by_name("DSS Roles Management")

if application
	RM_ROLES = application.roles
else
	puts "You must set up the built-in RM roles before application can start."
	exit
end

