# Ensures application "DSS Roles Management" exists by the following:
#   * Renames "DSS Rights Management" to "DSS Roles Management"
#   * If that fails, creates the application (if it doesn't already exist)
class EnsureApplicationNamedDssRolesManagementExists < ActiveRecord::Migration
  def up
    if Application.find_by_name("DSS Roles Management").nil?
      # It's missing ...

      Authorization.ignore_access_control(true)

      rm = Application.find_by_name("DSS Rights Management")
      if rm.nil?
        # "DSS Rights Management" doesn't exist either, so create a new application
        a = Application.new
        a.name = "DSS Roles Management"
        a.description = "Create and edit groups and permissions."
        a.save

        r = Role.new
        r.token = "access"
        r.descriptor = "Access"
        r.description = "Allows the user to access this application."
        r.application = a
        r.save
      else
        # "DSS Rights Management" exists, so simply rename it
        rm.name = "DSS Roles Management"
        rm.save
      end

      Authorization.ignore_access_control(false)
    end
  end

  def down
    puts "This migration is not reversible."
  end
end
