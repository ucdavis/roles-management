DssRm.Routers.Applications = Support.SwappingRouter.extend({
  initialize: function(options) {
    this.el = $('#applications');
    this.applications = options.applications;
    this.current_user = options.current_user;

    this.indexView = new DssRm.Views.ApplicationsIndex({
      applications: this.applications,
      current_user: this.current_user
    });
  },

  routes: {
    ""                 : "index",
    "applications/:id" : "showApplication",
    "entities/:uid"    : "showEntity",
    "impersonate"      : "impersonateDialog",
    "unimpersonate"    : "unimpersonate",
    "whitelist"        : "whitelistDialog",
    "about"            : "aboutDialog"
  },

  index: function() {
    this.swap(this.indexView);
  },

  showApplication: function(applicationId) {
    var application = this.applications.get(applicationId);
    var applicationsRouter = this;

    status_bar.show("Loading application ...");

    application.fetch({
      success: function() {
        status_bar.hide();

        var view = new DssRm.Views.ApplicationShow({ model: application, applications: applicationsRouter.applications });
        applicationsRouter.currentView.renderChild(view);
        view.$el.modal();
      },

      error: function() {
        status_bar.show("An error occurred while loading the application.", "error");
      }
    });
  },

  showEntity: function(uid) {
    // Search for this entity (we use the current_user collections for events-sake)
    var entity = new DssRm.Models.Entity({ id: uid });

    var self = this;

    status_bar.show("Loading ...");

    entity.fetch({
      success: function() {
        status_bar.hide();

        var view = new DssRm.Views.EntityShow({ model: entity });
        self.currentView.renderChild(view);
        view.$el.modal();
      },

      error: function() {
        status_bar.show("An error occurred while loading the entity.", "error");
      }
    });
  },

  impersonateDialog: function() {
    var view = new DssRm.Views.ImpersonateDialog();
    this.currentView.renderChild(view);
    view.$el.modal();
  },

  unimpersonate: function() {
    window.location.href = Routes.admin_ops_unimpersonate_path();
  },

  whitelistDialog: function() {
    var self = this;

    status_bar.show("Loading whitelist dialog ...");

    $.get(Routes.admin_api_whitelisted_ips_path(), function(ips) {
      status_bar.hide();

      self.whitelisted_ips = new DssRm.Collections.WhitelistedIPs(ips);

      var view = new DssRm.Views.WhitelistDialog({ whitelist: self.whitelisted_ips });
      self.currentView.renderChild(view);
      view.$el.modal();
    });
  },

  aboutDialog: function() {
    var view = new DssRm.Views.AboutDialog();
    this.currentView.renderChild(view);
    view.$el.modal();
  }
});
