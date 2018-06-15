DssRm.Models.Role = Backbone.Model.extend(
  urlRoot: "/roles"

  initialize: ->
    @resetNestedCollections()
    @on 'sync', @resetNestedCollections, this

  resetNestedCollections: ->
    if @assignments is `undefined`
      @assignments = new DssRm.Collections.RoleAssignments
      @assignments.comparator = (assignment) -> assignment.get('type') + assignment.get('name')

    # Reset nested collection data
    @assignments.reset @get('assignments')

    # Enforce the design pattern by removing from @attributes what is represented in a nested collection
    delete @attributes.assignments

  tokenize: (str) ->
    String(str).replace(RegExp(" ", "g"), "-").replace(/'/g, "").replace(/"/g, "").toLowerCase()

  # Returns true if the entity is assigned to this role
  # Accepts an entity or an entity_id
  # If 'include_calcualted' is false, has_assigned will not return
  # an entity which is technically assigned to this role if it is via
  # a calculated assignment.
  has_assigned: (entity, include_calculated = true) ->
    if entity.get == undefined
      # Looks like 'entity' is an ID
      id = entity
    else
      # Looks like 'entity' is a model
      id = (entity.get('group_id') || entity.id)

    # Use 'filter' as the entity_id may appear in multiple assignments
    results = @assignments.filter (a) =>
      (a.get('entity_id') == id) && ((a.get('calculated') == false) or include_calculated)

    return results.length

  toJSON: ->
    json = {}

    json.name = @get('name')
    json.token = @get('token')
    json.description = @get('description')
    json.ad_path = @get('ad_path')

    # Note we use Rails' nested attributes here
    if @assignments.length
      json.role_assignments_attributes = @assignments.map (assignment) =>
        id: assignment.get('id')
        entity_id: assignment.get('entity_id')
        role_id: @get('id')
        _destroy: assignment.get('_destroy')

    role: json
)

DssRm.Collections.Roles = Backbone.Collection.extend(
  model: DssRm.Models.Role
  url: "/roles"

  # Ensure role collections are sorted alphabetically
  comparator: (role) ->
    return role.get("name")
)
