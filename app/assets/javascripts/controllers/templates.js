$(function() {
  // Filter templates on keyword search
  $("#search_templates").bind('change keyup', function() {
    var value = $(this).val();
    
    cards.visual_filter(value);
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
      $(templates.selected_template).data("uids", uids);
      site.sort_availability(uids);
    }
  });
  
});

(function (templates, $, undefined) {
  templates.templates = null; // will be filled in using the view
  templates.selected_template = null;
} (window.templates = window.templates || {}, jQuery));
