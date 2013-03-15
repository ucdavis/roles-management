DssRm.Views.ApplicationsIndex = Backbone.View.extend(
  tagName: "div"
  className: "row-fluid"
  events:
    "click #pins li"             : "selectEntity"
    "click #highlighted_pins li" : "selectEntity"
    "click #cards"               : "deselectAll"

  initialize: (options) ->
    # Create a view state to be shared with sub-views
    @view_state = new DssRm.Models.ViewState()
    
    # 'selected' implies actions will be performed upon the object (as expected)
    # whereas 'focused' merely indicates whether it's shaded or not (used by the search bars)
    @listenTo @view_state, "change", @render
    
    @sidebar_entities = new DssRm.Collections.Entities()

    DssRm.current_user.favorites.on "reset", @buildSidebarEntities, this
    DssRm.current_user.group_ownerships.on "reset", @buildSidebarEntities, this
    DssRm.current_user.group_operatorships.on "reset", @buildSidebarEntities, this

    DssRm.current_user.favorites.on "add", @addToSidebarEntities, this
    DssRm.current_user.favorites.on "remove", @removeFromSidebarEntities, this
    DssRm.current_user.group_ownerships.on "add", @addToSidebarEntities, this
    DssRm.current_user.group_ownerships.on "remove", @removeFromSidebarEntities, this
    DssRm.current_user.group_operatorships.on "add", @addToSidebarEntities, this
    DssRm.current_user.group_operatorships.on "remove", @removeFromSidebarEntities, this
    
    DssRm.applications.on "add", ((o) =>
      @renderCard o
    ), this
    DssRm.applications.on "remove", ((o) =>
      @$("#cards").find(".card#application_" + o.id).remove()
    ), this
    DssRm.applications.on "change", @render, this # for toggling sidebar entities on and off roles
    DssRm.current_user.favorites.on "change add remove destroy sync reset", @render, this
    DssRm.current_user.group_ownerships.on "change add remove destroy sync reset", @render, this
    DssRm.current_user.group_operatorships.on "change add remove destroy sync reset", @render, this

    @$el.html JST["applications/index"](applications: DssRm.applications)
    
    @$("#search_applications").on "keyup", (e) =>
      entry = $(e.target).val()
      @view_state.focusApplicationByTerm entry

    @$("#search_applications").typeahead
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
          
      source: @applicationSearch
      updater: (item) =>
        @applicationSearchResultSelected item, @
    
      items: 15

    @$("#search_applications").off("focus").on "focus", (e) ->
      $(this).select()
      typeahead = $(e.target).data('typeahead')
      typeahead.focused = true;
    
    @$("#search_sidebar").on "keyup", (e) =>
      entry = $(e.target).val()
      entity = @sidebar_entities.find( (i) -> i.get('name') == entry )
      
      if entity
        @view_state.set focused_entity_id: entity.id
      else
        @view_state.set focused_entity_id: null
      

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


    DssRm.applications.each (application) =>
      @renderCard application
  
  
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


  removeFromSidebarEntities: (model, collection, options) ->
    @sidebar_entities.remove model


  render: ->
    # We must ensure tooltips are closed before possibly deleting their
    # associated DOM elements
    @$("[rel=tooltip]").each (i, el) ->
      $(el).tooltip "hide" unless el is `undefined`

    @renderSidebar()

    @


  renderCard: (application) ->
    card = new DssRm.Views.ApplicationItem(
      model: application
      view_state: @view_state
    ).render()
    @$("#cards").append card.el


  renderSidebar: ->
    # Need group_operatorship IDs has an array when drawing EntityItem
    group_operatorships = DssRm.current_user.group_operatorships.map((group) ->
      group.get "id"
    )
    selected_role = @view_state.get 'selected_role'

    @$("#pins").empty()
    @$("#highlighted_pins").empty()
    @sidebar_entities.each (entity) =>
      highlighted = @entityAssignedToCurrentRole(entity)
      pin = new DssRm.Views.EntityItem(
        model: entity
        highlighted: highlighted
        read_only: _.indexOf(group_operatorships, entity.get("id")) >= 0
        current_role: selected_role
        current_application: @view_state.get 'selected_application'
      )
      
      pin.render()
      
      if highlighted
        @$("#highlighted_pins").append pin.el
      else
        @$("#pins").append pin.el

    if selected_role
      assigned_non_subordinates = selected_role.entities.reject((e) =>
        id = e.get("id")
        @sidebar_entities.find (i) ->
          i.get("id") is id
      )
      _.each assigned_non_subordinates, (entity) =>
        pin = new DssRm.Views.EntityItem(
          model: entity
          highlighted: true
          faded: true
          current_role: selected_role
          current_application: @view_state.get 'selected_application'
        )
        pin.render()
        @$("#highlighted_pins").append pin.el
  
  
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
        if entities.length < (DssRm.Views.ApplicationsIndex.SIDEBAR_MAX_LENGTH - 2)
          exact_match_found = true if query.toLowerCase() is entity.name.toLowerCase()
          entities.push entity.id + "####" + entity.name + "####" + "<i class=\"icon-search sidebar-details\" rel=\"tooltip\" title=\"See details\" onClick=\"var event = arguments[0] || window.event; DssRm.Views.ApplicationsIndex.sidebarDetails(event);\" />"

      if exact_match_found is false
        # Add the option to create a new one with this query (-1 and -2 are invalid IDs to indicate these choices)
        entities.push DssRm.Views.ApplicationsIndex.FID_ADD_PERSON + "####Import Person " + query
        entities.push DssRm.Views.ApplicationsIndex.FID_CREATE_GROUP + "####Create Group " + query

      process entities


  sidebarSearchResultSelected: (item) ->
    parts = item.split("####")
    id = parseInt(parts[0])
    label = parts[1]

    switch id
      when DssRm.Views.ApplicationsIndex.FID_ADD_PERSON
        alert "Currently unsupported."
      when DssRm.Views.ApplicationsIndex.FID_CREATE_GROUP
        DssRm.current_user.group_ownerships.create
          name: label.slice(13) # slice(13) is removing the "Create Group " prefix
          type: "Group"
      else
        # Exact result selected
        
        # If a role is selected, the behavior is to assign to the role,
        # and not add to favorites. Adding to favorites only happens when
        # no role is selected.
        selected_role = @view_state.get 'selected_role'
        if selected_role
          new_entity = new DssRm.Models.Entity(id: id)
          new_entity.fetch success: =>
            selected_role.entities.add new_entity
            @view_state.get('selected_application').save()
        else
          # No role selected, so we will add this entity to their favorites
          if @sidebar_entities.find((e) ->
            e.id is id
          ) is `undefined`
            
            # Add this result
            p = new DssRm.Models.Entity(
              id: id
              name: label
              type: "Person"
            )
            DssRm.current_user.favorites.add p
            DssRm.current_user.save()
    
    label

  applicationSearch: (query, process) ->
    # I have no idea why we must delay ever so slightly.
    # Bootstrap v2.3.1 takes source: ["red", "black"] just fine
    # but source: function() { return ["red", black"] }, i.e. this
    # exact function without the timeout, doesn't seem to work. The dropdown
    # is populated but stays display: none
    setTimeout( () ->
      entities = []
      exact_match_found = false
      DssRm.applications.each (app) ->
        if app
          if ~app.get("name").toLowerCase().indexOf(query.toLowerCase())
            exact_match_found = true  if app.get("name").toLowerCase() is query.toLowerCase()
            entities.push app.get("id") + "####" + app.get("name")
    
      # Add the option to create a new one with this query
      entities.push DssRm.Views.ApplicationsIndex.FID_CREATE_APPLICATION + "####Create " + query  if exact_match_found is false
    
      process entities
    , 10)

  applicationSearchResultSelected: (item) ->
    parts = item.split("####")
    id = parseInt(parts[0])
    label = parts[1]
    switch id
      when DssRm.Views.ApplicationsIndex.FID_CREATE_APPLICATION
        name = label.slice(7) # slice(7) is removing the "Create " prefix
        DssRm.applications.create
          name: name
          owners: [
            id: DssRm.current_user.id
            name: DssRm.current_user.target("name")
            type: "Person"
          ]
        ,
          wait: true
      else
        @view_state.set focused_application_id: id
        
    label


  deselectAll: (e) ->
    # Ensure click event isn't due to child ignoring it --
    # we really do want only clicks on div#cards and not its
    # children
    if e.target is $("div#cards").get(0)
      @view_state.deselectAll()

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
    selected_role = @view_state.get 'selected_role'
    if selected_role
      # toggle on or off?
      matched = selected_role.entities.filter((e) ->
        e.id is clicked_entity_id
      )

      if matched.length > 0
        # toggling off
        selected_role.entities.remove matched[0]
        @view_state.get('selected_application').save()
      else
        # toggling on
        new_entity = new DssRm.Models.Entity(id: clicked_entity_id)
        new_entity.fetch success: =>
          selected_role.entities.add new_entity
          @view_state.get('selected_application').save()


  # Returns true if the given entity 'e' is assigned to the current role
  entityAssignedToCurrentRole: (e) ->
    entity_id = e.get("id")

    selected_role = @view_state.get 'selected_role'
    if selected_role
      results = selected_role.entities.find((i) ->
        i.get('id') is entity_id
      )
      if results is `undefined`
        return false
      else
        return true
    false
,
  
  # Constants used in this view
  FID_ADD_PERSON: -1
  FID_CREATE_GROUP: -2
  FID_CREATE_APPLICATION: -3
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