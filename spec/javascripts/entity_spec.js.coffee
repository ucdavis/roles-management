describe "EntityModel", ->
  # Set up basic data
  beforeEach ->
    @data = getJSONFixture('dssrm.json')
    DssRm.initialize(@data)
    @entity = new DssRm.Models.Entity(@data.current_user)
  
  it "serializes role assignment IDs to JSON correctly", ->
    calculated_role_assignment_ids = @entity.role_assignments.map (role_assignment) -> role_assignment.get('id')
    serialized_role_assignment_ids = @entity.toJSON().entity.role_assignments_attributes.map (role_assignment) -> role_assignment.id
    
    jasmine.log 'here1'
    jasmine.log @entity.role_assignments
    jasmine.log 'here2'
    jasmine.log serialized_role_assignment_ids 
    jasmine.log 'here3'
    
    # Go through each calculated role id and ensure it is in serializied_role_ids
    _.each serialized_role_assignment_ids, (id) ->
      calculated_index = calculated_role_assignment_ids.indexOf id
      if calculated_index == -1
        throw new Error("toJSON() includes an unexpected role ID")
      calculated_role_assignment_ids.splice(calculated_index, 1)
    
    jasmine.log calculated_role_assignment_ids
    
    if calculated_role_assignment_ids.length > 0
      throw new Error("toJSON() did not include all expected role IDs")

    jasmine.log '4'
    jasmine.log @entity.hey