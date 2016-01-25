class EnsureAllApplicationsHaveDefaultAccessRole < ActiveRecord::Migration
  def up
    #@applications = Application.all
    #@applications.each do |app|
    #  has_access_role = false
    #  
    #  app.roles.each do |role|
    #    if role.token == "access"
    #      has_access_role = true
    #      role.mandatory = true
    #      role.save!
    #    end
    #  end
    #  
    #  if has_access_role == false
    #    r = Role.new
    #    r.token = "access"
    #    r.default = false
    #    r.mandatory = true
    #    r.descriptor = "Access"
    #    r.description = "Allow access to this application"
    #    app.roles << r
    #    app.save!
    #  end
    #end
  end

  def down
    logger.warn "Down migrations not supported for dropping default access tokens."
  end
end
