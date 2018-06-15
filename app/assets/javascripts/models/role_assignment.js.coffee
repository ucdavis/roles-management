DssRm.Models.RoleAssignment = Backbone.Model.extend(
  urlRoot: Routes.role_assignments_path()
)

DssRm.Collections.RoleAssignments = Backbone.Collection.extend(
  model: DssRm.Models.RoleAssignment
  url: Routes.role_assignments_path()
)
