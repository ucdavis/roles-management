DssRm.Views.ApplicationItem = Backbone.View.extend(
  tagName: "div"
  className: "card"
  events:
    "click .role": "selectRole"

  initialize: (options) ->
    @view_state = options.view_state
    
    # change - ?
    # sync - for when application_show adds/removes roles
    @listenTo @model, "change sync", @render
    @listenTo @view_state, "change", @render
    
    owner_ids = @model.owners.map((i) ->
      i.get "id"
    )
    @owner_names = @model.owners.map((i) ->
      i.get "name"
    ).join(", ")
    @owner_names = "Nobody"  if @owner_names.length is 0
    @relationship = @model.relationship()
    @$el.html JST["applications/item"](application: @model)
    @$el.attr "id", "application_" + @model.id
    @$el.data "application-id", @model.get("id")
    @$(".card-title").attr "title", @model.escape("description")
    @$(".application-link").attr "href", @applicationUrl()
    @model.roles.each (role) =>
      $role_item = @renderRoleItem(role)
      @$(".roles").append $role_item


  render: ->
    @$("#application-name").html @model.escape("name")
    (if @model.roles.length then @$(".roles").show() else @$(".roles").hide())
    if @relationship is "admin" or @relationship is "operator"
      @$("h6").html "Owned by " + @owner_names
      @$("h6").show()
    else
      @$("h6").hide()
    @$("i.details").hide()  if @relationship is "operator"
    
    # Highlight this application?
    if @view_state.get 'selected_application' is @model
      @$el.css("box-shadow", "#08C 0 0 10px").css "border", "1px solid #08C"
    else
      @$el.css("box-shadow", "0 1px 3px rgba(0, 0, 0, 0.3)").css "border", "1px solid #CCC"
    
    # Shade/unshade this application? (based on @view_state focus)
    if @view_state.get 'focused_application_id'
      if @view_state.get 'focused_application_id' is @model.id
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
      role_id = $(r).attr("data-role-id")
      roles_in_dom.push parseInt(role_id)
      if role_id is @view_state.get 'selected_role_id'
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

    this

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
    @view_state.set
      selected_application: DssRm.applications.get(application_id)
      selected_role_id: $(e.currentTarget).attr("data-role-id")
)