DssRm.Models.Role = Backbone.Model.extend(
  urlRoot: "/roles"
  
  initialize: ->
    @resetNestedCollections()
    @on "sync", @resetNestedCollections, this
    
  resetNestedCollections: ->
    console.log "role #{@cid} resetting nested collections"
    
    @entities = new DssRm.Collections.Entities(@get('entities')) if @entities is `undefined`
    @assignments = new Backbone.Collection(@get('assignments')) if @assignments is `undefined`

    # Reset nested collection data
    @entities.reset @get('entities')
    @assignments.reset @get('assignments')
    
    console.log "role now has #{@assignments.length} assignments"
    
    # Enforce the design pattern by removing from @attributes what is represented in a nested collection
    delete @attributes.entities
    delete @attributes.assignments

  tokenize: (str) ->
    String(str).replace(RegExp(" ", "g"), "-").replace(/'/g, "").replace(/"/g, "").toLowerCase()
)

DssRm.Collections.Roles = Backbone.Collection.extend(
  model: DssRm.Models.Role
  url: "/roles"
)
