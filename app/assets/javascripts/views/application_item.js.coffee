DssRm.Views.ApplicationItem = Backbone.View.extend(
  tagName: "div"
  className: "card"
  events:
    "click .role": "selectRole"

  initialize: (options) ->
    @listenTo @model, "sync", @render
    @listenTo DssRm.view_state, "change", @render
    
    owner_ids = @model.owners.map (i) -> i.get "id"
    @relationship = @model.relationship()
    @$el.html JST["templates/applications/item"](application: @model)
    @$el.attr "id", "application_" + @model.id
    @$(".application-link").attr "href", @applicationUrl()

  render: ->
    @$("#application-name").html @model.escape("name")
    @$(".card-title").attr "title", @model.get("description")
    
    @owner_names = @model.owners.map((i) -> i.get "name").join(", ")
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
    
    # Roles area needed?
    if @model.roles.length then @$(".roles").show() else @$(".roles").hide()
    
    @$(".roles").empty()
    @model.roles.each (r) =>
      $role_item = @renderRoleItem(r)
      @$(".roles").append $role_item
    
    @

  renderRoleItem: (role) ->
    $role_item = $('<div class="role"><a href="#">name</a></div>')
    $role_item.attr "data-role-id", role.get("id")
    $role_item.attr "rel", "tooltip"
    $role_item.find("a").html role.escape("name")
    $role_item.attr "title", role.get("description")
    if role.get("id") is DssRm.view_state.get('selected_role_id')
      $role_item.css("box-shadow", "#08C 0 0 5px").css("border", "1px solid #08C")
    $role_item

  applicationUrl: ->
    "#applications/" + @model.get("id")

  selectRole: (e) ->
    e.stopPropagation()
    
    role_id = parseInt($(e.currentTarget).attr("data-role-id"))
    role = @model.roles.get(role_id)
    
    status_bar.show "Fetching role details ..."
    role.fetch
      success: =>
        status_bar.hide()
        
        DssRm.view_state.set
          selected_application_id: @model.get('id')
          selected_role_id: role_id
      error: ->
        status_bar.show "An error occurred while fetching information about the role.", "error"
)