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
    console.log("click");
  });
});

(function (templates, $, undefined) {
  templates.templates = null; // will be filled in using the view
} (window.templates = window.templates || {}, jQuery));
