@EntityTypes =
  unknown : 0
  person  : 1
  group   : 2

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
    @resetNestedCollections()
    @on "sync", @resetNestedCollections, this
  
  resetNestedCollections: ->    
    if @type() is EntityTypes.group
      @owners = new DssRm.Collections.Entities(@get("owners")) if @owners is `undefined`
      @operators = new DssRm.Collections.Entities(@get("operators")) if @operators is `undefined`
      @memberships = new DssRm.Collections.Entities(@get("memberships")) if @memberships is `undefined`
      @rules = new DssRm.Collections.GroupRules(@get("rules")) if @rules is `undefined`

      # Reset nested collection data
      @owners.reset @get("owners")
      @operators.reset @get("operators")
      @memberships.reset @get("memberships")
      @rules.reset @get("rules")
      
      # Enforce the design pattern by removing from @attributes what is represented in a nested collection
      delete @attributes.owners
      delete @attributes.operators
      delete @attributes.memberships
      delete @attributes.rules

    else if @type() is EntityTypes.person
      # Ensure nested collections exist
      @favorites = new DssRm.Collections.Entities(@get("favorites")) if @favorites is `undefined`
      @group_ownerships = new DssRm.Collections.Entities(@get("group_ownerships")) if @group_ownerships is `undefined`
      @group_operatorships = new DssRm.Collections.Entities(@get("group_operatorships")) if @group_operatorships is `undefined`
      @group_memberships = new Backbone.Collection(@get("group_memberships")) if @group_memberships is `undefined`
      @role_assignments = new DssRm.Collections.Roles(@get("role_assignments")) if @role_assignments is `undefined`
      
      # Reset nested collection data
      @favorites.reset @get("favorites")
      @group_ownerships.reset @get("group_ownerships")
      @group_operatorships.reset @get("group_operatorships")
      @group_memberships.reset @get("group_memberships")
      @role_assignments.reset @get("role_assignments")
      
      # Enforce the design pattern by removing from @attributes what is represented in a nested collection
      delete @attributes.favorites
      delete @attributes.group_ownerships
      delete @attributes.group_operatorships
      delete @attributes.group_memberships
      delete @attributes.role_assignments
  
  toJSON: ->
    if @type() is EntityTypes.group
      json = {}
      # Group-specific JSON
      json.name = @get("name")
      json.type = "Group"
      json.description = @get("description")
      json.owner_ids = @owners.map (owner) -> owner.id
      json.operator_ids = @operators.map (operator) -> operator.id
      # Note we use Rails' nested attributes here so we need to 
      if @memberships.length
        json.memberships_attributes = @memberships.map (membership) ->
          id: membership.get('id')
          calculated: membership.get('calculated')
          entity_id: membership.get('entity_id')
          group_id: membership.get('group_id')
          _destroy: membership.get('_destroy')
      if @rules.length
        json.rules_attributes = @rules.map (rule) ->
          id: parseInt(rule.get('id'))
          column: rule.get('column')
          condition: rule.get('condition')
          value: rule.get('value')
          _destroy: rule.get('_destroy')
    
    else if @type() is EntityTypes.person
      json = {} 
      
      # Person-specific JSON
      json.type = "Person"
      
      json.first = @get("first")
      json.last = @get("last")
      json.address = @get("address")
      json.email = @get("email")
      json.loginid = @get("loginid")
      json.phone = @get("phone")
      
      json.favorite_ids = @favorites.map (favorite) -> favorite.id
      if @group_memberships.length
        json.group_memberships_attributes = @group_memberships.map (membership) ->
          id: membership.get('id')
          calculated: membership.get('calculated')
          entity_id: membership.get('entity_id')
          group_id: membership.get('group_id')
          _destroy: membership.get('_destroy')
      if @group_operatorships.length
        json.group_operatorships_attributes = @group_operatorships.map (operatorship) ->
          id: operatorship.get('id')
          entity_id: operatorship.get('entity_id')
          group_id: operatorship.get('group_id')
          _destroy: operatorship.get('_destroy')
      if @group_ownerships.length
        json.group_ownerships_attributes = @group_ownerships.map (ownership) ->
          id: ownership.get('id')
          entity_id: ownership.get('entity_id')
          group_id: ownership.get('group_id')
          _destroy: ownership.get('_destroy')
      if @role_assignments.length
        json.role_assignments_attributes = @role_assignments.map (assignment) ->
          id: assignment.get('id')
          role_id: assignment.get('role_id')
          entity_id: assignment.get('entity_id')
          calculated: assignment.get('calculated')
          _destroy: assignment.get('_destroy')
    
    entity: json

  type: ->
    if @get("type")
      result = @get("type").toLowerCase()
    else if @get("group_id")
      result = "group"
    
    if result == "person"
      return EntityTypes.person
    else if result == "group"
      return EntityTypes.group
    
    return EntityTypes.unknown
  
  # Returns only the "highest" relationship (this order): admin, owner, operator
  # Does not return anything if not admin, owner, or operator on purpose
  # Uses DssRm.current_user as the entity
  # Only applicable to entities of type 'Group', not 'Person'
  relationship: ->
    return "admin" if DssRm.admin_logged_in()

    if @type() is EntityTypes.group
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
  
  # Returns only explicit group memberships (valid only for Person entity, not Group)
  uncalculatedGroupMemberships: ->
    if @type() != EntityTypes.person
      return []
    
    @group_memberships.filter( (group) ->
      group.get('calculated') == false
    )

  # Returns only calculated group memberships (valid only for Person entity, not Group)
  calculatedGroupMemberships: ->
    if @type() != EntityTypes.person
      return []

    @group_memberships.filter( (group) ->
      group.get('calculated') == true
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
)

DssRm.Collections.Entities = Backbone.Collection.extend(
  model: DssRm.Models.Entity
  url: "/entities"
  
  # Two orders of sorting:
  # Calculated entities always come first, then groups
  # So a calculated person (12) comes _before_ a non-calculated group (21),
  # but a calculated group (11) comes before everything. See *_order below.
  comparator: (entity) ->
    calculated_order = (if entity.get('calculated') then '1' else '2')
    type_order = (if entity.type() is EntityTypes.group then '1' else '2')

    return calculated_order + type_order + entity.get("name")
)

DssRm.Collections.Owners = Backbone.Collection.extend(model: DssRm.Models.Entity)
