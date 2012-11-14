// Let Underscore know we'll be using Mustache-style templates
_.templateSettings = {
    interpolate: /\{\{\=(.+?)\}\}/g,
    evaluate: /\{\{(.+?)\}\}/g
};

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
    $("body").tooltip({
      selector: '[rel=tooltip]',
      delay: { show: 400, hide: 75 }
    });

    $(document).click(function (e) {
      if( $(e.target).parents('.tooltip').length == 0 ) $("[data-original-title]").tooltip('hide');
    });
  }
};
