DssRm.Views.TrackingDialog = Backbone.View.extend(
  tagName: "div"
  className: "modal"
  id: "trackingDialogModal"
  events:
    "hidden": "cleanUpModal"

  initialize: (options) ->
    @$el.html JST["templates/application/tracking_dialog"]()
    @tracked_items = options.tracked_items

  render: ->
    # @$("tbody").empty()
    # @queued_jobs.each (job) =>
    #   row = $("<tr><td>" + job.escape('task') + "</td><td>" + job.escape('description') + "</td><td>" + job.escape('run_at') + "</td></tr>")
    #   $(row).data "job-id", job.get('id')
    #   @$("tbody").append row

    @

  cleanUpModal: ->
    @remove()
    
    # Need to change URL in case they want to open the same modal again
    Backbone.history.navigate "index"
)
