describe "ApplicationsIndex", ->
  it "displays application cards and sidebar entities", ->
    data = getJSONFixture('dssrm.json')
    jasmine.log data.applications
    DssRm.initialize(data)
    @indexView = new DssRm.Views.ApplicationsIndex()
    @indexView.render()