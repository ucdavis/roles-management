DssRm.Views.ApplicationsIndexSidebar = Backbone.View.extend(
  tagName: "div"
  id: "sidebar-area"
  className: "span3 disable-text-select"

  initialize: ->
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
        enabled = parts[1]
        item = parts[2] # See: https://gist.github.com/3694758 (FIXME when typeahead supports passing objects)
        query = @query.replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g, "\\$&")
        ret = item.replace(new RegExp("(" + query + ")", "ig"), ($1, match) ->
          "<strong>" + match + "</strong>"
        )
        ret = "<s>" + ret + "</s>" if enabled == "false"
        ret = ret + parts[4] if parts[4] isnt `undefined`
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

      pin = @renderSidebarPin(e, { highlighted: false, faded: faded })
      pins_frag.appendChild pin.el

    @$('#bookmark-count').html DssRm.view_state.bookmarks.length

    # Render 'Assigned'
    if selected_role
      # We parse assignments to ensure we don't display a calculated assignment
      # (they only come from groups and the group will be in the list already),
      # but we must then pass an entity, not an assignment, to @renderSidebarPin()
      member_count = 0
      selected_role.assignments.each (a) =>
        member_count = member_count + 1 unless a.get('type') == "Group"
        unless a.get('calculated') or a.get('_destroy')
          pin = @renderSidebarPin(a, { highlighted: true, faded: false })
          highlighted_pins_frag.appendChild pin.el

      @$('#assigned-count').html member_count

    @$('ul#pins').html pins_frag
    @$("ul#highlighted_pins").html highlighted_pins_frag

    if @$("ul#highlighted_pins>li").length
      # Show the 'Assigned' section
      @$('h5#highlighted_pins').slideDown('fast')
      @$('ul#highlighted_pins').slideDown('fast')
    else
      # Hide the 'Assigned' section
      @$('h5#highlighted_pins').slideUp('fast')
      @$('ul#highlighted_pins').slideUp('fast')

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
    ).done( (data) ->
      entities = []
      exact_match_found = false
      _.each data, (entity) ->
        # We have to manually enforce a length on the sidebar search as we'll be adding terms toward the end
        # and don't want them cut off if the search results list is long
        if entities.length < (DssRm.Views.ApplicationsIndexSidebar.SIDEBAR_MAX_LENGTH - 2)
          exact_match_found = true if query.toLowerCase() is entity.name.toLowerCase()
          entities.push entity.id + "####" + entity.active + "####" + entity.name + "####" + entity.loginid + "####<i class=\"icon-search sidebar-search-details\" rel=\"tooltip\" title=\"See details\" onClick=\"var event = arguments[0] || window.event; event.stopPropagation(); DssRm.Views.ApplicationsIndexSidebar.sidebarDetails(event);\" />"

      if exact_match_found is false
        # Add the option to create a new one with this query (-1 and -2 are invalid IDs to indicate these choices)
        entities.push DssRm.Views.ApplicationsIndexSidebar.FID_ADD_PERSON + "####1####Import Person " + query
        entities.push DssRm.Views.ApplicationsIndexSidebar.FID_CREATE_GROUP + "####1####Create Group " + query

      process entities
    ).fail( (data) ->
      toastr["error"]("An error occurred while searching people and groups. Try again later.")
    )

  sidebarSearchResultSelected: (item, a, b, c) ->
    parts = item.split("####")
    id = parseInt(parts[0])
    active = parts[1]
    label = parts[2]

    return if active == "false"

    switch id
      when DssRm.Views.ApplicationsIndexSidebar.FID_ADD_PERSON
        DssRm.router.navigate "import/" + label.slice(14), {trigger: true} # slice(14) is removing the "Import Person " prefix

      when DssRm.Views.ApplicationsIndexSidebar.FID_CREATE_GROUP
        toastr["info"]("Creating group ...")
        DssRm.current_user.group_ownerships.create(
          name: label.slice(13) # slice(13) is removing the "Create Group " prefix
          type: "Group"
        ,
          success: (res) ->
            toastr.remove()
            toastr["success"]("Group created.")
            DssRm.current_user.fetch() # a new GroupOwnership was created by the above
                                       # and will be properly assigned on .fetch()
          error: (res) ->
            toastr.remove()
            toastr["error"]("Error while creating group. Try again later.")
          wait: true
        )
      else
        # Specific entity selected.

        # If a role is selected, assign the result to that role
        # and do not add to favorites.
        selected_role = DssRm.view_state.getSelectedRole()
        if selected_role and not selected_role.has_assigned(id)
          entity_to_assign = new DssRm.Models.Entity(id: id)
          toastr["info"]("Updating person or group ...")
          entity_to_assign.fetch
            success: =>
              toastr.remove()
              selected_role.assignments.add
                entity_id: entity_to_assign.id
                calculated: false
              selected_role.save {},
                success: =>
                  toastr["success"]("#{entity_to_assign.get('name')} added to role.")
                  DssRm.view_state.trigger('change')
                error: =>
                  toastr["error"]("Error while assigning #{entity_to_assign.get('name')} to role.")
            error: =>
              toastr["error"]("Error while updating person or group. Role assignment failed.")
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
            toastr["info"]("Adding to favorites ...")
            e.fetch
              success: =>
                DssRm.current_user.favorites.add e
                DssRm.current_user.save {},
                    error: ->
                      toastr["error"]("Error while adding person or group to favorites.")
                    success: ->
                      toastr["success"]("Person or group successfully added to favorites.")
                      # Do nothing on success
              error: =>
                toastr["error"]("Error while adding to favorites.")
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
