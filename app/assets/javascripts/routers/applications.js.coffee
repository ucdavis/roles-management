DssRm.Routers.Applications = Backbone.Router.extend(
  initialize: ->
    @indexView = new DssRm.Views.ApplicationsIndex().render()
    $("#applications").replaceWith @indexView.el

  routes:
    ""                 : "index"
    "applications/:id" : "showApplication"
    "entities/:uid"    : "showEntity"
    "import/:term"     : "importPersonDialog"
    "impersonate"      : "impersonateDialog"
    "unimpersonate"    : "unimpersonate"
    "api-keys"         : "apiKeysDialog"
    "whitelist"        : "whitelistDialog"
    "queued-jobs"      : "queuedJobsDialog"
    "event-log"        : "eventLogDialog"
    "about"            : "aboutDialog"

  index: ->

  showApplication: (applicationId) ->
    toastr["info"]("Loading application ...")

    application = DssRm.applications.get(applicationId)
    application.fetch
      success: ->
        toastr.remove()
        new DssRm.Views.ApplicationShow(model: application).$el.modal()

      error: ->
        toastr.remove()
        toastr["error"]("An error occurred while loading the application.")

  showEntity: (uid) ->
    uid = parseInt(uid)

    toastr["info"]("Loading person or group ...")

    # Search DssRm.current_user objects first
    # We'd prefer not to create new objects and would like events like name
    # changes to propagate
    entity = DssRm.view_state.bookmarks.get(uid)
    entity = DssRm.view_state.bookmarks.findWhere({ group_id: uid }) if entity is undefined

    # Fetch it as a last resort - we won't get event updates
    entity = new DssRm.Models.Entity(id: uid) if entity is undefined

    entity.fetch
      success: =>
        toastr.remove()
        entity.resetNestedCollections()
        new DssRm.Views.EntityShow(entity).entityView.$el.modal()

      error: ->
        toastr["error"]("An error occurred while loading the person or group.")

  importPersonDialog: (term) ->
    new DssRm.Views.ImportPersonDialog(term: term).render().$el.modal()

  impersonateDialog: ->
    new DssRm.Views.ImpersonateDialog().render().$el.modal()

  unimpersonate: ->
    window.location.href = Routes.admin_ops_unimpersonate_path()

  apiKeysDialog: ->
    toastr["info"]("Loading API keys ...")

    $.get Routes.admin_api_key_users_path(), (keys) =>
      toastr.remove()
      api_keys = new DssRm.Collections.ApiKeys(keys)
      new DssRm.Views.ApiKeysDialog(api_keys: api_keys).render().$el.modal()

  whitelistDialog: ->
    toastr["info"]("Loading whitelisted IP addresses ...")

    $.get Routes.admin_api_whitelisted_ip_users_path(), (ips) =>
      toastr.remove()
      whitelisted_ips = new DssRm.Collections.WhitelistedIPs(ips)
      new DssRm.Views.WhitelistDialog(whitelist: whitelisted_ips).render().$el.modal()

  queuedJobsDialog: ->
    toastr["info"]("Loading queued jobs ...")

    $.get Routes.admin_queued_jobs_path(), (jobs) =>
      toastr.remove()
      queued_jobs = new DssRm.Collections.QueuedJobs(jobs)
      new DssRm.Views.QueuedJobsDialog(queued_jobs: queued_jobs).render().$el.modal()

  eventLogDialog: ->
    # toastr["info"]("Loading events ...")
    #
    # $.get Routes.diary_entries_path(), (data) =>
    #   toastr.remove()
    #   entries = new DssRm.Collections.EventLogEntries(data)
    #   new DssRm.Views.EventLogDialog(entries: entries).render().$el.modal()

  aboutDialog: ->
    new DssRm.Views.AboutDialog().render().$el.modal()
)
