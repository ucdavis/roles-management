DssRm.Views.AboutDialog = Support.CompositeView.extend({
  tagName: "div",
  className: "modal",
  id: "aboutDialogModal",

  events: {
    "hidden": "cleanUpModal"
  },

  initialize: function() {
    this.$el.html(JST['application/about_dialog']());
  },

  render: function() {

    this.$("span#last_updated").html(window.application_last_updated);

    return this;
  },

  cleanUpModal: function() {
    $("div#aboutDialogModal").remove();

    // Need to change URL in case they want to open the same modal again
    Backbone.history.navigate("");
  }
});
