DssRm.Views.EntityShow ||= {}

class DssRm.Views.EntityShow
  constructor: (@model) ->
    @entityView = null
    
    switch @model.type()
      when EntityTypes.group then @entityView = new DssRm.Views.GroupShow(model: @model)
      when EntityTypes.person then @entityView = new DssRm.Views.PersonShow(model: @model)
  
  render: ->
    @entityView.render()
