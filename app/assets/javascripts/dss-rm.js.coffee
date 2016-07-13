# Initialize the Toastr
toastr.options =
  "closeButton": false
  "debug": false
  "newestOnTop": false
  "progressBar": false
  "positionClass": "toast-bottom-center"
  "preventDuplicates": false
  "onclick": null
  "showDuration": "300"
  "hideDuration": "1000"
  "timeOut": "5000"
  "extendedTimeOut": "1000"
  "showEasing": "swing"
  "hideEasing": "linear"
  "showMethod": "fadeIn"
  "hideMethod": "fadeOut"

window.DssRm =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  initialize: (data) ->
    @applications = new DssRm.Collections.Applications data.applications

    @current_user = new DssRm.Models.Entity data.current_user
    @current_user.set 'admin', data.current_user_admin
    @current_user.set 'operator', data.current_user_operator

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
      class_attr = $(e.target).attr('class')
      if class_attr and class_attr.indexOf("modal") != -1
        $("body").css('overflow', 'hidden')
    $("body").on "hidden", (e) ->
      class_attr = $(e.target).attr('class')
      if class_attr and class_attr.indexOf("modal") != -1
        $("body").css('overflow', 'visible')

  admin_logged_in: ->
    DssRm.current_user.get 'admin'

  operator_logged_in: ->
    DssRm.current_user.get 'operator'
