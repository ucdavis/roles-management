DssRm.Routers.Applications = Backbone.Router.extend(
  initialize: (options) ->
    @indexView = new DssRm.Views.ApplicationsIndex().render()
    $("#applications").replaceWith @indexView.el

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
        new DssRm.Views.ApplicationShow(model: application).$el.modal()
        
      error: ->
        status_bar.show "An error occurred while loading the application.", "error"

  showEntity: (uid) ->
    uid = parseInt(uid)
    
    status_bar.show "Loading ..."

    # Search DssRm.current_user objects first
    # We'd prefer not to create new objects and would like events like name
    # changes to propagate
    entity = DssRm.view_state.bookmarks.get(uid)
    entity = DssRm.view_state.bookmarks.findWhere({ group_id: uid }) if entity is undefined
    
    if entity is undefined
      console.log 'couldnt find entity in bookmarks'
      debugger
    
    # Fetch it as a last resort - we won't get event updates
    entity = new DssRm.Models.Entity(id: uid) if entity is undefined
    
    entity.fetch
      success: =>
        status_bar.hide()
        console.log "showing entity #{entity.cid}"
        new DssRm.Views.EntityShow(entity).entityView.$el.modal()

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

    $.get Routes.admin_api_whitelisted_ip_users_path(), (ips) =>
      status_bar.hide()
      whitelisted_ips = new DssRm.Collections.WhitelistedIPs(ips)
      new DssRm.Views.WhitelistDialog(whitelist: whitelisted_ips).render().$el.modal()

  aboutDialog: ->
    new DssRm.Views.AboutDialog().render().$el.modal()
)
