$(function() {
  $("#search_templates").change(function() {
    var value = $(this).val();
    
    if(value == "") {
      $("div.card").show();
      return;
    }
    
    // Hide all cards
    $("div.card").hide();
    
    // Show only the matching templates
    $("div.card").each(function(i, o) {
      if($(o).children("h3").html() == value) {
        $(o).show();
      }
    });
  });
});

(function (templates, $, undefined) {
  templates.templates = null; // will be filled in using the view
} (window.templates = window.templates || {}, jQuery));
