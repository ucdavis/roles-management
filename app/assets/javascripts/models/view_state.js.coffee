DssRm.Models.ViewState = Backbone.Model.extend(
  initialize: ->
    @deselectAll()

  deselectAll: ->
    @set selected_application_id: null
    @set selected_role_id: null # do _not_ store non-IDs. the CIDs of roles may change when we reset.
    @set focused_application_id: null
    @set focused_entity_id: null
  
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
