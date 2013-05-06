DssRm.Views.EntityShow ||= {}

class DssRm.Views.EntityShow
  constructor: (@model) ->
    type = @model.get("type")
    @entityView = null
    
    switch type
      when "Group" then @entityView = new DssRm.Views.GroupShow(model: @model)
      when "Person" then @entityView = new DssRm.Views.PersonShow(model: @model)
    
  render: ->
    @entityView.render()
