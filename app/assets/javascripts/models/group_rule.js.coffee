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
    if @get('column') in ['business_office_unit', 'admin_business_office_unit', 'appt_business_office_unit']
      $.ajax(
        url: Routes.business_office_units_path() + "/code/" + @get('value') # value is org_oid
        type: "GET"
      ).success (data) =>
        @set
          'dept_official_name': data.business_office_unit.dept_official_name
          'code': data.business_office_unit.org_oid
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
