window.DssRm =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  
  initialize: (data) ->
    @applications = new DssRm.Collections.Applications data.applications

    @current_user = new DssRm.Models.Entity data.current_user
    @current_user.set 'admin', data.current_user_admin 
    
    # Create a view state to be shared amongst all views
    @view_state = new DssRm.Models.ViewState()
    
    @router = new DssRm.Routers.Applications()
    
    unless Backbone.history.started
      Backbone.history.start()
      Backbone.history.started = true
    
    # Enable tooltips globally
    $("body").tooltip
      selector: '[rel=tooltip]'
    
    # Prevent body scrolling when modal is open
    $("body").on "shown", (e) ->
      if $(e.target).attr('class').indexOf("modal") != -1
        $("body").css('overflow', 'hidden')
    $("body").on "hidden", (e) ->
      if $(e.target).attr('class').indexOf("modal") != -1
        $("body").css('overflow', 'visible')
  
  admin_logged_in: ->
    DssRm.current_user.get 'admin'
