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
    # Click on roles tab, ensure it shows
    # jasmine.log @view.$("ul.nav li>a[href='#roles']")
    # @view.$("ul.nav li>a[href='#roles']").click()
    # 
    # waitsFor(  =>
    #   @view.$(".tab-content .active[id=roles]").length == 1
    # , 'bootstrap tab switcher, assuming failure', 2000);
    # 
    # expect(@view.$(".tab-content .active[id=roles]").length).toEqual(1)
    # 
    # jasmine.log @view.$(".tab-content .active").attr('id')
    
    # Click on 'Add Role', ensure it adds a row to the table
    row_count = @view.$('.tab-pane#roles table>tbody>tr').length
    @view.$('.tab-pane#roles button#add_role').click()
    expect(@view.$('.tab-pane#roles table>tbody>tr').length).toEqual(row_count + 1)
    
    # Fill in role information and click 'Apply Changes', ensuring that they're there after reload
    @view.$(".tab-pane#roles table>tbody>tr:last td input[name=name]").val('test name')
    @view.$(".tab-pane#roles table>tbody>tr:last td input[name=token]").val('test-token')
    @view.$(".tab-pane#roles table>tbody>tr:last td input[name=description]").val('a test description')
    
    @view.$(".modal-footer button#apply").click()
    
    
    
    #jasmine.log @view.$('.tab-pane#roles')
    
    #expect(0).toEqual(1)
    
    #jasmine.log @data.current_user
    # expect(@view.el.nodeName).toEqual("DIV")
    # expect(@view.$el.find("#cards>.card").length).toBeGreaterThan(0)
    # expect(@view.$el.find("#sidebar>#pins>li").length).toBeGreaterThan(0)

  it "can remove a role", ->
    #jasmine.log @data.current_user
    # expect(@view.el.nodeName).toEqual("DIV")
    # expect(@view.$el.find("#cards>.card").length).toBeGreaterThan(0)
    # expect(@view.$el.find("#sidebar>#pins>li").length).toBeGreaterThan(0)
