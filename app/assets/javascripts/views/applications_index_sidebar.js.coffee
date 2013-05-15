DssRm.Views.ApplicationsIndexSidebar = Backbone.View.extend(
  tagName: "div"
  id: "sidebar-area"
  className: "span3 disable-text-select"
  events:
    "click #pins li"             : "selectEntity"
    "click #highlighted_pins li" : "selectEntity"
  
  initialize: (options) ->
    @$el.html JST["applications/sidebar"]()
    
    @sidebar_entities = new DssRm.Collections.Entities()
    @buildSidebarEntities()
    
    DssRm.current_user.favorites.on "reset", @buildSidebarEntities, this
    DssRm.current_user.group_ownerships.on "reset", @buildSidebarEntities, this
    DssRm.current_user.group_operatorships.on "reset", @buildSidebarEntities, this

    DssRm.current_user.favorites.on "add", @addToSidebarEntities, this
    DssRm.current_user.favorites.on "remove", @removeFromSidebarEntities, this
    DssRm.current_user.group_ownerships.on "add", @addToSidebarEntities, this
    DssRm.current_user.group_ownerships.on "remove", @removeFromSidebarEntities, this
    DssRm.current_user.group_operatorships.on "add", @addToSidebarEntities, this
    DssRm.current_user.group_operatorships.on "remove", @removeFromSidebarEntities, this
    
    @$("#search_sidebar").on "keyup", (e) =>
      entry = $(e.target).val()
      entity = @sidebar_entities.find( (i) -> i.get('name') == entry )
      
      if entity
        DssRm.view_state.set focused_entity_id: entity.id
      else
        DssRm.view_state.set focused_entity_id: null
    
    @$("#search_sidebar").typeahead
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
      source: @sidebarSearch
      updater: (item) =>
        @sidebarSearchResultSelected item, @
      items: 15 # we enforce a limit on this but the bootstrap default is still too low
  
  render: ->
    @$("#pins").empty()
    @$("#highlighted_pins").empty()
    
    # Render sidebar entities (favorites, etc.)
    @sidebar_entities.each (entity) =>
      pin = @renderSidebarPin(entity)
      @insertSidebarPinInDOM(pin)

    selected_role = DssRm.view_state.getSelectedRole()
    if selected_role
      # Render external entities related to the selected role
      assigned_non_subordinates = selected_role.entities.reject((e) =>
        id = e.get("id")
        @sidebar_entities.find (i) ->
          i.get("id") is id
      )
      _.each assigned_non_subordinates, (entity) =>
        pin = @renderSidebarPin(entity)
        @insertSidebarPinInDOM(pin)
    
    @
  
  # Renders a single sidebar pin and renders the object. Does not add to DOM.
  renderSidebarPin: (entity) ->
    pin = new DssRm.Views.SidebarPin(
      model: entity
    )
    
    pin.render()

  # Takes an existing, rendering sidebar pin and places it in the correct spot in the DOM
  insertSidebarPinInDOM: (pin) ->
    if pin.assignedToCurrentRole()
      @$("#highlighted_pins").append pin.el
    else
      @$("#pins").append pin.el
  
  # Populates the sidebar search with results via async call
  sidebarSearch: (query, process) ->
    $.ajax(
      url: Routes.entities_path()
      data:
        q: query
      type: "GET"
    ).always (data) ->
      entities = []
      exact_match_found = false
      _.each data, (entity) ->
        # We have to manually enforce a length on the sidebar search as we'll be adding terms toward the end
        # and don't want them cut off if the search results list is long
        if entities.length < (DssRm.Views.ApplicationsIndexSidebar.SIDEBAR_MAX_LENGTH - 2)
          exact_match_found = true if query.toLowerCase() is entity.name.toLowerCase()
          entities.push entity.id + "####" + entity.name + "####" + "<i class=\"icon-search sidebar-details\" rel=\"tooltip\" title=\"See details\" onClick=\"var event = arguments[0] || window.event; DssRm.Views.ApplicationsIndex.sidebarDetails(event);\" />"

      if exact_match_found is false
        # Add the option to create a new one with this query (-1 and -2 are invalid IDs to indicate these choices)
        entities.push DssRm.Views.ApplicationsIndexSidebar.FID_ADD_PERSON + "####Import Person " + query
        entities.push DssRm.Views.ApplicationsIndexSidebar.FID_CREATE_GROUP + "####Create Group " + query

      process entities


  sidebarSearchResultSelected: (item) ->
    parts = item.split("####")
    id = parseInt(parts[0])
    label = parts[1]

    switch id
      when DssRm.Views.ApplicationsIndexSidebar.FID_ADD_PERSON
        DssRm.router.navigate "import/" + label.slice(14), {trigger: true} # slice(14) is removing the "Import Person " prefix
        label = ""
        
      when DssRm.Views.ApplicationsIndexSidebar.FID_CREATE_GROUP
        DssRm.current_user.group_ownerships.create
          name: label.slice(13) # slice(13) is removing the "Create Group " prefix
          type: "Group"
      else
        # Exact result selected
        
        # If a role is selected, the behavior is to assign to the role,
        # and not add to favorites. Adding to favorites only happens when
        # no role is selected.
        selected_role = DssRm.view_state.getSelectedRole()
        if selected_role
          new_entity = new DssRm.Models.Entity(id: id)
          new_entity.fetch success: =>
            selected_role.entities.add new_entity
            DssRm.view_state.getSelectedApplication().save()
        else
          # No role selected, either add entity to their favorites or highlight
          if @sidebar_entities.find((e) ->
            e.id is id
          ) is `undefined`
            # Add to favorites
            p = new DssRm.Models.Entity(
              id: id
              name: label
              type: "Person"
            )
            DssRm.current_user.favorites.add p
            DssRm.current_user.save()
            
            return ""
          else
            # Already in favorites - highlight the result
            DssRm.view_state.set focused_entity_id: id
    
    label
  
  buildSidebarEntities: ->
    # Populate with the user's ownerships, operatorships, and favorites
    _sidebar_entities = _.union(DssRm.current_user.group_ownerships.models, DssRm.current_user.group_operatorships.models, DssRm.current_user.favorites.models)
    # Sort groups to be first
    _sidebar_entities = _.sortBy(_sidebar_entities, (e) ->
      prepend = (if (e.get("type") is "Group") then "1" else "2")
      sort_num = parseInt((prepend + e.get("name").charCodeAt(0).toString()))
      sort_num
    )
    @sidebar_entities.reset _sidebar_entities
  
  addToSidebarEntities: (model, collection, options) ->
    @sidebar_entities.add model
    @render()

  removeFromSidebarEntities: (model, collection, options) ->
    @sidebar_entities.remove model
    @render()
  
  selectEntity: (e) ->
    clicked_entity_id = $(e.currentTarget).data("entity-id")
    clicked_entity_name = $(e.currentTarget).data("entity-name")
    
    e.stopPropagation()
    
    # Behavior of selecting an entity changes depending on whether an application/role
    # is selected or not.
    # If an application/role is selected, toggling an entity associates or disassociates
    # that entity from that application/role.
    # If no application/role is selected, clicking an entity merely filters the application/role
    # list to display their current assignments.
    selected_role = DssRm.view_state.getSelectedRole()
    if selected_role
      # toggle on or off?
      matched = selected_role.entities.filter((e) ->
        e.id is clicked_entity_id
      )

      if matched.length > 0
        # toggling off
        selected_role.entities.remove matched[0]
        DssRm.view_state.getSelectedApplication().save(
          success: =>
            DssRm.view_state.trigger('change')
        )
      else
        # toggling on
        new_entity = new DssRm.Models.Entity(id: clicked_entity_id)
        new_entity.fetch success: =>
          selected_role.entities.add new_entity
          app = DssRm.view_state.getSelectedApplication()
          app.save(
            success: =>
                DssRm.view_state.trigger('change')
          )
,
  # Constants used in this view
  FID_ADD_PERSON: -1
  FID_CREATE_GROUP: -2
  SIDEBAR_MAX_LENGTH: 15
  
  # Function defined here for use in onClick.
  # Inline event handler was required on i.sidebar-search to avoid patching
  # Bootstrap's typeahead()
  sidebarDetails: (e) ->
    e.stopPropagation()
    $("input#search_sidebar").val ""
    entity_id = $(e.target).parent().parent().data("value").split("####")[0]
    DssRm.router.showEntity entity_id

)
