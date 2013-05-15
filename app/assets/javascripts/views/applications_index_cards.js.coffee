DssRm.Views.ApplicationsIndexCards = Backbone.View.extend(
  tagName: "div"
  id: "cards-area"
  className: "span9 disable-text-select"
  events:
    "click #cards" : "deselectAll"
  
  initialize: (options) ->
    @$el.html JST["templates/applications/cards"]()
    
    DssRm.applications.on "add", ((o) =>
      @$('#cards').append(@renderCard(o).el)
    ), this
    DssRm.applications.on "remove", ((o) =>
      @$('#cards').find(".card#application_" + o.id).remove()
    ), this
    
    @$("#search_applications").on "keyup", (e) =>
      entry = $(e.target).val()
      DssRm.view_state.focusApplicationByTerm entry

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
  
  render: ->
    frag = document.createDocumentFragment()
    
    DssRm.applications.each (application) =>
      frag.appendChild @renderCard(application).el
    
    @$('#cards').append frag
    @
  
  renderCard: (application) ->
    card = new DssRm.Views.ApplicationItem(
      model: application
    ).render()
  
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
    
      if DssRm.admin_logged_in()
        # Add the option to create a new one with this query
        entities.push DssRm.Views.ApplicationsIndexCards.FID_CREATE_APPLICATION + "####Create " + query  if exact_match_found is false
    
      process entities
    , 10)

  applicationSearchResultSelected: (item) ->
    parts = item.split("####")
    id = parseInt(parts[0])
    label = parts[1]
    switch id
      when DssRm.Views.ApplicationsIndexCards.FID_CREATE_APPLICATION
        name = label.slice(7) # slice(7) is removing the "Create " prefix
        DssRm.applications.create
          name: name
          owners: [
            id: DssRm.current_user.id
            name: DssRm.current_user.get("name")
            type: "Person"
          ]
        ,
          wait: true
        return ""
      else
        DssRm.view_state.set focused_application_id: id
        return label

  deselectAll: (e) ->
    # Ensure click event isn't due to child ignoring it --
    # we really do want only clicks on div#cards and not its
    # children
    if e.target is $("div#cards").get(0)
      DssRm.view_state.deselectAll()
,
  # Constants used in this view
  FID_CREATE_APPLICATION: -1
)
