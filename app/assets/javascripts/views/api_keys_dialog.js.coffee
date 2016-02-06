DssRm.Views.ApiKeysDialog = Backbone.View.extend(
  tagName: "div"
  className: "modal"
  id: "apiKeysDialogModal"
  events:
    "hidden": "cleanUpModal"
    "submit #new-key": "newApiKey"
    "click a#delete-key": "removeApiKey"

  initialize: (options) ->
    @$el.html JST["templates/application/api_keys_dialog"]()
    @api_keys = options.api_keys
    @listenTo @api_keys, "sync remove", @render

  render: ->
    @$("tbody").empty()
    @api_keys.each (key) =>
      row = $("<tr><td>" + key.escape("name") + "</td><td>" + key.escape("secret") + "</td><td>" + key.escape("logged_in_at") + "</td><td><a href=\"#\" id=\"delete-key\">Remove</a></td></tr>")
      $(row).data "key-id", key.escape("id")
      @$("tbody").append row

    @

  newApiKey: (e) ->
    name = $(e.currentTarget).find("input[name=name]").val()
    @$("form#new-key input[name=name]").val "" # clear the input
    toastr["info"]("Creating API key ...")
    @api_keys.create
      name: name
    ,
      success: () ->
        toastr.remove()
        toastr["success"]("API key created.")
      error: () ->
        toastr.remove()
        toastr["error"]("Unable to create API key. Try again later.")      
    false

  removeApiKey: (e) ->
    key_id = $(e.currentTarget).parents("tr").data("key-id")
    model = @api_keys.get(key_id)
    toastr["info"]("Removing API key ...")
    model.destroy
      success: () ->
        toastr.remove()
        toastr["success"]("API key removed.")
      error: () ->
        toastr.remove()
        toastr["error"]("Unable to remove API key. Try again later.")
    @api_keys.remove model
    false

  cleanUpModal: ->
    @remove()
    
    # Need to change URL in case they want to open the same modal again
    Backbone.history.navigate "index"
)