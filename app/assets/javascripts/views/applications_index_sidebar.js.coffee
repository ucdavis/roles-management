DssRm.Views.ApplicationsIndexSidebar = Backbone.View.extend(
  tagName: "div"
  id: "sidebar-area"
  className: "span3 disable-text-select"
  events:
    "click ul>li" : "selectEntity"
  
  initialize: (options) ->
    @$el.html JST["templates/applications/sidebar"]()
    
    # Re-render the sidebar when favorites, etc. are added/removed
    #DssRm.view_state.sidebar_entities.on "reset", @render, this
    DssRm.view_state.sidebar_entities.on "destroy", =>
      console.log 'view_state.sidebar_entities destroy caught, re-rendering'
      @render()
    , this
    DssRm.view_state.sidebar_entities.on "add", =>
      console.log 'view_state.sidebar_entities add caught, re-rendering'
      @render()
    , this
    
    DssRm.view_state.on "change", =>
      console.log 'view state change, calling render'
      @render()
    , this
    
    @$("#search_sidebar").on "keyup", (e) =>
      entry = $(e.target).val()
      entity = DssRm.view_state.sidebar_entities.find( (i) -> i.get('name') == entry )
      
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
    selected_role = DssRm.view_state.getSelectedRole()
    
    pins_frag = document.createDocumentFragment()
    highlighted_pins_frag = document.createDocumentFragment()
    
    # Render sidebar entities (favorites, ownerships, operators)
    DssRm.view_state.sidebar_entities.each (e) =>
      faded = false
      
      if selected_role
        console.log "looking for entity id of #{e.id} in selected_role #{selected_role.cid} with #{selected_role.assignments.length} assignments"
      
      if selected_role and selected_role.assignments.findWhere({ entity_id: e.id })
          faded = true

      pin = @renderSidebarPin(e, { highlighted: false, faded: faded })
      pins_frag.appendChild pin.el

    if selected_role
      # We parse assignments to ensure we don't display a calculated assignment
      # (they only come from groups and the group will be in the list already),
      # but we must then pass an entity, not an assignment, to @renderSidebarPin()
      selected_role.assignments.each (a) =>
        unless a.get('calculated') or a.get('_destroy')
          e = selected_role.entities.get a.get('entity_id')
          pin = @renderSidebarPin(e, { highlighted: true, faded: false })
          highlighted_pins_frag.appendChild pin.el
    
    @$('ul#pins').html pins_frag
    @$("ul#highlighted_pins").html highlighted_pins_frag

    if @$("ul#highlighted_pins>li").length
      @$('h5#highlighted_pins').show()
    else
      @$('h5#highlighted_pins').hide()

    # Sidebar pins are clickable only if a role is selected.
    if selected_role
      $("ul li").css('cursor', 'pointer')
    else
      $("ul li").css('cursor', 'default')
    
    @
  
  # Renders a single sidebar pin and renders the object. Does not add to DOM.
  renderSidebarPin: (entity, options) ->
    pin = new DssRm.Views.SidebarPin { model: entity, highlighted: options.highlighted, faded: options.faded }
    pin.render()
  
  selectEntity: (e) ->
    clicked_entity_id = $(e.currentTarget).data("entity-id")
    clicked_entity_name = $(e.currentTarget).data("entity-name")
    
    e.stopPropagation()
    
    # If a role is selected, toggle the entity's association with that role.
    # If no role is selected, merely filter the application/role list to display their assignments.
    selected_role = DssRm.view_state.getSelectedRole()

    if selected_role
      # toggle on or off?
      matched = selected_role.assignments.filter((a) ->
        a.get('entity_id') is clicked_entity_id
      )

      if matched.length > 0
        # toggling off
        console.log 'toggling off'
        
        matched[0].set('_destroy', true)
        selected_role.entities.remove matched[0].entity_id

        DssRm.view_state.getSelectedApplication().save {},
          success: =>
            DssRm.view_state.trigger('change')
      else
        # toggling on
        new_entity = new DssRm.Models.Entity(id: clicked_entity_id)
        new_entity.fetch success: =>
          console.log "toggling on via application save for selected_role with cid #{selected_role.cid}"
          selected_role.entities.add new_entity
          selected_role.assignments.add
            entity_id: new_entity.id
            calculated: false
          app = DssRm.view_state.getSelectedApplication()
          app.save {},
            success: =>
              DssRm.view_state.trigger('change')

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
          entities.push entity.id + "####" + entity.name + "####" + "<i class=\"icon-search sidebar-details\" rel=\"tooltip\" title=\"See details\" onClick=\"var event = arguments[0] || window.event; event.stopPropagation(); DssRm.Views.ApplicationsIndexSidebar.sidebarDetails(event);\" />"

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
        console.log 'calling .create on current user group_ownerships'
        DssRm.current_user.group_ownerships.create
          name: label.slice(13) # slice(13) is removing the "Create Group " prefix
          type: "Group"
        ,
          wait: true
      else
        # Specific entity selected.
        # If a role is selected, so assign the result to that role,
        # and do not add to favorites.
        selected_role = DssRm.view_state.getSelectedRole()
        if selected_role
          entity_to_assign = new DssRm.Models.Entity(id: id)
          entity_to_assign.fetch success: =>
            selected_role.entities.add entity_to_assign
            DssRm.view_state.getSelectedApplication().save()
            @render() # need to update the sidebar and we don't listen to either of the above
        else
          # No role selected, either add entity to their favorites (default behavior)
          # or highlight the result if they're already a favorite.
          if DssRm.view_state.sidebar_entities.find((e) ->
            e.id is id
          ) is `undefined`
            # Add to favorites
            e = new DssRm.Models.Entity(
              id: id
              name: label
            )
            e.fetch success: =>
              DssRm.current_user.favorites.add e
              DssRm.current_user.save()
            
            return ""
          else
            # Already in favorites - highlight the result
            DssRm.view_state.set focused_entity_id: id
    
    label

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
