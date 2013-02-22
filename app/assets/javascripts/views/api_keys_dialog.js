DssRm.Views.ApiKeysDialog = Support.CompositeView.extend({
  tagName: "div",
  className: "modal",
  id: "apiKeysDialogModal",

  events: {
    "hidden"             : "cleanUpModal",
    "submit #new-key"    : "newApiKey",
    "click a#delete-key" : "removeApiKey"
  },

  initialize: function(options) {
    this.$el.html(JST['application/api_keys_dialog']());

    this.api_keys = options.api_keys;

    this.api_keys.on('sync remove', this.render, this);
  },

  render: function() {
    var self = this;

    console.log("emptied table");
    this.$("tbody").empty();
    this.api_keys.each(function(key) {
      var row = $("<tr><td>" + key.escape('name') + "</td><td>" + key.escape('secret') + "</td><td><a href=\"#\" id=\"delete-key\">Remove</a></td></tr>");
      $(row).data("key-id", key.escape('id'));
      console.log("rendering key with id:" + key.get('id'));
      self.$("tbody").append(row);
    });

    return this;
  },

  newApiKey: function(e) {
    var self = this;
    var name = $(e.currentTarget).find("input[name=name]").val();
    this.$('form#new-key input[name=name]').val(""); // clear the input

    this.api_keys.create({ name: name });

    return false;
  },

  removeApiKey: function(e) {
    var key_id = $(e.currentTarget).parents("tr").data("key-id");

    var model = this.api_keys.get(key_id);
    model.destroy();

    this.api_keys.remove(model);

    return false;
  },

  cleanUpModal: function() {
    $("div#apiKeysDialogModal").remove();

    // Need to change URL in case they want to open the same modal again
    Backbone.history.navigate("");
  }
});
