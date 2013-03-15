DssRm.Views.WhitelistDialog = Backbone.View.extend(
  tagName: "div"
  className: "modal"
  id: "whitelistDialogModal"
  events:
    "hidden": "cleanUpModal"
    "submit #new-address": "newAddress"
    "click a#remove_ip": "removeAddress"

  initialize: (options) ->
    @$el.html JST["application/whitelist_dialog"]()
    @whitelist = options.whitelist
    @whitelist.on "sync remove", @render, this

  render: ->
    self = this
    @$("tbody").empty()
    @whitelist.each (ip) ->
      row = $("<tr><td>" + ip.escape("address") + "</td><td>" + ip.escape("reason") + "</td><td><a href=\"#\" id=\"remove_ip\">Remove</a></td></tr>")
      $(row).data "ip_id", ip.get("id")
      self.$("tbody").append row

    this

  newAddress: (e) ->
    self = this
    new_address = $(e.currentTarget).find("input[name=address]").val()
    new_reason = $(e.currentTarget).find("input[name=reason]").val()
    @$("form#new-address input[name=address]").val "" # clear the input
    @$("form#new-address input[name=reason]").val ""
    @whitelist.create
      address: new_address
      reason: new_reason

    false

  removeAddress: (e) ->
    ip_id = $(e.currentTarget).parents("tr").data("ip_id")
    model = @whitelist.get(ip_id)
    model.destroy()
    @whitelist.remove model
    false

  cleanUpModal: ->
    @remove
    
    # Need to change URL in case they want to open the same modal again
    Backbone.history.navigate ""
)