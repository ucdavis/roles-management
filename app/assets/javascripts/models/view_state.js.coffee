DssRm.Models.ViewState = Backbone.Model.extend(
  defaults:
    "selected_application_id" : null
    "selected_role_id"        : null
    "focused_application_id"  : null
    "focused_entity_id"       : null

  initialize: ->
    @bookmarks = new DssRm.Collections.Entities()
    
    @buildBookmarks()
    
    # Adjust @bookmarks as needed
    DssRm.current_user.favorites.on "add remove", @buildBookmarks, this
    DssRm.current_user.group_ownerships.on "add", @buildBookmarks, this
    
    # This little hack is required due to BBJS having no callback on .save() that fires after all other events
    # This hack lets us use .on() for the selected_role even though it may change unexpected.
    # When it does change, we call .off() so we are only tracking one role at a time.
    # This is required for the sidebar to re-render after Role.save() calls 'sync'.
    @old_selected_role = null
    @on 'change:selected_role_id', =>
      @old_selected_role.off('sync') if @old_selected_role
      @old_selected_role = @getSelectedRole()
      @old_selected_role.on('sync', =>
        @trigger 'change' # trigger a few change if the selected role trigger's a sync
      , this) if @old_selected_role
    , this
  
  # Constructs list of current user's ownerships, operatorships, and favorites
  buildBookmarks: ->
    console.log 'building bookmarks'
    
    @bookmarks.reset _.union(
      DssRm.current_user.group_ownerships.models,
      DssRm.current_user.group_operatorships.models,
      DssRm.current_user.favorites.models
    )

  # Return the role model associated with @selected_role_id. Always search, don't store the role model - it may be reset on sync!
  getSelectedRole: ->
    selected_role_id = @get('selected_role_id')
    selected_role = null

    DssRm.applications.find (application) =>
      application.roles.find (role) =>
        selected_role = role if role.id == selected_role_id
        
    selected_role
  
  # Return the model associated with @selected_application_id. Always search, don't store the application model - it may be reset on sync!
  getSelectedApplication: ->
    selected_application_id = @get('selected_application_id')
    selected_application = null
    
    DssRm.applications.find (application) =>
      selected_application = application if application.id == selected_application_id
    
    selected_application
  
  # Attempts to set focused_application_id based on search string 'term'
  focusApplicationByTerm: (term) ->
    if app = DssRm.applications.find( (i) -> i.get('name') == term )
      @set focused_application_id: app.id
    else
      @set focused_application_id: null
)
