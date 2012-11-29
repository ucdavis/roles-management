window.DssRm = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function(data) {
    this.applications = new DssRm.Collections.Applications(data.applications);
    this.entities = new DssRm.Collections.Entities(data.entities);

    new DssRm.Routers.Applications({ applications: this.applications, entities: this.entities });
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
