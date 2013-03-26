describe "ApplicationsIndex", ->
  it "displays application cards and sidebar entities", ->
    data = getJSONFixture('current_user.json')
    jasmine.log data
    @indexView = new DssRm.Views.ApplicationsIndex()
    @indexView.render()