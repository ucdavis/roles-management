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

    application.fetch({
      success: function() {
        var view = new DssRm.Views.ApplicationShow({ model: application, applications: applicationsRouter.applications });
        applicationsRouter.currentView.renderChild(view);
        view.$el.modal();
      }
    });
  },

  showEntity: function(uid) {
    // Search for this entity (we use the current_user collections for events-sake)
    var entity = this.current_user.favorites.get(uid);
    if(entity === undefined) entity = this.current_user.group_ownerships.get(uid);
    if(entity === undefined) entity = this.current_user.group_operatorships.get(uid);

    var self = this;

    entity.fetch({
      success: function() {
        var view = new DssRm.Views.EntityShow({ model: entity });
        self.currentView.renderChild(view);
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
