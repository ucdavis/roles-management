DssRm.Models.Application = Backbone.Model.extend(
  initialize: ->
    # Be sure to use this.roles and this.owners and not this.get('roles'), etc.
    @roles = new DssRm.Collections.Roles(@get("roles"))
    @owners = new DssRm.Collections.Entities(@get("owners"))
    @operators = new DssRm.Collections.Entities(@get("operators"))
    
    @on "sync", =>
      # Adding a new role will reveal a proper ID only after the server gives us one on save
      @roles.reset @get("roles")
  
  # Returns only the "highest" relationship (this order): owner, operator, admin
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
    json = _.omit(@attributes, "roles", "owners", "uids", "operators")
    json.roles_attributes = @roles.map((role) ->
      r = {}
      r.id = role.id.toString()  if role.id
      if role.entities.length > 0
        r.entity_ids = role.entities.map((e) ->
          e.id
        )
      r.token = role.get("token")
      r.name = role.get("name")
      r.description = role.get("description")
      r.ad_path = role.get("ad_path")
      r
    )
    json.owner_ids = @owners.map((owner) ->
      owner.id
    )
    json.operator_ids = @operators.map((operator) ->
      operator.id
    )
    
    json
)