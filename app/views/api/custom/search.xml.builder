xml.instruct!

xml.results("type"=>"array") do
  @everything.each do |thing|
    xml.result do
      xml.type thing[0]
      xml.id thing[1]
      xml.name thing[2]
    end
  end
end
