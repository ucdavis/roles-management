DssRm.Views.EntityItem = Backbone.View.extend(
  tagName: "li"
  events:
    "click a.entity-remove-link": "removeEntity"

  initialize: (options) ->
    @view_state = options.view_state

    @listenTo @model, "change", @render
    @listenTo @view_state, "change", @render

  render: ->
    type = @model.get("type")
    @$el.data "entity-id", @model.get("id")
    @$el.data "entity-name", @model.get("name")
    @$el.html JST["entities/item"](entity: @model)
    @$("span").html @model.escape("name")
    @$el.addClass type.toLowerCase()
    
    @$(".entity-details-link").attr("href", @entityUrl()).on "click", (e) ->
      e.stopPropagation() # the parent is looking for a click as well
      #$(e.target).tooltip "hide" # but stopPropagation will stop the tooltip from closing...

    @$(".entity-remove-link i").removeClass("icon-remove").addClass "icon-minus" if type is "Person"

    # highlight this entity
    if @assignedToCurrentRole() || @isFocused()
      if type is "Person"
        @$el.css("box-shadow", "#08C 0 0 5px").css "border", "1px solid #08C"
      else # is Group
        @$el.css("box-shadow", "#468847 0 0 5px").css "border", "1px solid #468847"

    # change actionable icons depending on ownership
    if !@assignedToCurrentUser()
      @$("i.icon-minus").hide()

    focused_entity_id = @view_state.get('focused_entity_id')
    if !@assignedToCurrentUser() || ((focused_entity_id > 0) && (focused_entity_id != @model.get('id')))
      @$el.css "opacity", "0.6"
    
    if @isReadOnly()
      @$("i.icon-remove").hide()
      @$("i.icon-search").hide()
    else
      @$("i.icon-lock").hide()
    
    @

  entityUrl: ->
    "#" + "/entities/" + @model.get("id")

  removeEntity: (e) ->
    e.stopPropagation()
    #$(e.target).tooltip "hide" # stopPropagation means the tooltip won't close, so close it
    
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
  
  # Returns true if the given entity 'e' is assigned to the current role
  assignedToCurrentRole: ->
    selected_role = @view_state.getSelectedRole()
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
  
  # Returns true if the current_user only operates the group (and does not own it)
  isReadOnly: ->
    if @model.get('name') == 'Group17'
      console.log @model.relationship()
    
    # Need group_operatorship IDs has an array when drawing EntityItem
    group_operatorships = DssRm.current_user.group_operatorships.map((group) ->
      group.get "id"
    )
    
    return _.indexOf(group_operatorships, @model.get("id")) >= 0
  
  isFocused: ->
    return @view_state.get('focused_entity_id') == @model.id
)
