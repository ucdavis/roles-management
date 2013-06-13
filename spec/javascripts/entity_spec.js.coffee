describe "EntityModel", ->
  # Set up basic data
  beforeEach ->
    @data = getJSONFixture('dssrm.json')
    DssRm.initialize(@data)
    @entity = new DssRm.Models.Entity(@data.current_user)
  
  it "serializes role IDs to JSON correctly", ->
    calculated_role_ids = @entity.roles.map (role) -> role.get('role_id')
    serialized_role_ids = @entity.toJSON().entity.role_ids

    # Go through each calculated role id and ensure it is in serializied_role_ids
    _.each serialized_role_ids, (id) ->
      calculated_index = calculated_role_ids.indexOf id
      if calculated_index == -1
        throw new Error("toJSON() includes an unexpected role ID")
      calculated_role_ids.splice(calculated_index, 1)
    
    if calculated_role_ids.length > 0
      throw new Error("toJSON() did not include all expected role IDs")
