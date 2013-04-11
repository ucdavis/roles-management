DssRm.Routers.Applications = Backbone.Router.extend(
  initialize: (options) ->
    @el = $("#applications")
    @indexView = new DssRm.Views.ApplicationsIndex()
    @indexView.render()
    @el.html(@indexView.el)

  routes:
    "": "index"
    "applications/:id": "showApplication"
    "entities/:uid": "showEntity"
    "import/:term": "importPersonDialog"
    "impersonate": "impersonateDialog"
    "unimpersonate": "unimpersonate"
    "api-keys": "apiKeysDialog"
    "whitelist": "whitelistDialog"
    "about": "aboutDialog"

  index: ->

  showApplication: (applicationId) ->
    status_bar.show "Loading application ..."

    application = DssRm.applications.get(applicationId)
    application.fetch
      success: ->
        status_bar.hide()
        new DssRm.Views.ApplicationShow(model: application).render().$el.modal()
        
      error: ->
        status_bar.show "An error occurred while loading the application.", "error"


  showEntity: (uid) ->
    status_bar.show "Loading ..."

    # Search DssRm.current_user objects first
    # We'd prefer not to create new objects and would like events like name
    # changes to propagate
    entity = DssRm.current_user.favorites.get(uid)
    entity = DssRm.current_user.group_ownerships.get(uid) if entity is `undefined`
    entity = DssRm.current_user.group_operatorships.get(uid) if entity is `undefined`
    
    # Fetch it as a last resort - we won't get event updates
    entity = new DssRm.Models.Entity(id: uid) if entity is `undefined`
    
    entity.fetch
      success: =>
        status_bar.hide()
        new DssRm.Views.EntityShow(model: entity).render().$el.modal()

      error: ->
        status_bar.show "An error occurred while loading the entity.", "error"

  importPersonDialog: (term) ->
    new DssRm.Views.ImportPersonDialog(term: term).render().$el.modal()

  impersonateDialog: ->
    new DssRm.Views.ImpersonateDialog().render().$el.modal()

  unimpersonate: ->
    window.location.href = Routes.admin_ops_unimpersonate_path()

  apiKeysDialog: ->
    status_bar.show "Loading API keys dialog ..."
    
    $.get Routes.admin_api_key_users_path(), (keys) =>
      status_bar.hide()
      api_keys = new DssRm.Collections.ApiKeys(keys)
      new DssRm.Views.ApiKeysDialog(api_keys: api_keys).render().$el.modal()

  whitelistDialog: ->
    status_bar.show "Loading whitelist dialog ..."

    $.get Routes.admin_api_whitelisted_ips_path(), (ips) =>
      status_bar.hide()
      whitelisted_ips = new DssRm.Collections.WhitelistedIPs(ips)
      new DssRm.Views.WhitelistDialog(whitelist: whitelisted_ips).render().$el.modal()

  aboutDialog: ->
    new DssRm.Views.AboutDialog().render().$el.modal()
)
