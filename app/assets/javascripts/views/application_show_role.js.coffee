DssRm.Views.ApplicationShowRole = Backbone.View.extend(
  tagName: "tr"
  className: "fields"
  events:
    'blur input[name=name]': 'autofillEmptyToken'
    'click #plainText'     : 'exportPlainText'
    'click #syncAD'        : 'syncAD'

  render: ->
    @$el.html JST["applications/show_role"](role: @model)
    @$("input[name=token]").val @model.escape("token")
    
    # If this is a new role, we will attempt to automatically generate a token
    @$("input[name=token]").data "autofill", true  if @model.escape("token").length is 0
    @$("input[name=name]").val @model.escape("name")
    @$("input[name=description]").val @model.escape("description")
    @$el.data "role_id", @model.escape("id")

    @

  autofillEmptyToken: (e) ->
    roleName = $(e.target).val()
    $tokenInput = $(e.target).parents("tr").find("input[name=token]")
    if $tokenInput.data("autofill")
      $tokenInput.val @model.tokenize(roleName)
      $tokenInput.trigger "change"
    true
  
  exportPlainText: (e) ->
    role_id = $(e.target).parents("tr").data("role_id")
    url = window.location.protocol + "//" + window.location.hostname + Routes.role_path(role_id, {format: 'txt'})
    window.open url
    #window.prompt "Copy to clipboard: Ctrl+C, Enter", url
  
  syncAD: (e) ->
    status_bar.show "Role sync queued in the background. Expect results in a minute or two.", 'default', 4500
    
    $.ajax
      url: Routes.role_sync_path(@model.get('id'))
      type: 'GET'
)
