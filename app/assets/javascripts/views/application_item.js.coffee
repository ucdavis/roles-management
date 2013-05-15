DssRm.Views.ApplicationItem = Backbone.View.extend(
  tagName: "div"
  className: "card"
  events:
    "click .role": "selectRole"

  initialize: (options) ->
    # change - ?
    # sync - for when application_show adds/removes roles
    @listenTo @model, "change sync", @render
    @listenTo DssRm.view_state, "change", @render
    
    owner_ids = @model.owners.map((i) ->
      i.get "id"
    )
    @relationship = @model.relationship()
    @$el.html JST["templates/applications/item"](application: @model)
    @$el.attr "id", "application_" + @model.id
    @$el.data "application-id", @model.get("id")
    @$(".card-title").attr "title", @model.escape("description")
    @$(".application-link").attr "href", @applicationUrl()
    @model.roles.each (role) =>
      $role_item = @renderRoleItem(role)
      @$(".roles").append $role_item

  render: ->
    # Name
    @$("#application-name").html @model.escape("name")
    
    # Roles area needed?
    (if @model.roles.length then @$(".roles").show() else @$(".roles").hide())

    # Owner names text
    @owner_names = @model.owners.map((i) ->
      i.get "name"
    ).join(", ")
    @owner_names = "Nobody" if @owner_names.length is 0
    
    if @relationship is "admin" or @relationship is "operator"
      @$("h6").html "Owned by " + @owner_names
      @$("h6").show()
    else
      @$("h6").hide()
    @$("i.details").hide() if @relationship is "operator"
    
    # Highlight this application?
    if DssRm.view_state.getSelectedApplication() == @model
      @$el.css("box-shadow", "#08C 0 0 10px").css "border", "1px solid #08C"
    else
      @$el.css("box-shadow", "0 1px 3px rgba(0, 0, 0, 0.3)").css "border", "1px solid #CCC"
    
    # Shade/unshade this application? (based on DssRm.view_state focus)
    focused_application_id = DssRm.view_state.get 'focused_application_id'
    if focused_application_id
      if focused_application_id is @model.id
        @$el.css "opacity", "1.0"
      else
        @$el.css "opacity", "0.4"
    else
      @$el.css "opacity", "1.0"
    
    # Highlight, add or remove any roles?
    roles_in_dom = []
    roles_in_model = @model.roles.map((r) ->
      r.id
    )
    @$(".roles>.role").each (i, r) =>
      role_id = parseInt($(r).attr("data-role-id"))
      roles_in_dom.push role_id
      if role_id is DssRm.view_state.get('selected_role_id')
        $(r).css("box-shadow", "#08C 0 0 5px").css "border", "1px solid #08C"
      else
        $(r).css("box-shadow", "none").css "border", "1px solid #bce8f1"

    
    # Remove any roles in the DOM not in our model anymore
    roles_to_remove = _.difference(roles_in_dom, roles_in_model)
    _.each roles_to_remove, (r) =>
      to_remove = @$(".roles").find("div.role[data-role-id=" + r + "]")
      $(to_remove).remove()
    
    # Add any roles to the DOM mentioned in our model
    roles_to_add = _.difference(roles_in_model, roles_in_dom)
    _.each roles_to_add, (r) =>
      # Avoid rendering roles not yet synced, i.e. those with IDs like "new_243087234"
      if isNaN(parseInt(r)) is false
        role = @model.roles.get(r)
        $role_item = @renderRoleItem(role)
        @$(".roles").append $role_item

    @

  renderRoleItem: (role) ->
    $role_item = $("<div class=\"role\"><a href=\"#\">name</a></div>")
    $role_item.attr "data-role-id", role.get("id")
    $role_item.attr "rel", "tooltip"
    $role_item.find("a").html role.escape("name")
    $role_item.attr "title", role.escape("description")
    $role_item

  applicationUrl: ->
    "#applications/" + @model.get("id")

  selectRole: (e) ->
    e.stopPropagation()
    
    application_id = $(e.currentTarget).parent().parent().parent().data("application-id")
    role_id = parseInt($(e.currentTarget).attr("data-role-id"))
    
    application = DssRm.applications.get(application_id)
    role = application.roles.get(role_id)
    
    status_bar.show "Fetching role details ..."
    role.fetch
      success: =>
        status_bar.hide()
        
        DssRm.view_state.set
          selected_application_id: application_id
          selected_role_id: role_id
      error: ->
        status_bar.show "An error occurred while fetching information about the role.", "error"
)