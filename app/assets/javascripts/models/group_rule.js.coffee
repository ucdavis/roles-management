DssRm.Models.GroupRule = Backbone.Model.extend(
  initialize: ->
    @fetchRuleMetadata()
  
  # Fetch any needed metadata about this rule, e.g. 'department' rule values are department codes
  # but we often need their department display name as well (considered metadata).
  fetchRuleMetadata: ->
    if @get('column') in ['department', 'appt_department', 'admin_department']
      $.ajax(
        url: Routes.departments_path() + "/code/" + @get('value') # value is dept_code
        type: "GET"
      ).success (data) =>
        @set
          'officialName': data.department.officialName
          'code': data.department.code
    else if @get('column') == 'title'
      $.ajax(
        url: Routes.titles_path() + "/code/" + @get('value') # value is title code
        type: "GET"
      ).success (data) =>
        @set
          'name': data.name
          'code': data.code

)

DssRm.Collections.GroupRules = Backbone.Collection.extend(
  model: DssRm.Models.GroupRule
)
