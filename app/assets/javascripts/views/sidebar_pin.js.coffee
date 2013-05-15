DssRm.Views.SidebarPin = Backbone.View.extend(
  tagName: "li"
  events:
    "click a.entity-unfavorite-link": "unfavoriteEntity"

  initialize: (options) ->
    @listenTo @model, "change", @render
    @listenTo DssRm.view_state, "change", @render

    @$el.html JST["entities/item"](entity: @model)
    @$el.data "entity-id", @model.get("id")
    @$el.addClass @model.get("type").toLowerCase()

  render: ->
    type = @model.get("type")
    @$el.data "entity-name", @model.get("name")
    @$("span").html @model.escape("name")
    
    # Highlight this entity?
    if @assignedToCurrentRole() || @isFocused()
      @$el.addClass "highlighted"
    else
      @$el.removeClass "highlighted"
    
    # Change actionable icons depending on ownership
    if !@assignedToCurrentUser()
      @$("i.icon-minus").hide()
    
    focused_entity_id = DssRm.view_state.get('focused_entity_id')
    if !@assignedToCurrentUser() || ((focused_entity_id > 0) && (focused_entity_id != @model.get('id')))
      @$el.css "opacity", "0.6"
    
    if @model.isReadOnly()
      @$("i.icon-remove").hide()
      @$("i.icon-search").hide()
    else
      @$("i.icon-lock").hide()
      @$(".entity-details-link").attr("href", @entityUrl()).on "click", (e) ->
        e.stopPropagation() # the parent is looking for a click as well
    
    @

  entityUrl: ->
    "#" + "/entities/" + @model.get("id")

  unfavoriteEntity: (e) ->
    e.stopPropagation()
    
    model_id = @model.get("id")
    favorites_entity = DssRm.current_user.favorites.find((e) ->
      e.id is model_id
    )
    DssRm.current_user.favorites.remove favorites_entity
    #DssRm.current_user.favorites.trigger "change"
    DssRm.current_user.save()
  
  # Returns true if the given entity 'e' is assigned to the current role
  assignedToCurrentRole: ->
    selected_role = DssRm.view_state.getSelectedRole()
    if selected_role
      results = selected_role.entities.find((i) =>
        i.get('id') is @model.get('id')
      )
      if results is `undefined`
        return false
      else
        return true
    false
  
  # True if in current_user's favorites, group ownerships, or group operatorships
  assignedToCurrentUser: ->
    _current_user_entities = _.union(DssRm.current_user.group_ownerships.models, DssRm.current_user.group_operatorships.models, DssRm.current_user.favorites.models)
    
    return _.find(_current_user_entities, (i) =>
      return i.get("id") is @model.get('id')
    )
  
  isFocused: ->
    return DssRm.view_state.get('focused_entity_id') == @model.id
)
