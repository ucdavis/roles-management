DssRm.Routers.Applications = Support.SwappingRouter.extend({
  initialize: function(options) {
    this.el = $('#applications');
    this.applications = options.applications;
    this.favorites = options.favorites;
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
    var view = new DssRm.Views.ApplicationsIndex({ applications: this.applications, favorites: this.favorites });
    this.swap(view);
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
    var entity = this.favorites.get(uid);
    var entitiesRouter = this;

    entity.fetch({
      success: function() {
        var view = new DssRm.Views.EntityShow({ model: entity });
        entitiesRouter.currentView.renderChild(view);
        view.$el.modal();
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

    $.get(Routes.admin_api_whitelisted_ips_path(), function(ips) {
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
