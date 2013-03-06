DssRm.Views.ApplicationShow = Support.CompositeView.extend(
  tagName: "div"
  events:
    "click a#apply": "saveApplication"
    "click a#delete": "deleteApplication"
    "hidden": "cleanUpModal"
    "click button#add_role": "addRole"
    "click button#remove_role": "removeRole"
    "change table#roles input": "storeRoleChanges"
    "click button#sympa_url": "sympaUrl"

  initialize: (options) ->
    self = this
    @model.roles.on "add remove", @render, this
    @$el.html JST["applications/show"](application: @model)
    @$("input[name=owners]").tokenInput Routes.people_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      onAdd: (item) ->
        self.model.owners.add item

      onDelete: (item) ->
        self.model.owners.remove item

    @$("input[name=operators]").tokenInput Routes.people_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      onAdd: (item) ->
        self.model.operators.add item

      onDelete: (item) ->
        self.model.operators.remove item


  render: ->
    self = this
    
    # Summary tab
    self.$("h3").html @model.escape("name")
    self.$("input[name=name]").val @model.get("name")
    self.$("input[name=description]").val @model.get("description")
    owners_tokeninput = self.$("input[name=owners]")
    owners_tokeninput.tokenInput "clear"
    _.each @model.get("owners"), (owner) ->
      owners_tokeninput.tokenInput "add",
        id: owner.id
        name: owner.name


    operators_tokeninput = self.$("input[name=operators]")
    operators_tokeninput.tokenInput "clear"
    _.each @model.get("operators"), (operator) ->
      operators_tokeninput.tokenInput "add",
        id: operator.id
        name: operator.name


    @$("span#csv-download>a").attr "href", Routes.application_path(@model.id) + ".csv"
    
    # Roles tab
    self.$("table#roles tbody").empty()
    @model.roles.each (role) ->
      roleItem = new DssRm.Views.ApplicationShowRole(model: role)
      self.renderChild roleItem
      self.$("table#roles tbody").append roleItem.el

    
    # Active Directory tab
    self.$("div#ad_fields").empty()
    @model.roles.each (role) ->
      roleItem = new DssRm.Views.ApplicationShowAD(model: role)
      self.renderChild roleItem
      self.$("div#ad_fields").append roleItem.el

    this

  saveApplication: ->
    self = this
    status_bar.show "Saving application ..."
    
    # Update the model silently, then save
    @model.set
      name: @$("input[name=name]").val()
      description: @$("input[name=description]").val()
    ,
      silent: true

    @$("input[name=ad_path]").each (i, e) ->
      role_id = $(e).data("role-id")
      value = $(e).val()
      r = self.model.roles.find((r) ->
        r.id is role_id
      )
      if r
        r.set
          ad_path: value
        ,
          silent: true


    @model.save {},
      success: ->
        status_bar.hide()
        self.render()

      error: ->
        status_bar.show "An error occurred while saving the application.", "error"

      wait: true

    false

  deleteApplication: ->
    self = this
    self.$el.fadeOut()
    bootbox.confirm "Are you sure you want to delete " + @model.escape("name") + "?", (result) ->
      self.$el.fadeIn()
      if result
        
        # delete the application and dismiss the dialog
        self.model.destroy()
        
        # dismiss the dialog
        self.$(".modal-header a.close").trigger "click"
      
      # Ensure applications_index is updated
      else

    
    # do nothing - do not delete
    false

  cleanUpModal: ->
    @model.roles.off "add remove", @render, this
    $("div#applicationShowModal").remove()
    
    # Need to change URL in case they want to open the same modal again
    Backbone.history.navigate ""

  addRole: ->
    
    # the false ID simply needs to be unique in case the 'remove' button is hit - our backend will provide a proper ID on saving
    @model.roles.add id: "new_" + Math.round((new Date()).getTime())
    false

  removeRole: (e) ->
    role_id = $(e.target).parents("tr").data("role_id")
    role = @model.roles.find((r) ->
      r.id is role_id
    )
    @model.roles.remove role
    false

  storeRoleChanges: (e) ->
    role_id = $(e.target).parents("tr").data("role_id")
    role = @model.roles.find((e) ->
      e.id is role_id
    )
    role.set
      token: $(e.target).parents("tr").find("input[name=token]").val()
      default: $(e.target).parents("tr").find("input[name=default]").attr("checked") is "checked"
      name: $(e.target).parents("tr").find("input[name=name]").val()
      description: $(e.target).parents("tr").find("input[name=description]").val()

    true

  sympaUrl: (e) ->
    role_id = $(e.target).parents("tr").data("role_id")
    url = window.location.protocol + "//" + window.location.hostname + Routes.role_path(role_id) + ".txt"
    window.prompt "Copy to clipboard: Ctrl+C, Enter", url
    false
)