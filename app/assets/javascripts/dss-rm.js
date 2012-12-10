window.DssRm = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function(data) {
    this.applications = new DssRm.Collections.Applications(data.applications);
    this.favorites = new DssRm.Collections.Entities(data.favorites);

    new DssRm.Routers.Applications({ applications: this.applications, favorites: this.favorites });
    if (!Backbone.history.started) {
      Backbone.history.start();
      Backbone.history.started = true;
    }

    // Enable tooltips
    $('body').tooltip({
      selector: '[rel=tooltip]'
    });
  }
};
