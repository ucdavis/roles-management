DssRm.Views.SidebarPin = Backbone.View.extend(
  tagName: "li"
  events:
    "click a.entity-favorite-link": "toggleEntityFavorite"

  initialize: (options) ->
    @listenTo @model, "change", @render
    @listenTo DssRm.view_state, "change", @render

    @$el.html JST["templates/entities/item"](entity: @model)
    @$el.data "entity-id", @model.get('id')
    @$el.addClass @model.get('type').toLowerCase()
    
    @highlighted = options.highlighted
    @faded = options.faded

  render: ->
    @$el.data "entity-name", @model.get('name')
    @$("span").html @model.escape('name')
    
    # Highlight this entity?
    if @highlighted # @assignedToCurrentRole() || @isFocused()
      @$el.addClass "highlighted"
    
    # Change actionable icons depending on ownership
    if !@assignedToCurrentUser()
      @$("i.icon-minus").hide()
    
    # Is this pin unrelated to the current_user? Make it appear faded
    if @faded
      @$el.css "opacity", "0.5"
    
    # Is this entity a favorite?
    if @favoritedByCurrentUser()
      @$('a.entity-favorite-link>i').addClass('icon-star').removeClass('icon-star-empty').attr('title', 'Unfavorite')
    else
      @$('a.entity-favorite-link>i').removeClass('icon-star').addClass('icon-star-empty').attr('title', 'Favorite')
    
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

  toggleEntityFavorite: (e) ->
    e.stopPropagation()
    
    model_id = @model.get("id")
    favorites_entity = DssRm.current_user.favorites.find((e) ->
      e.id is model_id
    )
    if favorites_entity
      # Unfavoriting
      DssRm.current_user.favorites.remove favorites_entity
    else
      # Favoriting
      DssRm.current_user.favorites.add @model
    
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
  
  # Returns true if this entity is favorited by the current user
  favoritedByCurrentUser: ->
    return _.find(DssRm.current_user.favorites.models, (i) =>
      return i.get("id") is @model.get('id')
    )
  
  isFocused: ->
    return DssRm.view_state.get('focused_entity_id') == @model.id
)
