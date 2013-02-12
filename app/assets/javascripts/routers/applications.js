DssRm.Routers.Applications = Support.SwappingRouter.extend({
  initialize: function(options) {
    this.el = $('#applications');

    this.indexView = new DssRm.Views.ApplicationsIndex();
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
    var application = DssRm.applications.get(applicationId);
    var applicationsRouter = this;

    status_bar.show("Loading application ...");

    application.fetch({
      success: function() {
        status_bar.hide();

        var view = new DssRm.Views.ApplicationShow({ model: application });
        applicationsRouter.currentView.renderChild(view);
        view.$el.modal();
      },

      error: function() {
        status_bar.show("An error occurred while loading the application.", "error");
      }
    });
  },

  showEntity: function(uid) {
    // Search DssRm.current_user objects first
    // We'd prefer not to create new objects and would like events like name
    // changes to propagate
    var entity = DssRm.current_user.favorites.get(uid);
    if(entity == undefined) entity = DssRm.current_user.group_ownerships.get(uid);
    if(entity == undefined) entity = DssRm.current_user.group_operatorships.get(uid);
    // Fetch it as a last resort - we won't get event updates
    if(entity == undefined) entity = new DssRm.Models.Entity({ id: uid });

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
