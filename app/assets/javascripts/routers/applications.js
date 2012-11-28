DssRm.Routers.Applications = Support.SwappingRouter.extend({
  initialize: function(options) {
    this.el = $('#applications');
    this.applications = options.applications;
    this.entities = options.entities;
  },

  routes: {
    ""                 : "index",
    "new"              : "newApplication",
    "applications/:id" : "showApplication",
    "entities/:uid"    : "showEntity",
    "about"            : "aboutDialog"
  },

  index: function() {
    var view = new DssRm.Views.ApplicationsIndex({ applications: this.applications, entities: this.entities });
    this.swap(view);
  },

  newApplication: function() {
    //var view = new DssRm.Views.TasksNew({ collection: this.applications });
    //this.swap(view);
  },

  showApplication: function(applicationId) {
    var application = this.applications.get(applicationId);
    var applicationsRouter = this;

    application.fetch({
      success: function() {
        var view = new DssRm.Views.ApplicationShow({ model: application, applications: applicationsRouter.applications });
        applicationsRouter.currentView.renderChild(view);
        view.$el.modal();
      }
    });
  },

  showEntity: function(uid) {
    var entity = this.entities.get(uid);
    var entitiesRouter = this;

    entity.fetch({
      success: function() {
        var view = new DssRm.Views.EntityShow({ model: entity });
        entitiesRouter.currentView.renderChild(view);
        view.$el.modal();
      }
    });
  },

  aboutDialog: function() {
    var view = new DssRm.Views.AboutDialog();
    this.currentView.renderChild(view);
    view.$el.modal();
  }
});
