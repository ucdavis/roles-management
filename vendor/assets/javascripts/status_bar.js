// Status Bar micro-library
// Version 0.8
// Copyright (C) 2012 Christopher Thielen
// Licensed under the MIT open source licenses

(function (status_bar, $, undefined) {
  status_bar.initialized = false;
  status_bar.$el = null;

  // Inserts the needed 'div' at the bottom of <body>, initially hidden
  status_bar._initialize = function() {
    status_bar.$el = $('<div id="status_bar" class="status-bar"></div>');

    $('body').append(status_bar.$el);

    status_bar.initialized = true;
  },

  // Displays the status bar
  // Parameters:
  //    condition (optional, values: "default", "error"),
  //    lifetime (milliseconds) to auto-hide (optional, 0 implies unlimited lifetime)
  status_bar.show = function(message, condition, lifetime) {
    if(status_bar.initialized == false) status_bar._initialize();

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
  },

  // Hides the status bar
  status_bar.hide = function() {
    if(status_bar.initialized == false) status_bar._initialize();

    $("div#status_bar").hide();
  }
} (window.status_bar = window.status_bar || {}, jQuery));
