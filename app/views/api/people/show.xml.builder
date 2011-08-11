xml.instruct!

xml.person do
  xml.first @person.first
  xml.last @person.last
  xml.email @person.email
  xml.phone @person.phone
  xml.address @person.address
  xml.loginid @person.loginid

  # Build a list of apps from roles (simpler than another query)
  apps = []

  xml.roles do
    @person.roles.each do |role|
      xml.role do
        xml.name role.name
        xml.app role.application.name
        apps << [role.application.name, role.application.hostname]
      end
    end
  end
  xml.apps do
    apps.each do |app|
      xml.app do
        xml.name app[0]
        xml.url app[1]
      end
    end
  end
end
