DssRm.Views.WhitelistDialog = Support.CompositeView.extend({
  tagName: "div",
  className: "modal",
  id: "whitelistDialogModal",

  events: {
    "hidden"             : "cleanUpModal",
    "submit #new-address": "newAddress",
    "click a#remove_ip"  : "removeAddress"
  },

  initialize: function(options) {
    this.$el.html(JST['application/whitelist_dialog']());

    this.whitelist = options.whitelist;

    this.whitelist.on('sync remove', this.render, this);
  },

  render: function() {
    var self = this;

    this.$("tbody").empty();
    this.whitelist.each(function(ip) {
      var row = $("<tr><td>" + ip.escape('address') + "</td><td>" + ip.escape('reason') + "</td><td><a href=\"#\" id=\"remove_ip\">Remove</a></td></tr>");
      $(row).data("ip_id", ip.get('id'));
      self.$("tbody").append(row);
    });

    return this;
  },

  newAddress: function(e) {
    var self = this;
    var new_address = $(e.currentTarget).find("input[name=address]").val();
    var new_reason = $(e.currentTarget).find("input[name=reason]").val();
    this.$('form#new-address input[name=address]').val(""); // clear the input
    this.$('form#new-address input[name=reason]').val("");

    this.whitelist.create({ address: new_address, reason: new_reason });

    return false;
  },

  removeAddress: function(e) {
    var ip_id = $(e.currentTarget).parents("tr").data("ip_id");

    var model = this.whitelist.get(ip_id);
    model.destroy();

    this.whitelist.remove(model);

    return false;
  },

  cleanUpModal: function() {
    $("div#whitelistDialogModal").remove();

    // Need to change URL in case they want to open the same modal again
    Backbone.history.navigate("");
  }
});
