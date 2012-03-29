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
    $("div.card").css("box-shadow", "").css("border", "");
    
    // Highlight this card
    $(this).css("box-shadow", "#333 0 0 10px").css("border", "1px solid #777");
    
    // Re-sort the highlighted availability list based on who uses this template
    site.sort_availability($(this).data("uids"));
    
    // Record it
    templates.selected_template = $(this);
  });
  
  // Toggle template assignments on click
  $("#master_list>li").click(function() {
    if(templates.selected_template) {
      var id = parseInt($(this).data("id").toString().substr(1)); // convert from UID (remove leading digit)
      var template_id = $(templates.selected_template).data("template-id");
      
      // Save this assignment
      $.ajax({ url: Routes.templates_assign_path() + ".json", data: {template_assignment: {person_id: id, template_id: template_id}}, type: 'POST'}).always(
        function() {
          //console.log("done saving");
        }
      );
      
      // Update UI
      var uids = $(templates.selected_template).data("uids");
      uids.push($(this).data("id"));
      $(templates.selected_template).data("uids", uids);
      site.sort_availability(uids);
    }
  });
  $("#highlighted_results").on("click", "li", function() {
    if(templates.selected_template) {
      var id = parseInt($(this).data("id").toString().substr(1)); // convert from UID (remove leading digit)
      var template_id = $(templates.selected_template).data("template-id");
      
      // Delete this assignment
      $.ajax({ url: Routes.templates_unassign_path() + ".json", data: {template_assignment: {person_id: id, template_id: template_id}}, type: 'DELETE'}).always(
        function() {
          //console.log("done saving");
        }
      );
      
      // Update UI
      var uids = $(templates.selected_template).data("uids");
      uids = _.without(uids, $(this).data("id"));
      console.log(uids);
      $(templates.selected_template).data("uids", uids);
      site.sort_availability(uids);
    }
  });
  
});

(function (templates, $, undefined) {
  templates.templates = null; // will be filled in using the view
  templates.selected_template = null;
} (window.templates = window.templates || {}, jQuery));
