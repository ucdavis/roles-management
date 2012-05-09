//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require bootbox.min
//= require bootstrap-modal
//= require bootstrap-transition
//= require bootstrap-typeahead
//= require jquery.tokeninput
//= require routes
//= require underscore-min
//= require details_modal
//= require_self

// Let Underscore know we'll be using Mustache-style templates
_.templateSettings = {
    interpolate: /\{\{\=(.+?)\}\}/g,
    evaluate: /\{\{(.+?)\}\}/g
};

// Template-wide Javascript (setting up tabs, buttons, common callbacks, etc.)
(function (template, $, undefined) {
  template.status_text = function(message) {
    $("div.status_bar").show().html(message);
  }
  
  template.hide_status = function() {
    $("div.status_bar").hide();
  }
} (window.template = window.template || {}, jQuery));

// For dynamic, nested attribute add/remove
function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().prev().children("tbody").append(content.replace(regexp, new_id));
}

$(function() {
  // Set up the token inputs
  $("#role_people_tokens").tokenInput($("#role_people_tokens").attr("method") + ".json", {
    crossDomain: false,
    prePopulate: $("#role_people_tokens").data("pre"),
    theme: "facebook"
  });

  $("#role_group_tokens").tokenInput($("#role_group_tokens").attr("method") + ".json", {
    crossDomain: false,
    prePopulate: $("#role_group_tokens").data("pre"),
    theme: "facebook"
  });

  $("#application_ou_tokens").tokenInput($("#application_ou_tokens").attr("method") + ".json", {
    crossDomain: false,
    prePopulate: $("#application_ou_tokens").data("pre"),
    theme: "facebook"
  });
  
  $("#classification_title_tokens").tokenInput($("#classification_title_tokens").attr("method") + ".json", {
    crossDomain: false,
    prePopulate: $("#classification_title_tokens").data("pre"),
    theme: "facebook"
  });
  
  // /people/new/:loginid specific
  $("input[name=fetch_ldap_details]").click(function() {
    var loginid = $("input[name=fetch_ldap_details_field]").val();
    document.location.href = document.location.href + "/" + loginid;
  });
	
  // Fix AJAX headers
  $.ajaxSetup({
    beforeSend: function (xhr, settings) {
      xhr.setRequestHeader("accept", '*/*;q=0.5, ' + settings.accepts.script);
    }
  });
  
  application.initialize();
});

(function (application, $, undefined) {
  application.current_user_id = null;
  application.impersonate_user = null;
  
  application.initialize = function() {
    $("#admin-impersonate").click(application.impersonate_dialog);
    $("#admin-unimpersonate").click(function() {
      window.location.href = Routes.admin_ops_unimpersonate_path();
    });
  }
  
  application.impersonate_dialog = function() {
    template.status_text("Loading...");
    
    $.get(Routes.admin_dialogs_impersonate_path(), function(data) {
      template.hide_status();
      $("#modal_container").empty();
      $("#modal_container").append(data);
      $("#impersonate_modal").modal();
    });
  }
} (window.application = window.application || {}, jQuery));
