DssRm.Views.ApplicationsIndexSidebar = Backbone.View.extend(
  tagName: "div"
  id: "sidebar-area"
  className: "span3 disable-text-select"
  events:
    "click #pins li"             : "selectEntity"
    "click #highlighted_pins li" : "selectEntity"
  
  initialize: (options) ->
    @$el.html JST["templates/applications/sidebar"]()
    
    @sidebar_entities = new DssRm.Collections.Entities()
    @buildSidebar()
    
    # Re-render the sidebar when favorites, etc. are added/removed
    @sidebar_entities.on "reset", @render, this

    # Intelligently handle adjusting @sidebar_entities
    DssRm.current_user.favorites.on "add remove", @buildSidebar, this
    DssRm.current_user.group_ownerships.on "add remove", @buildSidebar, this
    DssRm.current_user.group_operatorships.on "add remove", @buildSidebar, this
    
    DssRm.view_state.on "change", @render, this
    
    @$("#search_sidebar").on "keyup", (e) =>
      entry = $(e.target).val()
      entity = @sidebar_entities.find( (i) -> i.get('name') == entry )
      
      if entity
        DssRm.view_state.set focused_entity_id: entity.id
      else
        DssRm.view_state.set focused_entity_id: null
    
    @$("#search_sidebar").typeahead [
      name: 'sidebar-people'
      remote:
        url: Routes.people_path() + "?q=%QUERY"
        filter: @sidebarSearch
      limit: 8
      header: '<h4>People</h4>'
      footer: '<center><button class="btn btn-mini">Import Person</button></center>'
      template: [
        '<p>{{value}}</p>'
      ].join('')
      engine: Hogan
    ,
      name: 'sidebar-groups'
      remote:
        url: Routes.groups_path() + "?q=%QUERY"
        filter: @sidebarSearch
      limit: 8
      header: '<h4>Groups</h4>'
    ]
      #template: '<p><strong>{{value}}</strong> – {{year}}</p>'
      #engine: Hogan
    
    # @$("#search_sidebar").typeahead
    #   minLength: 3
    #   sorter: (items) -> # required to keep the order given to process() in 'source'
    #     items
    #   highlighter: (item) ->
    #     parts = item.split("####")
    #     item = parts[1] # See: https://gist.github.com/3694758 (FIXME when typeahead supports passing objects)
    #     query = @query.replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g, "\\$&")
    #     ret = item.replace(new RegExp("(" + query + ")", "ig"), ($1, match) ->
    #       "<strong>" + match + "</strong>"
    #     )
    #     ret = ret + parts[2]  if parts[2] isnt `undefined`
    #     ret
    #   source: @sidebarSearch
    #   updater: (item) =>
    #     @sidebarSearchResultSelected item, @
    #   items: 15 # we enforce a limit on this but the bootstrap default is still too low
  
  render: ->
    pins_frag = document.createDocumentFragment()
    highlighted_pins_frag = document.createDocumentFragment()
    
    # Render sidebar entities (favorites, etc.)
    @sidebar_entities.each (view) =>
      pin = view.get('view')
      if pin.assignedToCurrentRole()
        highlighted_pins_frag.appendChild pin.el
      else
        pins_frag.appendChild pin.el

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
        highlighted_pins_frag.appendChild pin.el
    
    @$('#pins').html pins_frag
    @$("#highlighted_pins").html highlighted_pins_frag
    
    @
  
  # Renders a single sidebar pin and renders the object. Does not add to DOM.
  renderSidebarPin: (entity) ->
    pin = new DssRm.Views.SidebarPin { model: entity }
    pin.render()
  
  # Rebuilds all data and views related to the sidebar but does not render.
  buildSidebar: ->
    # Populate with the user's ownerships, operatorships, and favorites
    @sidebar_entities.reset _.union(DssRm.current_user.group_ownerships.models, DssRm.current_user.group_operatorships.models, DssRm.current_user.favorites.models)

    # Render a view for each entity
    @sidebar_entities.each (el) =>
      el.set 'view', @renderSidebarPin(el)
  
  addToSidebar: (model, collection, options) ->
    @sidebar_entities.add
      id: model.get('id')
      name: model.get('name')
      view: @renderSidebarPin(model)

  removeFromSidebar: (model, collection, options) ->
    @sidebar_entities.remove model
  
  selectEntity: (e) ->
    clicked_entity_id = $(e.currentTarget).data("entity-id")
    clicked_entity_name = $(e.currentTarget).data("entity-name")
    
    e.stopPropagation()
    
    # If a role is selected, toggle the entity's association with that role.
    # If no role is selected, merely filter the application/role list to display their assignments.
    selected_role = DssRm.view_state.getSelectedRole()
    if selected_role
      # toggle on or off?
      matched = selected_role.entities.filter((e) ->
        e.id is clicked_entity_id
      )

      if matched.length > 0
        # toggling off
        selected_role.entities.remove matched[0]
        DssRm.view_state.getSelectedApplication().save {},
          success: =>
            DssRm.view_state.trigger('change')
      else
        # toggling on
        new_entity = new DssRm.Models.Entity(id: clicked_entity_id)
        new_entity.fetch success: =>
          selected_role.entities.add new_entity
          app = DssRm.view_state.getSelectedApplication()
          app.save {},
            success: =>
              DssRm.view_state.trigger('change')

  sidebarSearch: (results) ->
    entities = []
    query = $('#search_sidebar').val() # typeahead.js should really pass the query ...
    
    _.each results, (entity) =>
      entities.push
        id: entity.id
        # The following bit highlights the matched part of the name in <strong>
        value: entity.name # entity.name.replace(new RegExp("(" + query + ")", "ig"), ($1, match) ->
 #          "<strong>" + match + "</strong>"
 #        )
    
    entities.push
      id: DssRm.Views.ApplicationsIndexSidebar.FID_ADD_PERSON
      value: "Import Person " + query
    entities.push
      id: DssRm.Views.ApplicationsIndexSidebar.FID_CREATE_GROUP
      value: "Create Group " + query

    return entities

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
          if @sidebar_entities.find((e) ->
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

  # # Populates the sidebar search with results via async call
  # sidebarSearch: (query, process) ->
  #   $.ajax(
  #     url: Routes.entities_path()
  #     data:
  #       q: query
  #     type: "GET"
  #   ).always (data) ->
  #     entities = []
  #     exact_match_found = false
  #     _.each data, (entity) ->
  #       # We have to manually enforce a length on the sidebar search as we'll be adding terms toward the end
  #       # and don't want them cut off if the search results list is long
  #       if entities.length < (DssRm.Views.ApplicationsIndexSidebar.SIDEBAR_MAX_LENGTH - 2)
  #         exact_match_found = true if query.toLowerCase() is entity.name.toLowerCase()
  #         entities.push entity.id + "####" + entity.name + "####" + "<i class=\"icon-search sidebar-details\" rel=\"tooltip\" title=\"See details\" onClick=\"var event = arguments[0] || window.event; DssRm.Views.ApplicationsIndex.sidebarDetails(event);\" />"
  # 
  #     if exact_match_found is false
  #       # Add the option to create a new one with this query (-1 and -2 are invalid IDs to indicate these choices)
  #       entities.push DssRm.Views.ApplicationsIndexSidebar.FID_ADD_PERSON + "####Import Person " + query
  #       entities.push DssRm.Views.ApplicationsIndexSidebar.FID_CREATE_GROUP + "####Create Group " + query
  # 
  #     process entities
  # 
  # sidebarSearchResultSelected: (item) ->
  #   parts = item.split("####")
  #   id = parseInt(parts[0])
  #   label = parts[1]
  # 
  #   switch id
  #     when DssRm.Views.ApplicationsIndexSidebar.FID_ADD_PERSON
  #       DssRm.router.navigate "import/" + label.slice(14), {trigger: true} # slice(14) is removing the "Import Person " prefix
  #       label = ""
  #       
  #     when DssRm.Views.ApplicationsIndexSidebar.FID_CREATE_GROUP
  #       DssRm.current_user.group_ownerships.create
  #         name: label.slice(13) # slice(13) is removing the "Create Group " prefix
  #         type: "Group"
  #     else
  #       # Specific entity selected.
  #       # If a role is selected, so assign the result to that role,
  #       # and do not add to favorites.
  #       selected_role = DssRm.view_state.getSelectedRole()
  #       if selected_role
  #         entity_to_assign = new DssRm.Models.Entity(id: id)
  #         entity_to_assign.fetch success: =>
  #           selected_role.entities.add entity_to_assign
  #           DssRm.view_state.getSelectedApplication().save()
  #           @render() # need to update the sidebar and we don't listen to either of the above
  #       else
  #         # No role selected, either add entity to their favorites (default behavior)
  #         # or highlight the result if they're already a favorite.
  #         if @sidebar_entities.find((e) ->
  #           e.id is id
  #         ) is `undefined`
  #           # Add to favorites
  #           e = new DssRm.Models.Entity(
  #             id: id
  #             name: label
  #           )
  #           e.fetch success: =>
  #             DssRm.current_user.favorites.add e
  #             DssRm.current_user.save()
  #           
  #           return ""
  #         else
  #           # Already in favorites - highlight the result
  #           DssRm.view_state.set focused_entity_id: id
  #   
  #   label

,
  # Constants used in this view
  FID_ADD_PERSON: -1
  FID_CREATE_GROUP: -2
  #SIDEBAR_MAX_LENGTH: 15
  
  # Function defined here for use in onClick.
  # Inline event handler was required on i.sidebar-search to avoid patching
  # Bootstrap's typeahead()
  sidebarDetails: (e) ->
    e.stopPropagation()
    $("input#search_sidebar").val ""
    entity_id = $(e.target).parent().parent().data("value").split("####")[0]
    DssRm.router.showEntity entity_id

)
