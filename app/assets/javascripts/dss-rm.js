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

    this.current_user.fetch({
      success: function(current_user) {
        self.router = new DssRm.Routers.Applications({ applications: self.applications, current_user: self.current_user });
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
