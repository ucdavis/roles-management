DssRm.Models.Role = Backbone.Model.extend(
  urlRoot: "/roles"
  initialize: ->
    @entities = new DssRm.Collections.Entities(@get("entities"))

  tokenize: (str) ->
    String(str).replace(RegExp(" ", "g"), "-").replace(/'/g, "").replace(/"/g, "").toLowerCase()
)
