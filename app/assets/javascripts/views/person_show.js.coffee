DssRm.Views.PersonShow ||= {}

class DssRm.Views.PersonShow extends Backbone.View
  tagName: "div"
  className: "modal"
  id: "entityShowModal"

  events:
    "click #apply"                                  : "save"
    "click a#rescan"                                : "rescan"
    "hidden"                                        : "cleanUpModal"
    "click #delete"                                 : "deleteEntity"
    "click #add_role_assignment_application_button" : "addRoleAssignmentApplication"

  initialize: ->
    @$el.html JST["templates/entities/show_person"](model: @model)
    @listenTo @model, "sync", @resetRolesTab
    @listenTo @model, "sync", @render
    @readonly = @model.isReadOnly()

    @initializeRelationsTab()
    @initializeRolesTab()
    @initializeActivityTab()

  initializeRelationsTab: ->
    @$("input[name=favorites]").tokenInput Routes.people_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      disabled: @readonly
      onAdd: (item) =>
        @model.favorites.add
          id: item.id
          name: item.name
      onDelete: (item) =>
        @model.favorites.remove(item.id)

    @$("input[name=group_ownerships]").tokenInput Routes.groups_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      disabled: @readonly
      onAdd: (item) =>
        @model.group_ownerships.add
          entity_id: @model.get('id')
          group_id: item.id
          name: item.name
      onDelete: (item) =>
        ownership = @model.group_ownerships.get(item.id)
        ownership.set('_destroy', true)

    @$("input[name=group_operatorships]").tokenInput Routes.groups_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      disabled: @readonly
      onAdd: (item) =>
        @model.group_operatorships.add
          entity_id: @model.get('id')
          group_id: item.id
          name: item.name
      onDelete: (item) =>
        operatorship = @model.group_operatorships.get(item.id)
        operatorship.set('_destroy', true)

    @$("input[name=group_memberships]").tokenInput Routes.groups_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      disabled: @readonly
      onAdd: (item) =>
        @model.group_memberships.add
          group_id: item.id
          entity_id: @model.get('id')
          name: item.name
          calculated: false
      onDelete: (item) =>
        membership = @model.group_memberships.get(item.id)
        membership.set('_destroy', true)

    @$("input[name=organization_associations]").tokenInput Routes.organizations_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      disabled: true #@readonly
      onAdd: (item) =>
        @model.organizations.add
          id: item.id
          name: item.name
      onDelete: (item) =>
        organization = @model.organizations.get(item.id)
        organization.set('_destroy', true)

  initializeRolesTab: ->
    @$("#add_role_assignment_application_search").typeahead
      minLength: 3
      sorter: (items) -> # required to keep the order given to process() in 'source'
        items
      highlighter: (item) ->
        parts = item.split("####")
        item = parts[1] # See: https://gist.github.com/3694758 (FIXME when typeahead supports passing objects)
        query = @query.replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g, "\\$&")
        ret = item.replace(new RegExp("(" + query + ")", "ig"), ($1, match) ->
          "<strong>" + match + "</strong>"
        )
        ret = ret + parts[2]  if parts[2] isnt `undefined`
        ret
      source: @roleAssignmentApplicationSearch
      updater: (item) =>
        @roleAssignmentApplicationSearchResultSelected item, @
      items: 5

  initializeActivityTab: ->
    $activityTable = @$("tbody#activity_log")
    $activityTable.empty()
    
    $.ajax(
      url: Routes.entity_path(@model.id) + "/activity"
      type: 'GET'
    ).done( (res) =>
      _.each res.activities, (entry) =>
        $activityTable.append @renderActivityLogRow(entry)
    ).fail( (data) ->
    #   toastr["error"]("An error occurred while fetching the activity logs. Try again later.")
    )
  
  # Renders a single Activity Log row.
  renderActivityLogRow: (entry) ->
    $row = $("<tr><td>#{entry.message}</td><td>#{jQuery.timeago(entry.performed_at)}</td></tr>")
    return $row

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
      onAdd: (item) =>
        @model.role_assignments.add
          role_id: item.id
          entity_id: @model.get('id')
          name: item.name
          calculated: false
      onDelete: (item) =>
        assignment = @model.role_assignments.get(item.id)
        assignment.set('_destroy', true)

    return $input

  render: ->
    @$("h3").html @model.escape("name")
    @$("h5").html @model.escape("byline")

    # Summary tab
    @$("input[name=first]").val @model.escape("first")
    @$("input[name=last]").val @model.escape("last")
    @$("input[name=email]").val @model.escape("email")
    @$("input[name=loginid]").val @model.escape("loginid")
    @$("input[name=phone]").val @formatPhone(@model.get("phone"))
    @$("input[name=address]").val @model.get("address")

    if @model.get("active")
      @$('button#status-active').addClass 'active'
      @$('button#status-inactive').removeClass 'active'
    else
      @$('button#status-active').removeClass 'active'
      @$('button#status-inactive').addClass 'active'

    favorites_tokeninput = @$("input[name=favorites]")
    favorites_tokeninput.tokenInput "clear"
    @model.favorites.each (favorite) =>
      favorites_tokeninput.tokenInput "add",
        id: favorite.get('id')
        name: favorite.get('name')
        readonly: @readonly

    group_ownership_tokeninput = @$("input[name=group_ownerships]")
    group_ownership_tokeninput.tokenInput "clear"
    @model.group_ownerships.each (ownership) =>
      unless ownership.get('_destroy')
        group_ownership_tokeninput.tokenInput "add",
          id: ownership.get('id')
          name: ownership.get('name')
          readonly: @readonly

    group_operatorship_tokeninput = @$("input[name=group_operatorships]")
    group_operatorship_tokeninput.tokenInput "clear"
    @model.group_operatorships.each (operatorship) =>
      unless operatorship.get('_destroy')
        group_operatorship_tokeninput.tokenInput "add",
          id: operatorship.get('id')
          name: operatorship.get('name')
          readonly: @readonly

    group_membership_tokeninput = @$("input[name=group_memberships]")
    group_membership_tokeninput.tokenInput "clear"
    @model.group_memberships.each (membership) =>
      unless membership.get('_destroy')
        group_membership_tokeninput.tokenInput "add",
          id: membership.get('id')
          name: membership.get('name')
          readonly: @readonly || membership.get('calculated')
          class: (if membership.get('calculated') then "calculated" else "")

    organization_association_tokeninput = @$("input[name=organization_associations]")
    organization_association_tokeninput.tokenInput "clear"
    @model.organizations.each (organization) =>
      unless organization.get('_destroy')
        organization_association_tokeninput.tokenInput "add",
          id: organization.get('id')
          name: organization.get('name')
          readonly: true
          class: "calculated"

    # Roles tab
    $rolesTab = @$("div#role_assignments")
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
            readonly: @readonly || role_assignment.get('calculated')
            class: (if role_assignment.get('calculated') then "calculated" else "")

    if @readonly
      @$('.token-input-list-facebook').readonly()
      @$('input').readonly()
      @$('textarea').readonly()
      @$('#roles #add_application').hide()

    @

  save: (e) ->
    e.preventDefault()

    unless @model.isReadOnly()
      @$('#apply').attr('disabled', 'disabled').html('Saving ...')

      @model.set
        first: @$("input[name=first]").val()
        last: @$("input[name=last]").val()
        email: @$("input[name=email]").val()
        loginid: @$("input[name=loginid]").val()
        phone: @$("input[name=phone]").val().replace(/\D/g, '') # strip out non-numeric characters
        address: @$("input[name=address]").val()
        active: @$('button#status-active').hasClass('active')

      @model.save {},
        success: ->
          @$('#apply').removeAttr('disabled').html('Apply Changes')

        error: ->
          @$('#apply').addClass('btn-danger').html('Error')

  rescan: (e) ->
    toastr["info"]("Re-scanning ...")

    # Disable all form elements while rescanning
    $('.modal-body div.tab-content').children().each (i, el) ->
      $(el).attr("disabled", true)

    @model.fetch
      url: Routes.person_import_path @model.get('loginid')
      type: 'POST'
      success: (data) ->
        # Re-enable all form elements
        $('.modal-body div.tab-content').children().each (i, el) ->
          $(el).attr("disabled", false)
        toastr.remove()
      failure: (data) ->
        toastr["error"]("An error occurred while re-scanning.")

    false

  deleteEntity: ->
    unless @model.isReadOnly()
      @$el.fadeOut()

      bootbox.confirm "Are you sure you want to delete " + @model.escape("name") + "?", (result) =>
        @$el.fadeIn()
        if result
          # delete the application and dismiss the dialog
          @model.destroy()

          # dismiss the dialog
          @$(".modal-header a.close").trigger "click"

    false

  addRoleAssignmentApplication: ->
    # Add new tokenInput to DOM
    application_id = @$("#add_role_assignment_application_search").data('selected-id')
    application_name = @$("#add_role_assignment_application_search").val()
    @$("div#role_assignments").append @renderRoleAssignmentTokenInput(application_name, application_id)

    @$("#add_role_assignment_application_search").val('')

  # Populates the role assignment application search with results via async call
  roleAssignmentApplicationSearch: (query, process) ->
    $.ajax(
      url: Routes.applications_path()
      data:
        q: query
      type: "GET"
    ).always (data) ->
      entities = []
      _.each data, (entity) ->
        entities.push entity.id + "####" + entity.name

      process entities

  roleAssignmentApplicationSearchResultSelected: (item) ->
    parts = item.split("####")
    id = parseInt(parts[0])
    label = parts[1]

    @$("#add_role_assignment_application_search").data('selected-id', id)

    label

  # Attempt to render the phone number in a more readable format.
  # Assumes phone comes in like '8005551234' or '5551234'
  formatPhone: (phone) ->
    if phone
      if phone.length == 10
        return "(#{phone.substr(0, 3)}) #{phone.substr(3, 3)}-#{phone.substr(6, 4)}"
      if phone.length == 7
        return "#{phone.substr(0, 3)}-#{phone.substr(3, 4)}"
    else
      return ""

  cleanUpModal: ->
    @remove()

    # Need to change URL in case they want to open the same modal again
    Backbone.history.navigate "index"
