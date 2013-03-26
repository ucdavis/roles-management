describe "ApplicationsIndex", ->
  it "displays application cards and sidebar entities", ->
    jasmine.log DssRm
    @indexView = new DssRm.Views.ApplicationsIndex()
    #@indexView.render()