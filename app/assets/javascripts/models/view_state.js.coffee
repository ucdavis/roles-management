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
    
    DssRm.applications.on "change", =>
      console.log 'view_state on applications change fired'
    , this
    DssRm.applications.on "sync", =>
      console.log 'view_state on applications sync fired'
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
