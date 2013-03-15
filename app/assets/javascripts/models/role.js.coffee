DssRm.Models.Role = Backbone.Model.extend(
  urlRoot: "/roles"
  
  initialize: ->
    @entities = new DssRm.Collections.Entities(@get('entities'))
    @on "change", @updateEntities, this
  
  updateEntities: ->
    @entities.reset @get('entities'), { silent: true }

  tokenize: (str) ->
    String(str).replace(RegExp(" ", "g"), "-").replace(/'/g, "").replace(/"/g, "").toLowerCase()
)
