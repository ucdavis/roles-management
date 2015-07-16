# jQuery.readonly is a simple plugin to toggle forms from being "read-only" in function and appearance
# to regular forms. This is useful if you want administrators to edit a form but regular visitors merely
# need to see the form without boxes, selections, etc.

# This plugin could be genericized for others to use but makes a few assumptions about what a "read-only form"
# is supposed to look like.

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
    return @each () ->
      $(@).attr('disabled', 'disabled')
      $(@).css('border', 'none')
      $(@).css('box-shadow', 'none')
      $(@).css('cursor', 'auto')
      $(@).css('background-color', 'transparent')
      $(@).css('color', '#000')
      $(@).find('.token-input-delete-token-facebook').hide()
      $(@).css('resize', 'none')
