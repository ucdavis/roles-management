DssRm.Views.TrackingDialog = Backbone.View.extend(
  tagName: "div"
  className: "modal"
  id: "trackingDialogModal"
  events:
    "hidden      ": "cleanUpModal"
    "click button": "toggleTrackedItem"

  initialize: (options) ->
    @$el.html JST["templates/application/tracking_dialog"]()
    @tracked_items = options.tracked_items
    @listenTo @tracked_items, "update", @render
    @departments = _.sortBy options.departments, (item) -> item.name

  render: ->
    @$("tbody").empty()
    _.each @departments, (department) =>
      tracked_item_id = @itemIsTracked( 'department', department.id )
      item_is_tracked = (tracked_item_id != false)
      html = "<tr data-tracked-item-id=#{tracked_item_id} data-item-id=#{department.id} data-item-kind='department' data-item-is-tracked=#{item_is_tracked}><td>#{department.name} (#{department.code})</td><td>"

      if item_is_tracked
        html += "<button style='width: 100%;' class='btn btn-primary'>Tracking</button>"
      else
        html += "<button style='width: 100%;' class='btn'>Not Tracking</button>"

      html += "</td></tr>"

      row = $(html)
      $(row).data "department-id", department.id
      @$("tbody").append row

    @

  # Returns TrackedItem ID if item is tracked, else false
  itemIsTracked: (kind, id) ->
    if kind == 'department'
      item = @tracked_items.findWhere
        kind: 'department'
        item_id: id
      
      return false if item == undefined
      return item.get('id')

    return false

  cleanUpModal: ->
    @remove()
    
    # Need to change URL in case they want to open the same modal again
    Backbone.history.navigate "index"
  
  toggleTrackedItem: (event) ->
    $parent_tr = $(event.target).closest('tr')
    currently_tracked = $parent_tr.data('item-is-tracked')
    item_kind = $parent_tr.data('item-kind')
    item_id = $parent_tr.data('item-id')
    tracked_item_id = $parent_tr.data('tracked-item-id')

    toastr["info"]("Toggling tracking ...")

    if currently_tracked
      # Turn off tracking
      $.ajax(
        url: Routes.admin_tracked_item_path(tracked_item_id)
        type: 'DELETE'
        success: (data) =>
          toastr.remove()
          toastr["success"]("Stopped tracking item.")
          @tracked_items.remove data.tracked_item
        error: () ->
          toastr.remove()
          toastr["error"]("Unable to stop tracking item. Try again later.")
      )
    else
      # Turn on tracking
      $.ajax(
        url: Routes.admin_tracked_items_path()
        type: 'POST'
        data:
          tracked_item:
            kind: item_kind
            item_id: item_id
        success: (data) =>
          toastr.remove()
          toastr["success"]("Started tracking item.")
          @tracked_items.add data.tracked_item
        error: () ->
          toastr.remove()
          toastr["error"]("Unable to start tracking item. Try again later.")
      )
)
