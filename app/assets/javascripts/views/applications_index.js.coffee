DssRm.Views.ApplicationsIndex = Backbone.View.extend(
  tagName: "div"
  id: "applications"
  className: "row-fluid"
  
  initialize: (options) ->
    @$el.html JST["templates/applications/index"]()
    
    @cards = new DssRm.Views.ApplicationsIndexCards()
    @sidebar = new DssRm.Views.ApplicationsIndexSidebar()
  
  render: ->
    @$('#cards-area').replaceWith @cards.render().el
    @$('#sidebar-area').replaceWith @sidebar.render().el
    @
)
