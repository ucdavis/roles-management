DssRm.Models.ViewState = Backbone.Model.extend(
  initialize: ->
    @selected_application = null
    @selected_role_id = null
    @focused_application_id = null
    @focused_entity_id = null

)
