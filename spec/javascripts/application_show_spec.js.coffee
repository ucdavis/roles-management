describe "ApplicationShow", ->
  # Set up the application and render the applicationsIndex view
  beforeEach ->
    @data = getJSONFixture('dssrm.json')
    DssRm.initialize(@data)
    @view = new DssRm.Views.ApplicationsIndex()
    @view.render()
  
  it "displays basic application details", ->
    #jasmine.log @data.current_user
    #expect(@view.el.nodeName).toEqual("A")
    # expect(@view.el.nodeName).toEqual("DIV")
    # expect(@view.$el.find("#cards>.card").length).toBeGreaterThan(0)
    # expect(@view.$el.find("#sidebar>#pins>li").length).toBeGreaterThan(0)

  it "can add a role", ->
    #jasmine.log @data.current_user
    # expect(@view.el.nodeName).toEqual("DIV")
    # expect(@view.$el.find("#cards>.card").length).toBeGreaterThan(0)
    # expect(@view.$el.find("#sidebar>#pins>li").length).toBeGreaterThan(0)

  it "can remove a role", ->
    #jasmine.log @data.current_user
    # expect(@view.el.nodeName).toEqual("DIV")
    # expect(@view.$el.find("#cards>.card").length).toBeGreaterThan(0)
    # expect(@view.$el.find("#sidebar>#pins>li").length).toBeGreaterThan(0)
