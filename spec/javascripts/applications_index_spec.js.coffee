describe "ApplicationsIndex", ->
  # Set up the application and render the applicationsIndex view
  beforeEach ->
    @data = getJSONFixture('dssrm.json')
    DssRm.initialize(@data)
    @view = new DssRm.Views.ApplicationsIndex()
    @view.render()
  
  it "displays application cards and sidebar entities", ->
    jasmine.log @data.current_user
    expect(@view.el.nodeName).toEqual("DIV")
    jasmine.log '1'
    expect(@view.$el.find("#cards>.card").length).toBeGreaterThan(0)
    jasmine.log '2'
    expect(@view.$el.find("#sidebar #pins>li").length).toBeGreaterThan(0)
    jasmine.log '3'
    
    jasmine.log @view.$el.find("#sidebar>#pins")
