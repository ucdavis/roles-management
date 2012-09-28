DssRm.Routers.Applications = Support.SwappingRouter.extend({
  initialize: function(options) {
    this.el = $('#applications');
    this.applications = options.applications;
    this.entities = options.entities;
  },

  routes: {
    "":          "index",
    "new":       "newTask",
    "tasks/:id": "show"
  },

  index: function() {
    var view = new DssRm.Views.ApplicationsIndex({ collection: this.applications });
    this.swap(view);
  },

  newApplication: function() {
    var view = new DssRm.Views.TasksNew({ collection: this.applications });
    this.swap(view);
  },

  show: function(applicationId) {
    var application = this.collection.get(applicationId);
    var applicationsRouter = this;
    task.fetch({
      success: function() {
        var view = new DssRm.Views.ApplicationShow({ model: application });
        applicationsRouter.swap(view);
      }
    });
  }
});
