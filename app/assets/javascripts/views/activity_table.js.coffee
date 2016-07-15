DssRm.Views.ActivityTable ||= {}

class DssRm.Views.ActivityTable extends Backbone.View
  tagName: "div"
  className: "activity-view"

  events:
    "click .pagination>ul>li>a[data-page]" : "paginateActivity"
    "click .pagination>ul>li>a#prev-page"  : "paginatePrevious"
    "click .pagination>ul>li>a#next-page"  : "paginateNext"

  initialize: ->
    @activity = @model

    @activities_per_page = 6
    @page_selector_size = 10
    @num_activity_pages = Math.ceil(@activity.length / @activities_per_page)
    @current_activity_page = 1

    @$el.html JST["templates/shared/activity_table"]()

  render: ->
    $activityTable = @$("tbody#activity_log")
    $activityTable.empty()
    
    $pagination = @$("div.pagination>ul")
    $pagination.empty()

    if(@current_activity_page == 1)
      $pagination.append("<li><a href='#' style='background-color: #f5f5f5; color: #666; cursor: default;'>Prev</a></li>")
    else
      $pagination.append("<li><a id='prev-page' href='#'>Prev</a></li>")

    starting_page = 1
    if @current_activity_page > 5
      starting_page = @current_activity_page - 5
    if @num_activity_pages > @page_selector_size
      if starting_page > (@num_activity_pages - @page_selector_size)
        starting_page = @num_activity_pages - @page_selector_size + 1

    for i in [starting_page..@num_activity_pages]
      break if (i - starting_page) >= @page_selector_size
      if i == @current_activity_page
        $pagination.append("<li class='active' style='display: inline;'><a data-page='#{i}' href='#'>#{i}</a></li>")
      else
        $pagination.append("<li><a data-page='#{i}' href='#'>#{i}</a></li>")

    if(@current_activity_page == @num_activity_pages)
      $pagination.append("<li><a href='#' style='background-color: #f5f5f5; color: #666; cursor: default;'>Next</a></li>")
    else
      $pagination.append("<li><a id='next-page' href='#'>Next</a></li>")

    # Show @activities_per_page entries for the given @current_activity_page
    _.each _.first(_.rest(@activity, (@current_activity_page * @activities_per_page) - @activities_per_page), @activities_per_page), (entry) =>
      $activityTable.append $("<tr><td>#{entry.message}</td><td>#{jQuery.timeago(entry.performed_at)}</td></tr>")
  
    @

  paginateActivity: (e) =>
    desired_page = $(e.target).data('page')
    if desired_page?
      # Change currently selected page to 'desired_page'
      @current_activity_page = desired_page
      @render()

  paginatePrevious: ->
    @current_activity_page = @current_activity_page - 1
    @current_activity_page = 1 if @current_activity_page <= 0
    @render()

  paginateNext: ->
    @current_activity_page = @current_activity_page + 1
    @current_activity_page = @num_activity_pages if @current_activity_page > @num_activity_pages
    @render()
