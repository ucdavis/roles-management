module ApplicationHelper
  include Authentication
  
  def current_controller?(options)
    options[:controller] == controller_name
  end
  
  def current_action?(options)
    options[:action] == action_name
  end
  
  def current_page?(options)
    options[:controller] == controller_name and options[:action] == action_name
  end
  
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", :class => "edit_mode")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    content_tag("button", name, {:type => "submit", :class => "btn", :onclick => "add_fields(this, '#{association}', '#{escape_javascript(fields)}')"})
  end
  
  def allowed_to?(action, controller)
    permitted_to?(action, controller) #unless impersonating? == true
  end
  
  # Produces a link_to, adjusting CSS class if link is to current controller
  def li_link_with_class(options)
    title = options[:title]
    options.delete(:title) # to avoid being used by link_to
    if current_page?(options)
      ('<li class="active">' + link_to(title, options) + '</li>').html_safe
    else
      ('<li>' + link_to(title, options) + '</li>').html_safe
    end
  end
end
