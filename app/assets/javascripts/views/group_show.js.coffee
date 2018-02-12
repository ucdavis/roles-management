DssRm.Views.GroupShow ||= {}

DssRm.Views.GroupShow = Backbone.View.extend(
  tagName: "div"
  className: "modal"
  id: "entityShowModal"

  events:
    "click #apply"                   : "save"
    "click button#group_rule_add"    : "addRule"
    "click button#remove_group_rule" : "removeRule"
    "hidden"                         : "cleanUpModal"
    "click #delete"                  : "deleteGroup"

  initialize: ->
    @$el.html JST["templates/entities/show_group"](model: @model)
    @listenTo @model, "sync", @resetRolesTab
    @listenTo @model, "sync", @render
    readonly = @model.isReadOnly()

    @$("input[name=owners]").tokenInput Routes.people_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      disabled: readonly
      onAdd: (item) =>
        @model.owners.add
          id: item.id
          name: item.name
      onDelete: (item) =>
        @model.owners.remove(item.id)

    @$("input[name=operators]").tokenInput Routes.people_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      disabled: readonly
      onAdd: (item) =>
        @model.operators.add
          id: item.id
          name: item.name
      onDelete: (item) =>
        @model.operators.remove(item.id)

    @$("input[name=memberships]").tokenInput Routes.people_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      disabled: readonly
      onAdd: (item) =>
        @model.memberships.add
          loginid: item.loginid
          entity_id: item.id
          group_id: @model.get('id')
          name: item.name
      onDelete: (item) =>
        # Did they delete a normal member or calculated member?
        # Deleting calculated members requires a new rule be created
        if item.calculated
          # Calculated member requires a new rule
          @model.rules.add
            id: 'new_' + (new Date).getTime()
            column: 'loginid'
            condition: 'is not'
            value: item.loginid
          @renderRules()
        else
          # Normal member being removed - no rule needed
          membership = @model.memberships.get(item.id)
          if membership
            membership.set('_destroy', true)
          else
            # They added a token that was never saved and are now removing it.
            membership = @model.memberships.find (i) ->
              i.get('entity_id') == item.id
            @model.memberships.remove membership
    
    @initializeActivityTab()

  initializeActivityTab: ->
    if DssRm.admin_logged_in()
      $.ajax(
        url: Routes.entity_path(@model.id) + "/activity"
        type: 'GET'
      ).done( (res) =>
        # Store pagination and calculate number of pages
        @activity = res.activities
        
        @activityView = new DssRm.Views.ActivityTable(
          model: @activity
        ).render()

        @$("#activity-pane").append(@activityView.el)
      ).fail( (data) ->
        toastr["error"]("An error occurred while fetching the activity logs. Try again later.")
      )
    else
      # Hide the tab as user is not admin
      @$(".tab-pane#activity-pane").hide()
      @$("ul.nav>li#activity").hide()

  render: ->
    readonly = @model.isReadOnly()

    # Summary tab
    @$("h3").html @model.escape("name")
    @$("input[name=name]").val @model.get("name")
    @$("textarea[name=description]").val @model.get("description")
    @$("span#group_member_count").html (@model.memberships.filter( (m) -> m.get('active') ).length + @model.rule_members.filter( (m) -> m.get('active') ).length)

    owners_tokeninput = @$("input[name=owners]")
    owners_tokeninput.tokenInput "clear"
    @model.owners.each (owner) ->
      unless owner.get('_destroy')
        owners_tokeninput.tokenInput "add",
          id: owner.get('id')
          name: owner.get('name')

    operators_tokeninput = @$("input[name=operators]")
    operators_tokeninput.tokenInput "clear"
    @model.operators.each (operator) ->
      unless operator.get('_destroy')
        operators_tokeninput.tokenInput "add",
          id: operator.get('id')
          name: operator.get('name')

    members_tokeninput = @$("input[name=memberships]")
    members_tokeninput.tokenInput "clear"
    @model.memberships.each (membership) ->
      unless membership.get('_destroy') || (membership.get('active') == false)
        members_tokeninput.tokenInput "add",
          id: membership.id
          entity_id: membership.get('entity_id')
          name: membership.get('name')
          loginid: membership.get('loginid')
          calculated: false
          class: ""
    @model.rule_members.each (rule_member) ->
      unless (rule_member.get('active') == false)
        members_tokeninput.tokenInput "add",
          entity_id: rule_member.get('person_id')
          name: rule_member.get('name')
          loginid: rule_member.get('loginid')
          calculated: true
          class: "calculated"

    @$("a#csv-download").attr "href", Routes.entity_path(@model.id, {format: 'csv'})

    # Roles tab
    $rolesTab = @$("div#role_assignments")
    if @model.role_assignments.length == 0
      $rolesTab.append("<center><i>Group has no role assignments.</i></center>")
    else
      _.each @model.role_assignments.groupBy("application_name"), (role_assignment_set) =>
        app_name = role_assignment_set[0].get("application_name")
        app_id = role_assignment_set[0].get("application_id")

        role_tokeninput = @$("input[name=_token_input_" + app_id + "]")
        role_tokeninput.tokenInput "clear"
        _.each role_assignment_set, (role_assignment) ->
          unless role_assignment.get('_destroy')
            role_tokeninput.tokenInput "add",
              id: role_assignment.get("id")
              role_id: role_assignment.get("role_id")
              entity_id: role_assignment.get("entity_id")
              name: role_assignment.get("name")
              readonly: @readonly || true
              class: (if role_assignment.get('calculated') then "calculated" else "")

    if DssRm.admin_logged_in() || @model.relationship()
      @$("#delete").show()

    if readonly
      @$('.token-input-list-facebook').readonly()
      @$('input').readonly()
      @$('textarea').readonly()
      @$('button#apply').hide()
      @$('a#delete').hide()

    @renderRules()

    @

  renderRules: ->
    readonly = @model.isReadOnly()

    rules_table = @$("table#rules tbody")
    rules_table.empty()
    @model.rules.each (rule, i) =>
      unless rule.get('_destroy')
        rules_table.append @renderRule(rule)

    if @model.rules.length is 0
      rules_table.hide()
    else
      rules_table.show()

    if readonly
      @$('button#remove_group_rule').hide()
      @$('button#group_rule_add').hide()
      @$('select').attr('disabled', true)
      @$('input').readonly()

    @

  # Renders a single rule. Does not add to DOM.
  renderRule: (rule) ->
    _column = rule.get('column')
    _condition = rule.get('condition')
    _value = rule.get('value')

    $rule = $(JST["templates/entities/group_rule"]())

    $rule.data "rule_cid", rule.cid
    switch _column
      when 'is_employee'
        $rule.find("td:nth-child(1) select").val 'iam_affiliation'
        $rule.find("td:nth-child(2) select").val _condition
        $rule.find("td:nth-child(3) input").val 'Employee'
      when 'is_faculty'
        $rule.find("td:nth-child(1) select").val 'iam_affiliation'
        $rule.find("td:nth-child(2) select").val _condition
        $rule.find("td:nth-child(3) input").val 'Faculty'
      when 'is_staff'
        $rule.find("td:nth-child(1) select").val 'iam_affiliation'
        $rule.find("td:nth-child(2) select").val _condition
        $rule.find("td:nth-child(3) input").val 'Staff'
      when 'is_student'
        $rule.find("td:nth-child(1) select").val 'iam_affiliation'
        $rule.find("td:nth-child(2) select").val _condition
        $rule.find("td:nth-child(3) input").val 'Student'
      when 'is_hs_employee'
        $rule.find("td:nth-child(1) select").val 'iam_affiliation'
        $rule.find("td:nth-child(2) select").val _condition
        $rule.find("td:nth-child(3) input").val 'HS Employee'
      when 'is_external'
        $rule.find("td:nth-child(1) select").val 'iam_affiliation'
        $rule.find("td:nth-child(2) select").val _condition
        $rule.find("td:nth-child(3) input").val 'External'
      when 'pps_position_type'
        $rule.find("td:nth-child(1) select").val _column
        $rule.find("td:nth-child(2) select").val _condition
        $rule.find("td:nth-child(3) input").val DssRm.Views.GroupShow.pps_position_types[_value]
      else
        $rule.find("td:nth-child(1) select").val _column
        $rule.find("td:nth-child(2) select").val _condition
        $rule.find("td:nth-child(3) input").val _value

    $rule.find("td:nth-child(3) input").typeahead
      minLength: 2
      sorter: (items) -> # required to keep the order given to process() in 'source'
        items

      highlighter: (item) ->
        item = item.split("####")[1] # See: https://gist.github.com/3694758 (FIXME when typeahead supports passing objects)
        query = @query.replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g, "\\$&")
        item.replace new RegExp("(" + query + ")", "ig"), ($1, match) ->
          "<strong>" + match + "</strong>"

      source: @ruleSearch
      updater: (item) =>
        @ruleSearchResultSelected item, @

    return $rule

  resetRolesTab: ->
    $rolesTab = @$("div#role_assignments")
    $rolesTab.empty()

    _.each @model.role_assignments.groupBy("application_name"), (role_assignment_set) =>
      application_name = role_assignment_set[0].get("application_name")
      application_id = role_assignment_set[0].get("application_id")

      $rolesTab.append @renderRoleAssignmentTokenInput(application_name, application_id)

  # Renders and initializes a single tokenInput for the role (assignment) tab.
  # Does not insert into DOM.
  renderRoleAssignmentTokenInput: (name, id) ->
    $input = $("<p><label for=\"_token_input_#{id}\">#{name}</label><input type=\"text\" name=\"_token_input_#{id}\" class=\"token_input\" /></p>")
    $input.find("input").tokenInput Routes.roles_path() + "?application_id=#{id}",
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      disabled: @readonly
      # onAdd: (item) =>
      #   @model.role_assignments.add
      #     role_id: item.id
      #     entity_id: @model.get('id')
      #     name: item.name
      #     calculated: false
      # onDelete: (item) =>
      #   assignment = @model.role_assignments.get(item.id)
      #   assignment.set('_destroy', true)

    return $input

  save: (e) ->
    e.preventDefault()

    @$('#apply').attr('disabled', 'disabled').html('Saving ...')

    # Update @model.rules with any changes made in the UI
    _.each $('table#rules>tbody>tr'), (el, i) =>
      cid = $(el).data('rule_cid')
      rule = @model.rules.get(cid)
      _column = $(el).find("#column").val()
      _condition = $(el).find("#condition").val()
      _value = $(el).find("#value").val()

      switch _column
        when "iam_affiliation"
          # do something
          switch _value
            when "Employee"
              rule.set
                column: 'is_employee'
                condition: _condition
                value: 't'
            when "Faculty"
              rule.set
                column: 'is_faculty'
                condition: _condition
                value: 't'
            when "Staff"
              rule.set
                column: 'is_staff'
                condition: _condition
                value: 't'
            when "Student"
              rule.set
                column: 'is_student'
                condition: _condition
                value: 't'
            when "HS Employee"
              rule.set
                column: 'is_hs_employee'
                condition: _condition
                value: 't'
            when "External"
              rule.set
                column: 'is_external'
                condition: _condition
                value: 't'
        when "pps_position_type"
          rule.set
            column: _column
            condition: _condition
            value: _.findKey DssRm.Views.GroupShow.pps_position_types, (val) -> val == _value
        else
          rule.set
            column: _column
            condition: _condition
            value: _value

    # Note: the _.filter() on rules is to avoid saving empty rules (rules with no value set)
    @model.save
      name: @$('input[name=name]').val()
      description: @$('textarea[name=description]').val()
    ,
      success: ->
        DssRm.current_user.fetch() # refresh the current user to update their favorites in case we renamed a favorite group
        @$('#apply').removeAttr('disabled').html('Apply Changes')
      error: ->
        @$('#apply').addClass('btn-danger').html('Error')

  deleteGroup: ->
    @$el.fadeOut()

    bootbox.confirm 'Are you sure you want to delete ' + @model.escape('name') + '?', (result) =>
      @$el.fadeIn()
      if result
        toastr["info"]("Deleting group ...")
        # Delete the group
        @model.destroy
          success: () ->
            DssRm.current_user.fetch() # a GroupOwnership may have been destroyed if they deleted
                                       # their own group. This will be properly reflected after a .fetch().
                                       # Without this, the frontend is inconsistent and may submit invalid
                                       # GroupOwnership IDs to the backend.
            toastr.remove()
            toastr["success"]("Group deleted.")
            # Dismiss the dialog
            @$(".modal-header a.close").trigger "click"
          error: () ->
            toastr.remove()
            toastr["error"]("Unable to delete group. Try again later.")

    false

  # Renders a new rule and returns jQuery object
  addRule: (e) ->
    @model.rules.add {}
      #id: 'new_' + (new Date).getTime()
    @renderRules()

  removeRule: (e) ->
    rule_cid = $(e.target).parents("tr").data("rule_cid")
    rule = @model.rules.get rule_cid
    rule.set('_destroy', true)
    @renderRules()

  cleanUpModal: ->
    @remove()

    # Need to change URL in case they want to open the same modal again
    Backbone.history.navigate "index"

  # Populates the sidebar search with results via async call
  ruleSearch: (query, process, e) ->
    lookahead_type = @$element.parents("tr").find("td:first select").val()
    lookahead_url = ""
    switch lookahead_type
      when "major"
        lookahead_url = Routes.majors_path()
      when "department"
        lookahead_url = Routes.departments_path()
      when "organization"
        lookahead_url = Routes.organizations_path()
      when "loginid"
        lookahead_url = Routes.people_path()
      when "title"
        lookahead_url = Routes.titles_path()
      when "business_office_unit"
        lookahead_url = Routes.business_office_units_path()
      when "affiliation"
        lookahead_url = Routes.affiliations_path()
      when "iam_affiliation"
        entities = ['0####Employee', '1####Faculty', '2####Staff', '3####Student', '4####HS Employee', '5####External']
        process entities
        return
      when "pps_position_type"
        entities = []
        _.each DssRm.Views.GroupShow.pps_position_types, (position_type, i) ->
          entities.push "#{i}#####{position_type}"
        process entities
        return
      when "pps_unit"
        entities = []
        _.each DssRm.Views.GroupShow.pps_units, (unit, i) ->
          entities.push "#{i}#####{unit}"
        process entities
        return
      when "sis_level_code"
        entities = []
        _.each DssRm.Views.GroupShow.sis_level_codes, (code, i) ->
          entities.push "#{i}#####{code}"
        process entities
        return

    $.ajax(
      url: lookahead_url
      data:
        q: query

      type: "GET"
    ).always (data) ->
      entities = []
      _.each data, (entity) ->
        if lookahead_type is "loginid"
          entities.push entity.id + "####" + entity.loginid
        else
          entities.push entity.id + "####" + entity.name

      process entities

  ruleSearchResultSelected: (item) ->
    parts = item.split("####")
    id = parseInt(parts[0])
    label = parts[1]
    label
,
  pps_position_types:
    1: 'Contract'
    2: 'Regular/Career'
    3: 'Limited, Formerly Casual'
    4: 'Casual/RESTRICTED-Students'
    5: 'Academic'
    6: 'Per Diem'
    7: 'Regular/Career Partial YEAR'
    8: 'Floater'
  
  pps_units: ['PA','EX','HX','RX','NX','K3','F3','87','99','LX','M3','DX','PX','IX','CX','BX','A3','GS','PSS','FX','SX','TX']

  sis_level_codes: ['GR','UG','LW','MD']
)
