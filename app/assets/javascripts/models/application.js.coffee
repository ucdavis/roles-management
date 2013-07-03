DssRm.Models.Application = Backbone.Model.extend(
  initialize: ->
    @resetNestedCollections()
    @on "sync", @resetNestedCollections, this
    @roles.on "sync", ->
      console.log 'application detected a role sync'
    , this
  
  resetNestedCollections: ->
    @roles = new DssRm.Collections.Roles(@get("roles")) if @roles is `undefined`
    @owners = new DssRm.Collections.Entities(@get("owners")) if @owners is `undefined`
    @operators = new DssRm.Collections.Entities(@get("operators")) if @operators is `undefined`
    
    # Reset nested collection data
    @roles.reset @get("roles")
    @owners.reset @get("owners")
    @operators.reset @get("operators")
    
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
    if @roles.length
      json.roles_attributes = @roles.map (role) ->
        role_json = {}
        
        if role.assignments.length
          role_json.role_assignments_attributes = role.assignments.map (a) ->
            id: a.get('id')
            entity_id: a.get('entity_id')
            _destroy: a.get('_destroy')
        role_json.id = role.get('id')
        role_json.token = role.get("token")
        role_json.name = role.get("name")
        role_json.description = role.get("description")
        role_json.ad_path = role.get("ad_path")
        role_json._destroy = role.get('_destroy')
        role_json
    
    json
)

DssRm.Collections.Applications = Backbone.Collection.extend(
  model: DssRm.Models.Application
  url: "/applications"
)
