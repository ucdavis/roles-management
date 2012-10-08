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

  def _permitted_to?(action_name, controller_name)
    unless current_user == :cas_user_not_in_database
      if impersonating?
        # We assume anybody impersonating is an admin and has every role anyway ...
        yield if block_given?
        return true
      else
        if permitted_to?(action_name, controller_name)
          yield if block_given?
          return true
        end
      end
    end

    return false
  end

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
    if current_page?(options)
      ('<li class="active">' + link_to(title, options) + '</li>').html_safe
    else
      ('<li>' + link_to(title, options) + '</li>').html_safe
    end
  end
end
