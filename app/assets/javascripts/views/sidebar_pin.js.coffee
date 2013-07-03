DssRm.Views.SidebarPin = Backbone.View.extend(
  tagName: "li"
  events:
    "click a.entity-favorite-link" : "toggleEntityFavorite"
    "click"                        : "pinClicked"

  initialize: (options) ->
    @listenTo @model, "change", @render
    @listenTo DssRm.view_state, "change", @render

    @$el.html JST["templates/entities/item"](entity: @model)
    @$el.addClass (@model.get('type') || 'group').toLowerCase()
    
    @highlighted = options.highlighted
    @faded = options.faded

  render: ->
    @$("span").html @model.escape('name')
    
    # Highlight this entity?
    if @highlighted
      @$el.addClass "highlighted"
    
    # Change actionable icons depending on ownership
    if !@assignedToCurrentUser()
      @$("i.icon-minus").hide()
    
    # Is this pin unrelated to the current_user? Make it appear faded
    if @faded
      @$el.addClass "faded"
    
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
    "#" + "/entities/" + (@model.get("group_id") || @model.get("id"))

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
      console.log 'favoriting model'
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
  
  pinClicked: (e) ->
    e.stopPropagation()
    
    # do nothing if this pin is faded
    return if @faded
    
    id = (@model.get('group_id') || @model.get('id'))
    
    # If a role is selected, toggle the entity's association with that role.
    # If no role is selected, merely filter the application/role list to display their assignments. (not implemented yet)
    selected_role = DssRm.view_state.getSelectedRole()

    if selected_role
      # toggle on or off?
      matched = selected_role.assignments.filter((a) ->
        a.get('entity_id') is id
      )

      if matched.length > 0
        # toggling off
        console.log 'toggling off'
        
        matched[0].set('_destroy', true)
        #selected_role.entities.remove matched[0].get('entity_id')
        #selected_role.assignments.remove matched[0]
        console.log "selected_role #{selected_role.cid} now has #{selected_role.assignments.length} assignments"

        DssRm.view_state.getSelectedApplication().save {},
          success: =>
            DssRm.view_state.trigger('change')
      else
        # toggling on
        new_entity = new DssRm.Models.Entity(id: id)
        new_entity.fetch success: =>
          console.log "toggling on via application save for selected_role with cid #{selected_role.cid}"
          selected_role.entities.add new_entity
          selected_role.assignments.add
            entity_id: new_entity.id
            calculated: false
          app = DssRm.view_state.getSelectedApplication()
          app.save {},
            success: =>
              DssRm.view_state.trigger('change')
)
