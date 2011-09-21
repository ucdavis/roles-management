xml.instruct!

xml.clusters("type"=>"array") do
  @roots.each do |root|
    xml.cluster do
      xml.name root.name
      xml.code root.code
      xml.departments("type"=>"array") do
        root.children.each do |child|
          xml.department do
            xml.name child.name
            xml.code child.code
            xml.people("type"=>"array") do
              child.members.each do |person|
                xml.person do
                  xml.name person.name
                  xml.loginid person.loginid
                  xml.affiliations("type"=>"array") do
                    person.affiliations.each do |affiliation|
                      xml.affiliation do
                        xml.name affiliation.name
                      end # affiliation
                    end
                  end # affiliations 
                end # person
              end
            end # people
          end # department
        end
      end # departments
      
      xml.people("type" => "array") do
        root.members.each do |person|
          xml.person do
            xml.name person.name
            xml.loginid person.loginid
            xml.affiliations("type"=>"array") do
              person.affiliations.each do |affiliation|
                xml.affiliation do
                  xml.name affiliation.name
                end # affiliation
              end
            end # affiliations 
          end # person          
        end
      end # people
      
    end
  end
end
