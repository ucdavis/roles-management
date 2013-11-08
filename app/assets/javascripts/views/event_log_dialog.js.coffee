DssRm.Views.EventLogDialog = Backbone.View.extend(
  tagName: "div"
  className: "modal"
  id: "eventLogDialogModal"
  events:
    "hidden": "cleanUpModal"
    "show"  : "fetchEntries"

  initialize: (options) ->
    @$el.html JST["templates/application/event_log_dialog"]()
    @entries = options.entries

  render: ->
    @$("tbody").empty()
    @entries.each (entry) =>
      group = '<div class="accordion-group" data-uid="' + entry.get('uid') + '">
        <div class="accordion-heading">
          <div style="float: right; padding: 8px 15px;"><time class="timeago" datetime="' + entry.get('date') + '">' + jQuery.timeago(entry.get('date')) + '</time></div>
          <a class="accordion-toggle" data-toggle="collapse" data-parent="#event-accordion" href="#collapse-' + entry.get('uid') + '">
            ' + entry.escape('name') + '
          </a>
        </div>
        <div id="collapse-' + entry.get('uid') + '" class="accordion-body collapse">
          <div class="accordion-inner">
            Loading ...
          </div>
        </div>
      </div>'
      
      @$(".accordion").append group

    @
  
  fetchEntries: (e) ->
    # Only respond to accordion 'show' events
    if $(e.target).hasClass('collapse')
      uid = parseInt($(e.target).parent().data('uid'))
      
      # Fetch UID and draw table
      $.get Routes.diary_path(uid), (data) =>
        table = '<table class="table table-striped"><tbody>'
        _.each data.entries, (entry) =>
          table += '<tr><td>' + entry.message + '</td><td><time class="timeago" datetime="' + entry.created_at + '">' + jQuery.timeago(entry.created_at) + '</time></td></tr>'
        table += '</tbody></table>'
        console.log data

        $(e.target).find('.accordion-inner').html table

  cleanUpModal: (e) ->
    if e.target.id == 'eventLogDialogModal'
      @remove()
    
      # Need to change URL in case they want to open the same modal again
      Backbone.history.navigate "index"
)
