# Nested attributes for people are BB collections while groups used
# vanilla attributes. The former is easier to use but requires you stick
# to a strict pattern. This difference should probably be reconciled.
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
    
    @resetNestedCollections()
    
    @on "sync", @resetNestedCollections, this
  
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

  resetNestedCollections: ->
    type = @get("type")
    
    if type is "Person"
      # FIXME: What happens here when a user has a favorite that they also own? the group has two CIDs?
      #        Then updating one won't update the other - or does that matter? Or will it if we always
      #        save via the user?
      
      # Ensure nested collections exist
      @favorites = new DssRm.Collections.Entities(@get("favorites")) if @favorites is `undefined`
      @group_ownerships = new DssRm.Collections.Entities(@get("group_ownerships")) if @group_ownerships is `undefined`
      @group_operatorships = new DssRm.Collections.Entities(@get("group_operatorships")) if @group_operatorships is `undefined`
      @group_memberships = new Backbone.Collection(@get("group_memberships")) if @group_memberships is `undefined`
      @roles = new DssRm.Collections.Roles(@get("roles")) if @roles is `undefined`
      
      # Reset nested collection data
      @favorites.reset @get("favorites")
      @group_ownerships.reset @get("group_ownerships")
      @group_operatorships.reset @get("group_operatorships")
      @group_memberships.reset @get("group_memberships")
      @roles.reset @get("roles")
      
      # Enforce the design pattern by removing from @attributes what is represented in a nested collection
      delete @attributes.favorites
      delete @attributes.group_ownerships
      delete @attributes.group_operatorships
      delete @attributes.group_memberships
      delete @attributes.roles
  
  # Returns only explicit group memberships (valid only for Person entity, not Group)
  explicitGroupMemberships: ->
    unless @group_memberships
      return []
    
    @group_memberships.filter( (group) ->
      group.get('explicit') == true
    )

  # Returns only calculated group memberships (valid only for Person entity, not Group)
  calculatedGroupMemberships: ->
    unless @group_memberships
      return []

    @group_memberships.filter( (group) ->
      group.get('explicit') == false
    )
  
  ouGroupMemberships: ->
    unless @group_memberships
      return []

    @group_memberships.filter( (group) ->
      group.get('ou') == true
    )
  
  nonOuGroupMemberships: ->
    unless @group_memberships
      return []

    @group_memberships.filter( (group) ->
      group.get('ou') == false
    )

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
      
      json.explicit_role_ids = @roles.filter((role) ->
        role.get('explicit') == true
      ).map((role) ->
        role.id
      )
      json.favorite_ids = @favorites.map((favorite) ->
        favorite.id
      )
      # Only save explicit group memberships - calculated (non-explicit) come from group rules
      # and cannot be controlled by the Person object
      json.explicit_group_ids = @explicitGroupMemberships().map((group) ->
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
