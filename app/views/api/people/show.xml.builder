xml.instruct!

xml.person do
  xml.id '1' + @person.id.to_s
  xml.first @person.first
  xml.last @person.last
  xml.name @person.name
  xml.email @person.email
  xml.phone @person.phone
  xml.address @person.address
  xml.loginid @person.loginid

  # Output the results
  xml.roles("type"=>"array") do
    @person.roles.each do |role|
      xml.role do
        xml.token role.token
        xml.app role.application.name
      end
    end
  end
  xml.apps("type"=>"array") do
    @person.applications.each do |app|
      xml.app do
        xml.name app.name
        xml.url app.hostname
      end
    end
  end

  xml.group_memberships("type" => "array") do
    @person.group_memberships.each do |group|
      xml.group do
        xml.id group.id
        xml.name group.name
      end
    end
  end

  xml.ous("type" => "array") do
    @person.ous.each do |ou|
      xml.ou do
        xml.id ou.id
        xml.name ou.name
      end
    end
  end
end
