// Let Underscore know we'll be using Mustache-style templates
_.templateSettings = {
    interpolate: /\{\{\=(.+?)\}\}/g,
    evaluate: /\{\{(.+?)\}\}/g
};

// Template-wide Javascript (setting up tabs, buttons, common callbacks, etc.)
(function (template, $, undefined) {
  // Condition (optional, values: "default", "error"), lifetime (milliseconds) to auto-hide (optional)
  template.status_text = function(message, condition, lifetime) {
    // Default parameters
    condition = typeof condition !== 'undefined' ? condition : "default";
    lifetime = typeof lifetime !== 'undefined' ? lifetime : 0;

    // Show the status bar and set it
    $("div#status_bar").fadeIn(250).html(message);

    if(condition == "error") {
      $("div#status_bar").addClass("status-bar-error");
    } else {
      $("div#status_bar").removeClass("status-bar-error");
    }

    if(lifetime > 0) {
      setTimeout(function() {
        $("div#status_bar").fadeOut(250);
      }, lifetime);
    }
  }

  template.hide_status = function() {
    $("div#status_bar").hide();
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

    $("#admin-ip-whitelist").click(application.ip_whitelist_dialog);

    $("#admin-about").click(application.about_dialog);

    // Enable tooltips
    $("body").tooltip({
      selector: '[rel=tooltip]',
      delay: { show: 400, hide: 75 }
    });

    // And fix buggy tooltips ...
    $("body").on("mouseout", "[rel=tooltip]", function() {
      $(this).tooltip("hide");
    });
  }

  application.impersonate_dialog = function() { application.open_dialog( Routes.admin_dialogs_impersonate_path(), "impersonate_modal" ) };
  application.about_dialog = function() { application.open_dialog( Routes.site_about_path(), "about_modal" ) };
  application.ip_whitelist_dialog = function() { application.open_dialog( Routes.admin_dialogs_ip_whitelist_path(), "whitelist_modal" ) };

  application.open_dialog = function(url, modal_dom_id) {
    template.status_text("Loading...");

    $.get(url, function(data) {
      template.hide_status();
      $("#modal_container").empty();
      $("#modal_container").append(data);
      $("#" + modal_dom_id).modal();
    });
  }
} (window.application = window.application || {}, jQuery));
