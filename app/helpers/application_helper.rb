module ApplicationHelper
  include Authentication

  def _has_role?(role)
    unless current_user == :cas_user_not_in_database
      if impersonating?
        # We assume anybody impersonating is an admin and has every role anyway ...
        yield if block_given?
      else
        yield if has_role?(role)
      end
    end
  end

  # Produces a link_to, adjusting CSS class if link is to current controller
  def li_link_with_class(options)
    title = options[:title]
    options.delete(:title) # to avoid being used by link_to
    if options[:controller] == controller_name and options[:action] == action_name
      ('<li class="active">' + link_to(title, options) + '</li>').html_safe
    else
      ('<li>' + link_to(title, options) + '</li>').html_safe
    end
  end
end
