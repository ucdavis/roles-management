// Functions to interact on any page utilizing 'cards' (Manage & Template pages, namely)

$(function() {
  cards.initialize();
});

(function (cards, $, undefined) {
  cards.cards = null; // will be filled in using the view
  cards.selected_card = null;
  
  cards.initialize = function() {
    // Allow clicking on cards to trigger their adherents
    $("div.card").on('click', function() {
      // Unhighlight other cards
      $("div.card").css("box-shadow", "").css("border", "");
    
      // Highlight this card
      $(this).css("box-shadow", "#333 0 0 10px").css("border", "1px solid #777");
    
      // Re-sort the highlighted availability list based on who uses this template
      site.sort_availability($(this).data("uids"));
    
      // Record it
      cards.selected_card = $(this);
    });
    
  }
  
  // Shows and hides the div.card elements based on 'query' matching each .card-title>h3
  cards.visual_filter = function(query) {
    // Also filter the application cards themselves
    if(query.length > 0) {
      var re = new RegExp(query, "i");
      
      // Search the card titles
      var matched_cards = $("div.card").map(function(o, i) {
        var card_title = $(this).find(".card-title h3:first").html();
            
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
    } else {
      $("div.card").show();
    }
  }
} (window.cards = window.cards || {}, jQuery));
