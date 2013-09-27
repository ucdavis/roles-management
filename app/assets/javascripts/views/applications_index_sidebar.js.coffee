DssRm.Views.ApplicationsIndexSidebar = Backbone.View.extend(
  tagName: "div"
  id: "sidebar-area"
  className: "span3 disable-text-select"
  
  initialize: (options) ->
    @$el.html JST["templates/applications/sidebar"]()
    
    # Re-render the sidebar when favorites, etc. are added/removed
    DssRm.view_state.bookmarks.on 'reset destroy', @render, this
    DssRm.view_state.on 'change', @render, this
    
    @$("#search_sidebar").on "keyup", (e) =>
      entry = $(e.target).val()
      entity = DssRm.view_state.bookmarks.find( (i) -> i.get('name') == entry )
      
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
        ret = ret + parts[3] if parts[3] isnt `undefined`
        ret
      source: @sidebarSearch
      updater: (item) =>
        @sidebarSearchResultSelected item, @
      items: 15 # we enforce a limit on this but the bootstrap default is still too low
  
  render: ->
    selected_role = DssRm.view_state.getSelectedRole()
    
    pins_frag = document.createDocumentFragment()
    highlighted_pins_frag = document.createDocumentFragment()
    
    # Render 'bookmarks'
    DssRm.view_state.bookmarks.each (e) =>
      faded = false
      
      # 'Fade' bookmark if it is also going to be in the 'Assigned' section
      if selected_role and selected_role.has_assigned(e, false)
          faded = true
      
      ep = new Backbone.Model
        entity_id: (e.get('group_id') || e.get('id'))
        name: e.get('name')
        type: e.get('type')
      
      pin = @renderSidebarPin(ep, { highlighted: false, faded: faded })
      pins_frag.appendChild pin.el
    
    @$('#bookmark-count').html DssRm.view_state.bookmarks.length
    
    # Render 'Assigned'
    if selected_role
      # We parse assignments to ensure we don't display a calculated assignment
      # (they only come from groups and the group will be in the list already),
      # but we must then pass an entity, not an assignment, to @renderSidebarPin()
      selected_role.assignments.each (a) =>
        unless a.get('calculated') or a.get('_destroy')
          pin = @renderSidebarPin(a, { highlighted: true, faded: false })
          highlighted_pins_frag.appendChild pin.el
    
    @$('ul#pins').html pins_frag
    @$("ul#highlighted_pins").html highlighted_pins_frag

    if @$("ul#highlighted_pins>li").length
      # Show the 'Assigned' section
      @$('h5#highlighted_pins').slideDown('slow')
      @$('ul#highlighted_pins').slideDown('slow')
    else
      # Hide the 'Assigned' section
      @$('h5#highlighted_pins').slideUp('slow')
      @$('ul#highlighted_pins').slideUp('slow')

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
  
  # Populates the sidebar search with results via async call
  sidebarSearch: (query, process) ->
    $.ajax(
      url: Routes.entities_path()
      data:
        q: query
      type: 'GET'
    ).always (data) ->
      entities = []
      exact_match_found = false
      _.each data, (entity) ->
        # We have to manually enforce a length on the sidebar search as we'll be adding terms toward the end
        # and don't want them cut off if the search results list is long
        if entities.length < (DssRm.Views.ApplicationsIndexSidebar.SIDEBAR_MAX_LENGTH - 2)
          exact_match_found = true if query.toLowerCase() is entity.name.toLowerCase()
          entities.push entity.id + "####" + entity.name + "####" + entity.loginid + "####<i class=\"icon-search sidebar-search-details\" rel=\"tooltip\" title=\"See details\" onClick=\"var event = arguments[0] || window.event; event.stopPropagation(); DssRm.Views.ApplicationsIndexSidebar.sidebarDetails(event);\" />"

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
      
      when DssRm.Views.ApplicationsIndexSidebar.FID_CREATE_GROUP
        DssRm.current_user.group_ownerships.create
          name: label.slice(13) # slice(13) is removing the "Create Group " prefix
          type: "Group"
        ,
          wait: true
      else
        # Specific entity selected.
        # If a role is selected, assign the result to that role
        # and do not add to favorites.
        selected_role = DssRm.view_state.getSelectedRole()
        if selected_role and not selected_role.has_assigned(id)
          entity_to_assign = new DssRm.Models.Entity(id: id)
          entity_to_assign.fetch success: =>
            selected_role.assignments.add
              entity_id: entity_to_assign.id
              calculated: false
            #selected_role.entities.add entity_to_assign
            selected_role.save {},
              success: =>
                DssRm.view_state.trigger('change')
        else
          # No role selected, either add entity to their favorites (default behavior)
          # or highlight the result if they're already a favorite.
          if DssRm.view_state.bookmarks.find((e) ->
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
          else
            # Already in favorites - highlight the result
            DssRm.view_state.set focused_entity_id: id
    
    ""

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
