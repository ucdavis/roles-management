DssRm.Views.ImpersonateDialog = Support.CompositeView.extend({
  tagName: "div",
  className: "modal",
  id: "impersonateDialogModal",

  events: {
    "hidden"             : "cleanUpModal",
    "click a.btn-primary": "impersonate",
    "keyup input#loginid": "checkLoginID"
  },

  initialize: function() {
    this.impersonate_user = null;

    this.$el.html(JST['application/impersonate_dialog']());
  },

  render: function() {

    return this;
  },

  impersonate: function() {
    window.location.href = Routes.admin_path(this.impersonate_user);
  },

  checkLoginID: function(e) {
    var loginid = $(e.currentTarget).val();
    var self = this;

    $.get(Routes.api_person_exists_path(loginid), function(exists) {
      if(exists) {
        // Write 'Ok' and enable the impersonate button
        $("#impersonateDialogModal span#loginid_status").html("<span style='color: #00aa00;'>Ok</span>");
        $(".modal-footer a.btn-primary").attr("disabled", false).removeClass("disabled");
        self.impersonate_user = loginid;
      } else {
        // Write 'Not Found' and disable the impersonate button
        $("#impersonateDialogModal span#loginid_status").html("<span style='color: #aa0000;'>Not found</span>");
        $(".modal-footer a.btn-primary").attr("disabled", true).addClass("disabled");
        self.impersonate_user = null;
      }
    });
  },

  cleanUpModal: function() {
    $("div#impersonateDialogModal").remove();

    // Need to change URL in case they want to open the same modal again
    Backbone.history.navigate("");
  }
});
