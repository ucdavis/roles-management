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
      @set "members", []  if @get("members") is `undefined`
      @set "rules", []  if @get("rules") is `undefined`
    else if type is "Person"
      @set "roles", []  if @get("roles") is `undefined`
      @set "group_memberships", []  if @get("group_memberships") is `undefined`
      @set "ous", []  if @get("ous") is `undefined`
    @updateAttributes()
    @on "change", @updateAttributes, this

  # Returns only the "highest" relationship (this order): admin, owner, operator
  # Does not return anything if not admin, owner, or operator on purpose
  # Uses DssRm.current_user as the entity
  # Only applicable to entities of type 'Group', not 'Person'
  relationship: ->
    type = @get("type")
    
    if type is "Group"
      return "admin" if DssRm.admin_logged_in()
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
      @favorites = new DssRm.Collections.Entities(@get("favorites")) if @favorites is `undefined`
      @group_ownerships = new DssRm.Collections.Entities(@get("group_ownerships")) if @group_ownerships is `undefined`
      @group_operatorships = new DssRm.Collections.Entities(@get("group_operatorships")) if @group_operatorships is `undefined`
      @roles = new DssRm.Collections.Roles(@get("roles")) if @roles is `undefined`
      @favorites.reset @get("favorites")
      @group_ownerships.reset @get("group_ownerships")
      @group_operatorships.reset @get("group_operatorships")
      @roles.reset @get("roles")

  toJSON: ->
    json = _.omit(@attributes, "owners", "operators", "members", "rules", "id", "roles", "favorites", "group_memberships", "group_ownerships", "group_operatorships", "ous", "byline", "name", "admin")
    type = @get("type")
    if type is "Group"
      # Group-specific JSON
      json.name = @get("name")
      json.owner_ids = @get("owners").map((owner) ->
        owner.id
      )
      json.operator_ids = @get("operators").map((operator) ->
        operator.id
      )
      json.member_ids = @get("members").map((member) ->
        member.id
      )
      json.rules_attributes = @get("rules").map((rule) ->
        id: rule.id
        column: rule.column
        condition: rule.condition
        value: rule.value
      )
    else if type is "Person"
      # Person-specific JSON
      json.role_ids = @get("roles").map((role) ->
        role.id
      )
      json.favorite_ids = @favorites.map((favorite) ->
        favorite.id
      )
      json.group_membership_ids = _.union(@get("group_memberships").ous, @get("group_memberships").non_ous).map((group) ->
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