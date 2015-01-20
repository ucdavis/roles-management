DssRm.Views.ApplicationShowRole = Backbone.View.extend(
  tagName: "tr"
  className: "fields"
  events:
    'blur input[name=name]' : 'autofillEmptyToken'
    'click #plainText'      : 'exportPlainText'
    'keyup input'           : 'setRoleValue'

  render: ->
    @$el.html JST["templates/applications/show_role"](role: @model)
    @$("input[name=token]").val @model.escape("token")

    # If this is a new role, we will attempt to automatically generate a token
    @$("input[name=token]").data("autofill", true) if @model.escape('token').length is 0
    @$("input[name=name]").val @model.get("name")
    @$("input[name=description]").val @model.get("description")
    @$el.data "role_cid", @model.cid

    @

  setRoleValue: (e) ->
    input_name = $(e.target).attr('name')
    input_value = $(e.target).val()
    @model.set(input_name, input_value)

  autofillEmptyToken: (e) ->
    roleName = $(e.target).val()
    $tokenInput = $(e.target).parents("tr").find("input[name=token]")
    if $tokenInput.data("autofill")
      $tokenInput.val @model.tokenize(roleName)
      $tokenInput.trigger "change"
    true

  exportPlainText: (e) ->
    role_id = @model.get('id')
    url = window.location.protocol + "//" + window.location.hostname + Routes.role_path(role_id, {format: 'txt'})
    window.open url
)
