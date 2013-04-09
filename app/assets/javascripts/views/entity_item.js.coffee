DssRm.Views.EntityItem = Backbone.View.extend(
  tagName: "li"
  events:
    "click a>i": "patchTooltipBehavior"
    "click a.entity-remove-link": "removeEntity"

  initialize: (options) ->
    @view_state = options.view_state

    @listenTo @model, "change", @render
    @listenTo @view_state, "change", @render
    
    @highlighted = options.highlighted
    @faded = options.faded
    @read_only = options.read_only

  render: ->
    type = @model.get("type")
    @$el.data "entity-id", @model.get("id")
    @$el.data "entity-name", @model.get("name")
    @$el.html JST["entities/item"](entity: @model)
    @$("span").html @model.escape("name")
    @$el.addClass type.toLowerCase()
    @$(".entity-details-link").attr("href", @entityUrl()).on "click", (e) ->
      e.stopPropagation() # the parent is looking for a click as well
      $(e.target).tooltip "hide" # but stopPropagation will stop the tooltip from closing...

    @$(".entity-remove-link i").removeClass("icon-remove").addClass "icon-minus"  if type is "Person"
    if @highlighted
      if type is "Person"
        @$el.css("box-shadow", "#08C 0 0 5px").css "border", "1px solid #08C"
      else
        
        # Group
        @$el.css("box-shadow", "#468847 0 0 5px").css "border", "1px solid #468847"
    if @faded
      @$el.css "opacity", "0.6"
      @$("i.icon-minus").hide()
    if @read_only
      @$("i.icon-remove").hide()
      @$("i.icon-search").hide()
    else
      @$("i.icon-lock").hide()
    this

  entityUrl: ->
    "#" + "/entities/" + @model.get("id")

  
  # This is necessary to fix a bug in tooltips (as of Bootstrap 2.1.1)
  patchTooltipBehavior: (e) ->
    $(e.currentTarget).tooltip "hide"

  removeEntity: (e) ->
    e.stopPropagation()
    $(e.target).tooltip "hide" # stopPropagation means the tooltip won't close, so close it
    
    # This is not the same as unassigning. If somebody clicks the remove link
    # on an entity, they are either deleting a group or removing a favorite person.
    type = @model.get("type")
    if type is "Group"
      
      # Destroy the group
      @model.destroy()
    else if type is "Person"
      model_id = @model.get("id")
      favorites_entity = DssRm.current_user.favorites.find((e) ->
        e.id is model_id
      )
      DssRm.current_user.favorites.remove favorites_entity
      DssRm.current_user.favorites.trigger "change"
      DssRm.current_user.save()
)