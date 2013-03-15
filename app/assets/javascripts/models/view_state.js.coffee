DssRm.Models.ViewState = Backbone.Model.extend(
  initialize: ->
    @deselectAll()

  getSelectedRoleId: ->
    @get('selected_role').get('id') if @get('selected_role')
  
  deselectAll: ->
    @set selected_application: null
    @set selected_role: null
    @set focused_application_id: null
    @set focused_entity_id: null
  
  # Attempts to set focused_application_id based on search string 'term'
  focusApplicationByTerm: (term) ->
    if app = DssRm.applications.find( (i) -> i.get('name') == term )
      @set focused_application_id: app.id
    else
      @set focused_application_id: null
)
