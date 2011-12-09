xml.instruct!

xml.person do
  xml.id '1' + @person.id.to_s
  xml.first @person.first
  xml.last @person.last
  xml.preferred @person.preferred_name
  xml.email @person.email
  xml.phone @person.phone
  xml.address @person.address
  xml.loginid @person.loginid

  # Output the results
  xml.roles("type"=>"array") do
    @person.roles.each do |role|
      xml.role do
        xml.name role.name
        xml.app role.application.name
      end
    end
  end
  xml.apps("type"=>"array") do
    @person.applications.each do |app|
      xml.app do
        xml.name app.name
        xml.url app.hostname
        xml.tag! "display_name", app.display_name
        xml.icon app.icon.url(:normal)
        xml.tiny_icon app.icon.url(:tiny)
      end
    end
  end
  
  xml.groups("type" => "array") do
    @person.groups.each do |group|
      xml.group do
        xml.id "2" + group.id.to_s # leading digit of 2 is UID for type group, see README
        xml.name group.name
      end
    end
  end
  
  xml.ous("type" => "array") do
    @person.ous.each do |ou|
      xml.ou do
        xml.id "3" + ou.id.to_s # leading digit of 3 is UID for type OU, see README
        xml.name ou.name
      end
    end
  end
  
  if @person.requestable_applications.length > 0
    xml.requestable_apps("type" => "array") do
      @person.requestable_applications.each do |app|
        xml.requestable_app do
          xml.name app.name
          xml.url app.hostname
          xml.tag! "display_name", app.display_name
          xml.icon app.icon.url(:normal)
          xml.tiny_icon app.icon.url(:tiny)
        end
      end
    end
  end
end
