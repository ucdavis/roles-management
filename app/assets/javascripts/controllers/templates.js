$(function() {
  // Filter templates on keyword search
  $("#search_templates").bind('change keyup', function() {
    var value = $(this).val();
    
    if(value == "") {
      $("div.card").show();
      return;
    }
    
    var re = new RegExp(value, "i");
    
    var matched_cards = $("div.card").map(function(o, i) {
      var card_title = $(this).children("h3:first").html();
      
      if(card_title.search(re) != -1) {
        return $(this);
      }
      
      return null;
    });
      
    // Show only the matching cards
    $("div.card").hide();

    $(matched_cards).each(function() {
      $(this).show();
    });
  });
  
  // Allow clicking on templates to trigger their adherents
  $("div.card").on('click', function() {
    // Unhighlight other cards
    $("div.card").css("box-shadow", "");
    
    // Highlight this card
    $(this).css("box-shadow", "#333 0 0 10px");
    
    // Re-sort the highlighted availability list based on who uses this template
    site.sort_availability($(this).data("uids"));
  });
});

(function (templates, $, undefined) {
  templates.templates = null; // will be filled in using the view
} (window.templates = window.templates || {}, jQuery));
