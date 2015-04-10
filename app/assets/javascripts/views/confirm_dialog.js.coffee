DssRm.Views.ConfirmDialog = Backbone.View.extend(
  tagName: "div"
  className: "modal"
  id: "confirmDialogModal"
  events:
    "hidden"         : "cleanUpModal"
    "click a#confirm": "userConfirmed"

  initialize: ->
    @$el.html JST["templates/application/confirm_dialog"]()

  render: ->
    application = DssRm.view_state.getSelectedApplication()
    @$("span#entity_name").html @options.entity.get('name')
    @$("span#role_name").html @options.role.get('name')
    @$("span#application_name").html application.get('name')
    @

  userConfirmed: ->
    @options.confirm()

    @$(".modal-header a.close").trigger "click"

    false # to prevent the anchor from navigating

  cleanUpModal: ->
    @remove()
)
