DssRm.Models.Application = Backbone.Model.extend(
  initialize: ->
    @resetNestedCollections()
    @on 'sync', @resetNestedCollections, this

  resetNestedCollections: ->
    @roles = new DssRm.Collections.Roles if @roles is `undefined`
    @owners = new DssRm.Collections.Entities if @owners is `undefined`
    @operatorships = new DssRm.Collections.Entities if @operatorships is `undefined`

    # Reset nested collection data
    @roles.reset @get("roles")
    @owners.reset @get("owners")
    @operatorships.reset @get("operatorships")

    # Enforce the design pattern by removing from @attributes what is represented in a nested collection
    delete @attributes.roles
    delete @attributes.owners
    delete @attributes.operatorships

  # Returns true if DssRm.current_user cannot modify this entity
  isReadOnly: ->
    if @relationship() is 'admin' or @relationship() is 'owner' then return false
    true

  # Returns only the "highest" relationship (this order): admin, owner, operator
  # Uses DssRm.current_user as the entity
  relationship: ->
    return "admin" if DssRm.admin_logged_in()
    current_user_id = DssRm.current_user.get("id")
    return "owner" if @owners.find((o) ->
      o.id is current_user_id
    ) isnt `undefined`
    return "operator" if @operatorships.find((o) ->
      o.id is current_user_id
    ) isnt `undefined`
    null

  # Returns owner names nicely formatted. Returns "Nobody" is owners is empty. Does not list
  # inherited ownerships, only the entity that granted the inheriting.
  ownerNames: ->
    owner_names = @owners.filter((role_assignment) ->
        role_assignment.get('calculated') == false).map((i) -> i.get "name").join(", ")
    owner_names = "Nobody" if owner_names.length is 0
    return owner_names

  toJSON: ->
    json = {}

    json.name = @get('name')
    json.description = @get('description')

    explicit_operatorships = @operatorships.filter (operatorship) ->
      operatorship.get('calculated') == false
    if explicit_operatorships.length
      json.operatorships_attributes = _.map explicit_operatorships, (operatorship) ->
        id: operatorship.get('id')
        entity_id: operatorship.get('entity_id')
        application_id: operatorship.get('application_id')
        _destroy: operatorship.get('_destroy')

    json.owner_ids = @owners.map (owner) -> owner.id
    json.url = @get('url')

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

  # Maintain alphabetical order
  comparator: (application) ->
    return application.get("name")
)
