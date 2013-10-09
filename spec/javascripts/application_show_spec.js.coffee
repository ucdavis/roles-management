describe "ApplicationShow", ->
  # Set up the application and render the applicationsIndex view
  beforeEach ->
    @data = getJSONFixture('dssrm.json')
    DssRm.initialize(@data)
    
    @application = DssRm.applications.first()
    @view = new DssRm.Views.ApplicationShow(model: @application)
    @view.render()
  
  it "displays basic application details", ->
    expect(@view.el.nodeName).toEqual("DIV")
    expect(@view.$el.find("h3").html()).toEqual(@application.get('name'))

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
