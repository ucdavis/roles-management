DssRm.Models.Entity = Backbone.Model.extend(
  url: ->
    if @get("id")
      "/entities/" + @get("id")
    else
      "/entities"

  initialize: ->
    type = @get("type")
    
    # Some attribtues may or may not exist depending on how this model was initialized.
    # Ensure needed attributes exist, even if blank.
    if type is "Group"
      @set "owners", []  if @get("owners") is `undefined`
      @set "operators", []  if @get("operators") is `undefined`
      @set "calculated_members", []  if @get("calculated_members") is `undefined`
      @set "explicit_members", []  if @get("explicit_members") is `undefined`
      @set "rules", []  if @get("rules") is `undefined`
    else if type is "Person"
      @set "roles", []  if @get("roles") is `undefined`
      @set "explicit_group_memberships", []  if @get("explicit_group_memberships") is `undefined`
    
    @updateAttributes()
    @on "change", @updateAttributes, this
  
  # Returns only the "highest" relationship (this order): admin, owner, operator
  # Does not return anything if not admin, owner, or operator on purpose
  # Uses DssRm.current_user as the entity
  # Only applicable to entities of type 'Group', not 'Person'
  relationship: ->
    return "admin" if DssRm.admin_logged_in()

    type = @get("type")
    
    if type is "Group"
      current_user_id = DssRm.current_user.get("id")
      return "owner" if _.find(@get("owners"), (o) ->
        o.id is current_user_id
      ) isnt `undefined`
      return "operator" if _.find(@get("operators"), (o) ->
        o.id is current_user_id
      ) isnt `undefined`

    null
  
  # Returns true if DssRm.current_user cannot modify this entity
  isReadOnly: ->
    if @relationship() is 'admin' or @relationship() is 'owner' then return false
    true

  updateAttributes: ->
    type = @get("type")
    
    if type is "Person"
      # What happens here when a user has a favorite that they also own? the group has two CIDs?
      @favorites = new DssRm.Collections.Entities(@get("favorites")) if @favorites is `undefined`
      @group_ownerships = new DssRm.Collections.Entities(@get("group_ownerships")) if @group_ownerships is `undefined`
      @group_operatorships = new DssRm.Collections.Entities(@get("group_operatorships")) if @group_operatorships is `undefined`
      @roles = new DssRm.Collections.Roles(@get("roles")) if @roles is `undefined`
      @favorites.reset @get("favorites")
      @group_ownerships.reset @get("group_ownerships")
      @group_operatorships.reset @get("group_operatorships")
      @roles.reset @get("roles")

  toJSON: ->
    type = @get("type")
    if type is "Group"
      json = {}
      # Group-specific JSON
      json.name = @get("name")
      json.type = "Group"
      json.description = @get("description")
      json.owner_ids = @get("owners").map((owner) ->
        owner.id
      )
      json.operator_ids = @get("operators").map((operator) ->
        operator.id
      )
      json.explicit_member_ids = @get("explicit_members").map((explicit_member) ->
        explicit_member.id
      )
      json.rules_attributes = @get("rules").map((rule) ->
        id: rule.id
        column: rule.column
        condition: rule.condition
        value: rule.value
      )
    else if type is "Person"
      json = {} 
      
      # Person-specific JSON
      json.type = "Person"
      
      json.first = @get("first")
      json.last = @get("last")
      json.address = @get("address")
      json.email = @get("email")
      json.loginid = @get("loginid")
      json.phone = @get("phone")
      
      json.role_ids = @get("roles").map((role) ->
        role.id
      )
      json.favorite_ids = @favorites.map((favorite) ->
        favorite.id
      )
      json.explicit_group_ids = @get("explicit_group_memberships").map((group) ->
        group.id
      )
      json.group_ownership_ids = @group_ownerships.map((group) ->
        group.id
      )
      json.group_operatorship_ids = @group_operatorships.map((group) ->
        group.id
      )
    
    entity: json
)

DssRm.Collections.Entities = Backbone.Collection.extend(
  model: DssRm.Models.Entity
  url: "/entities"
  
  # Sort groups before people, then alphabetical by name
  comparator: (entity) ->
    if entity.get("type") is "Group"
      return '1' + entity.get("name")
    else
      return '2' + entity.get("name")
)

DssRm.Collections.Owners = Backbone.Collection.extend(model: DssRm.Models.Entity)
