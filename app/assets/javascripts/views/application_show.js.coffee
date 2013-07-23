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
    "shown"                    : "adjustOverflow"

  initialize: (options) ->
    @$el.html JST["templates/applications/show"](application: @model)
    @listenTo @model, "sync", @render
    @listenTo @model.roles, "add remove", @renderRoles
    
    @$("input[name=owners]").tokenInput Routes.people_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      onAdd: (item) => @model.owners.add item
      onDelete: (item) => @model.owners.remove item

    @$("input[name=operators]").tokenInput Routes.people_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      onAdd: (item) => @model.operators.add item
      onDelete: (item) => @model.operators.remove item

  render: ->
    # Summary tab
    @$("h3").html @model.escape("name")
    @$("input[name=name]").val @model.get("name")
    @$("input[name=description]").val @model.get("description")
    
    owners_tokeninput = @$("input[name=owners]")
    owners_tokeninput.tokenInput "clear"
    @model.owners.each (owner) ->
      owners_tokeninput.tokenInput "add",
        id: owner.get('id')
        name: owner.get('name')

    operators_tokeninput = @$("input[name=operators]")
    operators_tokeninput.tokenInput "clear"
    @model.operators.each (operator) ->
      operators_tokeninput.tokenInput "add",
        id: operator.get('id')
        name: operator.get('name')

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
    
    role_id = $(e.target).parents("tr").data("role_id")
    role = @model.roles.get role_id
    role.set('_destroy', true)
    @renderRoles()
  
  # Due to a bug in Bootstrap 2.x modals, we need to adjust
  # the overflow to be off when using tokeninput tabs but
  # on when using typeahead tabs
  adjustOverflow: (e) ->
    switch $(e.target).attr('href')
      when '#roles'
        @$('.modal-body').css('overflow-y', 'visible')
        @$('.tab-content').css('overflow', 'visible')
      else
        @$('.modal-body').css('overflow-y', 'hidden')
        @$('.tab-content').css('overflow', 'auto')
