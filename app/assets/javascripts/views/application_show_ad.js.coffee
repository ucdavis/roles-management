DssRm.Views.ApplicationShowAD = Backbone.View.extend(
  tagName: "span"

  render: ->
    @$el.html JST["applications/show_ad"](role: @model)
    @$("label").html @model.escape("name")
    @$("input[name=ad_path]").val @model.escape("ad_path")
    @$("input[name=ad_path]").data "role-id", @model.id

    this
)
