DssRm.Models.ViewState = Backbone.Model.extend(
  defaults:
    "selected_application_id" : null
    "selected_role_id"        : null
    "focused_application_id"  : null
    "focused_entity_id"       : null

  initialize: ->
    @sidebar_entities = new DssRm.Collections.Entities()
    
    @buildSidebarEntities()
    
    # Intelligently handle adjusting @sidebar_entities
    # DssRm.current_user.favorites.on "sync", =>
    #   console.log 'favorites sync event, calling build sidebar'
    #   @buildSidebarEntities()
    # , this
    DssRm.current_user.group_ownerships.on "add", (ownership) =>
      @sidebar_entities.add
        id: ownership.get('id')
        name: ownership.get('name')
        type: 'group'
    , this
    # DssRm.current_user.group_operatorships.on "sync", =>
    #   console.log 'group operatorships sync, calling build sidebar'
    #   @buildSidebarEntities()
    # , this
  
  # Constructs list of current user's ownerships, operatorships, and favorites
  buildSidebarEntities: ->
    console.log 'building sidebar ...'
    @sidebar_entities.reset _.union(
      DssRm.current_user.group_ownerships.models.map (o) ->
        id: o.get('group_id')
        name: o.get('name')
        type: 'group'
    ,
      DssRm.current_user.group_operatorships.models.map (o) ->
        id: o.get('group_id')
        name: o.get('name')
        type: 'group'
    ,
      DssRm.current_user.favorites.models.map (f) ->
        id: f.get('id')
        name: f.get('name')
        type: f.get('type').toLowerCase()
    )
    console.log 'done building sidebar'

  # Return the role model associated with @selected_role_id. Always search, don't store the role model - it may be reset on sync!
  getSelectedRole: ->
    selected_role_id = @get('selected_role_id')
    selected_role = null

    DssRm.applications.find (application) =>
      application.roles.find (role) =>
        selected_role = role if role.id == selected_role_id
    
    if selected_role
      console.log "get selected role returning a role with cid #{selected_role.cid}"
    else
      console.log "get selected role called when no role is selected (this is normal)"
        
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
