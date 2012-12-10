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
      type: 'Person'
    });

    this.current_user.fetch({
      success: function() {
        self.favorites = new DssRm.Collections.Entities(data.current_user.favorites);

        new DssRm.Routers.Applications({ applications: self.applications, favorites: self.favorites });
        if (!Backbone.history.started) {
          Backbone.history.start();
          Backbone.history.started = true;
        }
      }
    });

    // Enable tooltips
    $('body').tooltip({
      selector: '[rel=tooltip]'
    });
  }
};
