xml.instruct!

xml.person do
  xml.first @person.first
  xml.last @person.last
  xml.preferred @person.preferred_name
  xml.email @person.email
  xml.phone @person.phone
  xml.address @person.address
  xml.loginid @person.loginid

  # Build a list of apps and roles (simpler than another query)
  apps = []
  roles = []
  
  # Build the explicit person roles (roles assigned directly to them)
  @person.roles.each do |role|
    roles << [role.name, role.application.name]
    apps << [role.application.name, role.application.hostname, role.application.display_name]
  end
  # Add the roles assigned to them via OU defaults
  @person.ous.each do |ou|
    ou.applications.each do |application|
      application.roles.where(:default => true).each do |role|
        roles << [role.name, role.application.name]
        apps << [role.application.name, role.application.hostname, role.application.display_name]
      end
    end
  end

  # Output the results
  xml.roles do
    roles.each do |role|
      xml.role do
        xml.name role[0]
        xml.app role[1]
      end
    end
  end
  xml.apps do
    apps.each do |app|
      xml.app do
        xml.name app[0]
        xml.url app[1]
        xml.tag! "display_name", app[2]
      end
    end
  end
end
