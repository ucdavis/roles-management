# TODO: There's some controller logic in this view

xml.instruct!

xml.tag! @person.loginid + "-" + @application.name.downcase.gsub!(' ', '_') + "-roles" do
  xml.name @application.name

  xml.roles("type"=>"array") do
    @roles.each do |role|
      xml.role do
        xml.name role.name
      end
    end
  end
end
