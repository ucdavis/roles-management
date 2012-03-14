module GroupsHelper
  # Adds a "class" attribute to the JSON array used for CSS classes with jquery-tokeninput
  def add_class_attr_to_group_json(json)
    parsed_json = ActiveSupport::JSON.decode(json)
    parsed_json.each do |p|
      if p["via"] == "explicit"
        p["token_class"] = "token-explicit"
      elsif p["via"] == "resolved"
        p["token_class"] = "token-resolved"
      end
    end
    
    ActiveSupport::JSON.encode(parsed_json)
  end
end
