# TODO: There's an awful lot of controller logic in this view

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
  requestable_apps = []
  
  # Build the explicit person roles (roles assigned directly to them)
  @person.roles.each do |role|
    roles << [role.name, role.application.name]
    apps << [role.application.name, role.application.hostname, role.application.display_name, role.application.id]
  end
  # Add the roles assigned to them via OU defaults
  @person.ous.each do |ou|
    ou.applications.each do |application|
      application.roles.where(:default => true).each do |role|
        # Ensure there are no duplicates
        unless roles.include? [role.name, role.application.name]
          roles << [role.name, role.application.name]
        end
        unless apps.include? [role.application.name, role.application.hostname, role.application.display_name, role.application.id]
          apps << [role.application.name, role.application.hostname, role.application.display_name, role.application.id]
        end
      end
    end
  end
  # Add the roles assigned to them via public defaults
  Role.includes(:application).where( :default => true ).each do |role|
    # Avoid duplicates
    unless roles.include? [role.name, role.application.name]
      roles << [role.name, role.application.name]
    end
    unless apps.include? [role.application.name, role.application.hostname, role.application.display_name, role.application.id]
      apps << [role.application.name, role.application.hostname, role.application.display_name, role.application.id]
    end
  end
  
  # Get a list of all publicly available apps and filter it to apps they do not have
  # This queries for all applications that have an empty .ous, implying they are publicly available
  Application.includes(:application_ou_assignments).where( :application_ou_assignments => { :application_id => nil } ).each do |application|
    unless apps.include? [application.name, application.hostname, application.display_name, application.id]
      # App is publicly available and not already in their list
      requestable_apps << [application.name, application.hostname, application.display_name, application.id]
    end
  end
  # Add to that the list of applications available to their OUs but to which they have no roles
  @person.ous.each do |ou|
    ou.applications.each do |application|
      application.roles.where(:default => false).each do |role|
        unless apps.include? [application.name, application.hostname, application.display_name, application.id]
          requestable_apps << [application.name, application.hostname, application.display_name, application.id]
        end
      end
    end
  end

  # Output the results
  xml.roles("type"=>"array") do
    roles.each do |role|
      xml.role do
        xml.name role[0]
        xml.app role[1]
      end
    end
  end
  xml.apps("type"=>"array") do
    apps.each do |app|
      xml.app do
        xml.name app[0]
        xml.url app[1]
        xml.tag! "display_name", app[2]
      end
    end
  end
  
  if requestable_apps.length > 0
    xml.requestable_apps("type" => "array") do
      requestable_apps.each do |app|
        xml.requestable_app do
          xml.name app[0]
          xml.url app[1]
          xml.tag! "display_name", app[2]
        end
      end
    end
  end
end
