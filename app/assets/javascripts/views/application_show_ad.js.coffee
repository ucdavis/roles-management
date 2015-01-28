DssRm.Views.ApplicationShowAD = Backbone.View.extend(
  tagName: "span"
  # events:
  #   "keyup input[name=ad_path]": "adPathCheck"

  initialize: ->
    @lastAdCheck = new Date().getTime();
    @AD_CHECK_DELAY = 1500 # ms
    @timer = null

  render: ->
    @$el.html JST["templates/applications/show_ad"](role: @model)
    @$("label").html @model.escape("name")
    @$("input[name=ad_path]").val @model.escape("ad_path")
    @$("input[name=ad_path]").data "role-id", @model.id

    @

  # adPathCheck: (e) ->
  #   current_ts = new Date().getTime()
  #   typed = @$('input[name=ad_path]').val()
  #
  #   if typed == ""
  #     @$('i').hide()
  #     return
  #
  #   @$('i').show()
  #
  #   if current_ts > @lastAdCheck + @AD_CHECK_DELAY
  #     @lastAdCheck = current_ts
  #     if @timer
  #       clearTimeout(@timer)
  #       @timer = null
  #
  #     # Indicate a wait
  #     @$('i').removeClass()
  #     @$('i').addClass('icon-repeat')
  #
  #     # $.get Routes.admin_ad_path_check_path() + "?path=" + typed, (ret) =>
  #     #   if ret.exists
  #     #     @$('i').removeClass()
  #     #     @$('i').addClass('icon-ok')
  #     #   else
  #     #     @$('i').removeClass()
  #     #     @$('i').addClass('icon-remove')
  #   else
  #     # Too short of a wait
  #     # Indicate a wait
  #     @$('i').removeClass()
  #     @$('i').addClass('icon-repeat')
  #
  #     unless @timer
  #       @timer = setTimeout( =>
  #         @adPathCheck()
  #       , @AD_CHECK_DELAY)
)
