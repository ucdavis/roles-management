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
} (window.cards = window.cards || {}, jQuery));
