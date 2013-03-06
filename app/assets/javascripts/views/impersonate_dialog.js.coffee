DssRm.Views.ImpersonateDialog = Support.CompositeView.extend(
  tagName: "div"
  className: "modal"
  id: "impersonateDialogModal"
  events:
    "hidden"              : "cleanUpModal"
    "click a.btn-primary" : "impersonate"
    "keyup input#loginid" : "checkLoginID"
    "shown"               : "postInitialize"

  initialize: ->
    @impersonate_user = null
    @$el.html JST["application/impersonate_dialog"]()
    
  postInitialize: ->
    @$("input#loginid").focus()

  render: ->
    this

  impersonate: ->
    window.location.href = Routes.admin_path(@impersonate_user)

  checkLoginID: (e) ->
    loginid = $(e.currentTarget).val()
    self = this
    return  if loginid.length < 3
    $.get Routes.people_path() + "?q=" + loginid, (results) ->
      if _.find(results, (r) ->
        r.loginid is loginid
      ) isnt `undefined`
        
        # Write 'Ok' and enable the impersonate button
        $("#impersonateDialogModal span#loginid_status").html "<span style='color: #00aa00;'>Ok</span>"
        $(".modal-footer a.btn-primary").attr("disabled", false).removeClass "disabled"
        self.impersonate_user = loginid
      else
        
        # Write 'Not Found' and disable the impersonate button
        $("#impersonateDialogModal span#loginid_status").html "<span style='color: #aa0000;'>Not found</span>"
        $(".modal-footer a.btn-primary").attr("disabled", true).addClass "disabled"
        self.impersonate_user = null


  cleanUpModal: ->
    $("div#impersonateDialogModal").remove()
    
    # Need to change URL in case they want to open the same modal again
    Backbone.history.navigate ""
)