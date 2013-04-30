# jQuery.readonly is a simple plugin to toggle forms from being "read-only" in function and appearance
# to regular forms. This is useful if you want administrators to edit a form but regular visitors merely
# need to see the form without boxes, selections, etc.

$ = jQuery

# Add plugin object to jQuery
$.fn.extend
  readonly: (options) ->
    # Default settings
    settings =
      debug: false

    # Merge default settings with options.
    settings = $.extend settings, options

    # Simple logger.
    log = (msg) ->
      console?.log msg if settings.debug

    # _Insert magic here._
    return @each ()->
      #log "Option 1 value: #{settings.debug}"
      