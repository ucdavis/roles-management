describe "GroupShow", ->
  # Set up the application and render the applicationsIndex view
  beforeEach ->
    @data = getJSONFixture('dssrm.json')
    DssRm.initialize(@data)
    @view = new DssRm.Views.ApplicationsIndex()
    @view.render()
  
  it "displays basic group information", ->
    jasmine.log @data.current_user
    # expect(@view.el.nodeName).toEqual("DIV")
    # expect(@view.$el.find("#cards>.card").length).toBeGreaterThan(0)
    # expect(@view.$el.find("#sidebar>#pins>li").length).toBeGreaterThan(0)

  it "updates members when a rule changes", ->
    jasmine.log @data.current_user
    # expect(@view.el.nodeName).toEqual("DIV")
    # expect(@view.$el.find("#cards>.card").length).toBeGreaterThan(0)
    # expect(@view.$el.find("#sidebar>#pins>li").length).toBeGreaterThan(0)
