DssRm.Views.ApplicationShowAD = Backbone.View.extend(
  tagName: "span"
  events:
    "keyup input[name=ad_path]": "ad_path_check"

  render: ->
    @$el.html JST["templates/applications/show_ad"](role: @model)
    @$("label").html @model.escape("name")
    @$("input[name=ad_path]").val @model.escape("ad_path")
    @$("input[name=ad_path]").data "role-id", @model.id

    @
  
  ad_path_check: ->
    console.log 'ad_path_check'
)
