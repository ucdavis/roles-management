DssRm.Models.Application = Backbone.Model.extend(
  initialize: ->
    @resetNestedCollections()
    @on "sync", @resetNestedCollections, this
  
  resetNestedCollections: ->    
    @roles = new DssRm.Collections.Roles(@get("roles")) if @roles is `undefined`
    @owners = new DssRm.Collections.Entities(@get("owners")) if @owners is `undefined`
    @operators = new DssRm.Collections.Entities(@get("operators")) if @operators is `undefined`
    
    # Enforce the design pattern by removing from @attributes what is represented in a nested collection
    delete @attributes.roles
    delete @attributes.owners
    delete @attributes.operators
  
  # Returns only the "highest" relationship (this order): admin, owner, operator
  # Uses DssRm.current_user as the entity
  relationship: ->
    return "admin" if DssRm.admin_logged_in()
    current_user_id = DssRm.current_user.get("id")
    return "owner" if @owners.find((o) ->
      o.id is current_user_id
    ) isnt `undefined`
    return "operator" if @operators.find((o) ->
      o.id is current_user_id
    ) isnt `undefined`
    null

  toJSON: ->
    json = {}
    json.name = @get('name')
    json.description = @get('description')
    json.operator_ids = @operators.map (operator) -> operator.id
    json.owner_ids = @owners.map (owner) -> owner.id
    json.roles_attributes = @roles.map (role) ->
      id: (if role.id then role.id.toString())
      entity_ids: (if role.entities.length then role.entities.map (e) -> e.id)
      token: role.get("token")
      name: role.get("name")
      description: role.get("description")
      ad_path: role.get("ad_path")
      _destroy: role.get('_destroy')
    
    json
)

DssRm.Collections.Applications = Backbone.Collection.extend(
  model: DssRm.Models.Application
  url: "/applications"
)
