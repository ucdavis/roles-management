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

    # Is this pin unrelated to the current_user? Make it appear faded
    if @faded
      @$el.addClass "faded"

    # Is this entity a favorite?
    if @favoritedByCurrentUser()
      @$('a.entity-favorite-link>i').addClass('icon-star').removeClass('icon-star-empty').attr('title', 'Unfavorite')
    else
      @$('a.entity-favorite-link>i').removeClass('icon-star').addClass('icon-star-empty').attr('title', 'Favorite')

    @$("i.icon-lock").hide()
    @$(".entity-details-link").attr("href", @entityUrl()).on "click", (e) ->
      e.stopPropagation() # stop parent from receiving click

    @

  entityUrl: ->
    unless @model.get('entity_id')
      @model.set 'entity_id', @model.get('group_id') || @model.get('id')
    "#" + "/entities/" + @model.get('entity_id')

  toggleEntityFavorite: (e) ->
    e.stopPropagation()

    # Favoriting or unfavoriting? Will need it to display correct toaster.
    unfavoriting = false

    model_id = (@model.get('group_id') || @model.get('entity_id'))
    favorites_entity = DssRm.current_user.favorites.find((e) ->
      e.id is model_id
    )

    if favorites_entity
      # Unfavoriting
      unfavoriting = true
      DssRm.current_user.favorites.remove favorites_entity
    else
      # Favoriting
      DssRm.current_user.favorites.add
        id: @model.get('entity_id')
        entity_id: @model.get('entity_id')
        type: @model.get('type')
        name: @model.get('name')

    DssRm.current_user.save {},
      success: =>
        if unfavoriting
          toastr["success"]("Removed #{favorites_entity.get('name')} from favorites.")
        else
          toastr["success"]("Added #{@model.get('name')} to favorites.")
      error: =>
        if unfavoriting
          toastr["error"]("Error while removing #{favorites_entity.get('name')} from favorites.")
        else
          toastr["error"]("Error while removing #{@model.get('name')} from favorites.")

  # True if in current_user's favorites, group ownerships, or group operatorships
  assignedToCurrentUser: ->
    return DssRm.view_state.bookmarks.find (i) =>
      return i.get('id') is @model.get('id')

  # Returns true if this entity is favorited by the current user
  favoritedByCurrentUser: ->
    return DssRm.current_user.favorites.find (f) =>
      return f.get('id') is @model.get('entity_id')

  pinClicked: (e) ->
    e.stopPropagation()

    # Mobile browsers don't support hover, so, if the hover controls haven't appeared
    # by now (as they will on desktop browsers via CSS hover), we'll simply display
    # those hover controls and return. If they 'click' (touch) again, we'll proceed
    # as normal
    if @$('i:first').css('display') == 'none'
      @$('i').css('display', 'block')
      return

    # do nothing if this pin is faded
    return if @faded

    id = @model.get('entity_id')

    # If a role is selected, toggle the entity's association with that role.
    # If no role is selected, merely filter the application/role list to display their assignments. (not implemented yet)
    selected_role = DssRm.view_state.getSelectedRole()

    if selected_role
      # toggle on or off?
      matched = selected_role.assignments.filter((a) ->
        (a.get('entity_id') is id) and (a.get('calculated') == false)
      )

      if matched.length > 0
        # toggling off
        new (DssRm.Views.ConfirmDialog)(
          entity: matched[0],
          role: selected_role,
          confirm: ->
            matched[0].set('_destroy', true)
            toastr["info"]("Saving ...")
            selected_role.save {},
              success: =>
                toastr.remove()
                toastr["success"]("#{matched[0].get('name')} removed from role.")
              error: =>
                toastr.remove()
                toastr["error"]("Error while removing #{matched[0].get('name')} from role.")
        ).render().$el.modal()
      else
        # toggling on
        new_entity = new DssRm.Models.Entity(id: id)

        toastr["info"]("Updating ...")
        new_entity.fetch
          success: =>
            toastr.remove()
            selected_role.assignments.add
              entity_id: new_entity.id
              calculated: false
            toastr["info"]("Saving ...")
            selected_role.save {},
              success: =>
                toastr.remove()
                toastr["success"]("#{new_entity.get('name')} assigned to role successfully.")
              error: =>
                toastr.remove()
                toastr["error"]("Error while assigning #{new_entity.get('name')} to role.")
          error: ->
            toastr.remove()
            toastr["error"]("Error while updating #{new_entity.get('name')}. Role not assigned.")
)
