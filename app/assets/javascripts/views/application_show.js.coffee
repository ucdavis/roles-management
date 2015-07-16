DssRm.Views.ApplicationShow ||= {}

class DssRm.Views.ApplicationShow extends Backbone.View
  tagName: "div"
  id: "applicationShowModal"
  className: "modal"

  events:
    "click #apply"             : "save"
    "click a#delete"           : "deleteApplication"
    "hidden"                   : "cleanUpModal"
    "click button#add_role"    : "addRole"
    "click button#remove_role" : "removeRole"
    "change table#roles input" : "persistRoleChanges"

  initialize: ->
    @$el.html JST["templates/applications/show"](application: @model)
    @listenTo @model, "sync", @render
    @listenTo @model.roles, "add remove", @renderRoles

    @$("input[name=owners]").tokenInput Routes.entities_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      onAdd: (item) => @model.owners.add item
      onDelete: (item) => @model.owners.remove item

    @$("input[name=operators]").tokenInput Routes.entities_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      onAdd: (item) =>
        @model.operatorships.add
          calculated: false
          entity_id: item.id
          application_id: @model.get('id')
          name: item.name
      onDelete: (item) =>
        # Did they delete a normal operator or calculated member?
        # You cannot delete a calculated operator - you must delete the group that granted the calculation
        if item.calculated
          alert 'You cannot remove a calculated operatorship. You must remove the group which is granting the calculation.'
        else
          # Normal member being removed - no rule needed
          operatorship = @model.operatorships.get(item.id)
          operatorship.set('_destroy', true)

    #@initializeIconFileDrop() if DssRm.admin_logged_in()

  initializeIconFileDrop: ->
    @$('#app-icon').filedrop
      url: Routes.application_path(@model.id)
      paramname: 'application[icon]'
      requestType: 'PUT'

      headers:
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')

      error: (err, file) ->
        switch err
          when "BrowserNotSupported"
            alert "Your browser does not appear to support HTML5 drag and drop. Cannot update icon."

        #   # user uploaded more than 'maxfiles'
        #   when "TooManyFiles", "FileTooLarge"
        #
        # # program encountered a file whose size is greater than 'maxfilesize'
        # # FileTooLarge also has access to the file which was too large
        # # use file.name to reference the filename of the culprit file
        # , "FileTypeNotAllowed"
        #
        # # The file type is not in the specified list 'allowedfiletypes'
        # , "FileExtensionNotAllowed"
        #
        #   # The file extension is not in the specified list 'allowedfileextensions'
        #   else

      allowedfiletypes: ["image/jpeg", "image/png", "image/gif"]
      allowedfileextensions: [".jpg", ".jpeg", ".png", ".gif"]
      maxfiles: 1
      maxfilesize: 1 # MB

      uploadFinished: (i, file, response, time) =>
         @$('img#app-icon').attr('src', response.icon)

    #   # response is the data you got back from server in JSON format.
    #   progressUpdated: (i, file, progress) ->
    #
    #

  render: ->
    # Summary tab
    @$("h3").html @model.escape('name')
    @$("input[name=name]").val @model.get('name')
    @$("input[name=description]").val @model.get('description')
    @$("input[name=url]").val @model.get('url')
    @$('img#app-icon').attr('src', @model.get('icon')) if @model.get('icon')

    owners_tokeninput = @$("input[name=owners]")
    owners_tokeninput.tokenInput "clear"
    @model.owners.each (owner) ->
      owners_tokeninput.tokenInput "add",
        id: owner.get('id')
        name: owner.get('name')

    operators_tokeninput = @$("input[name=operators]")
    operators_tokeninput.tokenInput "clear"
    @model.operatorships.each (operatorship) ->
      unless operatorship.get('_destroy') or operatorship.get('calculated')
        operators_tokeninput.tokenInput "add",
          id: operatorship.id
          name: operatorship.get('name')
          calculated: operatorship.get('calculated')
          #class: (if operatorship.get('calculated') then "calculated" else "")

    @$("a#csv-download").attr "href", Routes.application_path(@model.id, {format: 'csv'})

    if DssRm.admin_logged_in()
      @$('a#delete').show()

    @renderRoles()

    # Active Directory tab
    @$("div#ad_fields").empty()
    @model.roles.each (role) =>
      roleItem = new DssRm.Views.ApplicationShowAD(model: role)
      roleItem.render()
      @$("div#ad_fields").append roleItem.el

    @

  renderRoles: ->
    # Roles tab
    @$("table#roles tbody").empty()
    @model.roles.each (role) =>
      unless role.get('_destroy')
        roleItem = new DssRm.Views.ApplicationShowRole(model: role)
        roleItem.render()
        @$("table#roles tbody").append roleItem.el

  save: ->
    @$('#apply').attr('disabled', 'disabled').html('Saving ...')

    # Update the model silently, then save
    @model.set
      name: @$("input[name=name]").val()
      description: @$("input[name=description]").val()
      url: @$("input[name=url]").val()
    ,
      silent: true

    @$("input[name=ad_path]").each (i, e) =>
      role_id = $(e).data("role-id")
      value = $(e).val()
      r = @model.roles.find((r) ->
        r.id is role_id
      )
      if r
        r.set
          ad_path: value
        ,
          silent: true

    @model.save {},
      success: =>
        @$('#apply').removeAttr('disabled').html('Apply Changes')

        # Did we remove a role that was highlighted? If so, adjust DssRm.view_state accordingly
        if DssRm.view_state.get('selected_application_id') == @model.id
          unset_view_state_selection = true
          selected_role_id = DssRm.view_state.get('selected_role_id')
          r = @model.roles.find (r) -> r.id is selected_role_id
          if r
            # Selected role still exists, don't unset the view_state unless it was marked for destruction
            unless r.get('_destroy')
              unset_view_state_selection = false

          if unset_view_state_selection
            DssRm.view_state.set
              selected_application_id: null
              selected_role_id: null
              focused_application_id: null
              focused_entity_id: null

        @render()

      error: ->
        @$('#apply').addClass('btn-danger').html('Error')

      wait: true

    false

  deleteApplication: ->
    @$el.fadeOut()

    bootbox.confirm "Are you sure you want to delete " + @model.escape("name") + "?", (result) =>
      @$el.fadeIn()

      if result
        # Adjust view_state if we're deleting the selected application
        if DssRm.view_state.get('selected_application_id') == @model.id
          DssRm.view_state.set
            selected_application_id: null
            selected_role_id: null
            focused_application_id: null
            focused_entity_id: null

        # Delete the application and dismiss the dialog
        @model.destroy()

        # Dismiss the dialog
        @$(".modal-header a.close").trigger "click"

      # Ensure applications_index is updated
      else


    # do nothing - do not delete
    false

  cleanUpModal: ->
    @remove()

    # Need to change URL in case they want to open the same modal again
    Backbone.history.navigate "index"

  addRole: (e) ->
    e.preventDefault()

    # the false ID simply needs to be unique in case the 'remove' button is hit - our backend will provide a proper ID on saving
    @model.roles.add {}

  removeRole: (e) ->
    e.preventDefault()

    role_cid = $(e.target).parents("tr").data("role_cid")
    role = @model.roles.get role_cid
    role.set('_destroy', true)
    @renderRoles()

  # Copies the attributes of roles out of the DOM and into our model
  persistRoleChanges: (e) ->
    role_cid = $(e.target).parents("tr").data("role_cid")
    role = @model.roles.get role_cid

    switch $(e.target).attr('name')
      when 'name'
        role.set 'name', $(e.target).val(), { silent: true }
      when 'token'
        role.set 'token', $(e.target).val(), { silent: true }
      when 'description'
        role.set 'description', $(e.target).val(), { silent: true }
