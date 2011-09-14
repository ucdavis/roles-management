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
                    person.groups.each do |affiliation|
                      xml.affiliation do
                        xml.name affiliation.name
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
