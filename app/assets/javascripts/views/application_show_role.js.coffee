DssRm.Views.ApplicationShowRole = Backbone.View.extend(
  tagName: "tr"
  className: "fields"
  events:
    "blur input[name=name]": "autofillEmptyToken"

  render: ->
    @$el.html JST["applications/show_role"](role: @model)
    @$("input[name=token]").val @model.escape("token")
    
    # If this is a new role, we will attempt to automatically generate a token
    @$("input[name=token]").data "autofill", true  if @model.escape("token").length is 0
    @$("input[name=name]").val @model.escape("name")
    @$("input[name=description]").val @model.escape("description")
    @$el.data "role_id", @model.escape("id")

    this

  autofillEmptyToken: (e) ->
    roleName = $(e.target).val()
    $tokenInput = $(e.target).parents("tr").find("input[name=token]")
    if $tokenInput.data("autofill")
      $tokenInput.val @model.tokenize(roleName)
      $tokenInput.trigger "change"

    true
)
