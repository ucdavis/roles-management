xml.instruct!

xml.org("type"=>"array") do
  @roots.each do |root|
    xml.cluster do
      xml.name root.name
      xml.code root.code
      root.children.each do |child|
        xml.department do
          xml.name child.name
          xml.code child.code
          child.members.each do |person|
            xml.person do
              xml.name person.name
              xml.loginid person.loginid
            end
          end
        end
      end
    end
  end
end
