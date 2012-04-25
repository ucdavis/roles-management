// Functions to interact on any page utilizing 'cards' (Manage & Template pages, namely)

$(function() {
  cards.initialize();
});

(function (cards, $, undefined) {
  cards.cards = null; // will be filled in using the view
  cards.selected_card = null;
  cards.template = null;
  
  cards.initialize = function() {
    // Set up the virtual card preferences
    $("div#left").on("mouseenter mouseleave", "div#cards div.card div.card-title", function(e) {
      if(e.type == "mouseenter") {
        $(this).children("i").css("display", "block");
      } else {
        // hover out
        $(this).children("i").css("display", "none");
      }
    });
    
    // Establish hover for card details
    $("div#left").on("click", "div#cards div.card div.card-title i", function() {
      applications.entity_details('4' + $(this).parent().parent().data("application-id"));
    });
    
    // Allow clicking on cards to trigger their adherents
    $("div#left").on("click", "div#cards div.card", function() {
      // Unhighlight other cards
      $("div.card").css("box-shadow", "").css("border", "");
    
      // Highlight this card
      $(this).css("box-shadow", "#333 0 0 10px").css("border", "1px solid #777");
    
      // Re-sort the highlighted availability list based on who uses this template
      cards.sort_availability($(this).data("uids"));
    
      // Record it
      cards.selected_card = $(this);
    });
    
    // Render the application cards
    cards.template = $("#tmpl-card").html();
    _.each(applications.applications, function(app) {
      var compiledTmpl = _.template(cards.template, { app: app });
      $("div#cards").append(compiledTmpl);
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
  
  // Graphically sorts the right-hand availability list based on terms in 'str'
  cards.sort_availability = function(ids) {
    console.log(ids);
    // Clear out the existing list (fade out li elements and destroy since they are clones)
    $("#highlighted_results>li").animate({
      opacity: 0
    }, 200, function() {
      $(this).remove(); // it is a cloned element and safe to delete
    });
    
    if(typeof ids == "undefined") return;
    
    // Generate a list of matching li elements
    var matched_lis = $("#master_list>li").map(function(o, i) {
      var id = $(this).data("id");
      
      if(_.include(ids, id)) {
        return $(this);
      }
      
      return null;
    });
    
    // Calculate some values needed for animation (assumes at least two lis in #master_list)
    var item_height = $("#master_list").find("li:nth-child(2)").offset().top - $("#master_list").find("li:nth-child(1)").offset().top;
    var list_start_y = $("#highlighted_results").offset().top;
    var item_offset_y = list_start_y;
    
    // Begin moving #master_list out of the way
    $("#master_list").css("width", $("#master_list").width()).css("position", "absolute").css("top", $("#master_list").offset().top).animate({
      top: list_start_y + (item_height * $(matched_lis).length) + 2
    }, 900, function() {
      $(this).css("position", "static");
    });
    
    // Clone and animate the matches
    $(matched_lis).each(function() {
      var old_coords = $(this).offset(); // remember the non-cloned position - this is where the animation starts
      var new_li = $(this).clone().css("width", $(this).width()).css("opacity", 0).css("position", "absolute");
      $("#highlighted_results").append(new_li); // add it to the new list
      $(new_li).css("top", old_coords.top).css("left", old_coords.left).css("z-index", 100);
      
      // Set it to animate
      $(new_li).animate({
        opacity: 1.0,
        top: item_offset_y
      }, 700, function() {
        $(this).css("position", "static").css("z-index", "auto");
      });
      
      item_offset_y += item_height;
    });
  }
  
} (window.cards = window.cards || {}, jQuery));
