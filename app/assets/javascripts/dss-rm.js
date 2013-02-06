window.DssRm = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},

  initialize: function(data) {
    var self = this;

    this.applications = new DssRm.Collections.Applications(data.applications);
    this.current_user = new DssRm.Models.Entity({
      id: data.current_user.id,
      name: data.current_user.name,
      type: 'Person',
      admin: data.current_user.admin
    });

    self.router = new DssRm.Routers.Applications();
    if (!Backbone.history.started) {
      Backbone.history.start();
      Backbone.history.started = true;
    }

    this.current_user.fetch({
      success: function() {
        $("#loading-backdrop").fadeOut();
      },

      error: function() {
        $("#loading-backdrop").fadeOut();
        console.log("Unable to fetch current user. Probably an invalid access attempt.");
      }
    });

    // Enable tooltips
    $('body').tooltip({
      selector: '[rel=tooltip]'
    });
  }
};
