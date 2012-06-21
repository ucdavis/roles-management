// Not a site-wide JS file - the name implies use for the 'Site' controller

$(function() {
  applications.initialize();
});

(function (applications, $, undefined) {
  // Application and role relationship (filled in by index.html.erb)
  applications.applications = [];
  
  applications.selected_application = function() {
    return applications.applications[$(cards.selected_card).data("application-id")];
  }
  
  // Constructor of sorts
  applications.initialize = function() {
    $("#search_applications").typeahead({
      source: function(query, maxResults, callback) {
        // Populate the search drop down
        apps = []
        var exact_match_found = false;
        _.each(_.rest(applications.applications, 1), function(app) {
          if(~app.display_name.toLowerCase().indexOf(query.toLowerCase())) {
            if(app.display_name.toLowerCase() == query.toLowerCase()) exact_match_found = true;
            apps.push({id: app.id, label: app.display_name });
          }
        });
        if(exact_match_found == false) {
          // Add the option to create a new one with this query
          apps.push({id: -1, label: "Create " + query});
        }
        
        callback(apps);
      },
      valueField: 'id',
      labelField: 'label'
    }).keyup(function() {
      // .typeahead won't be called if they clear the field but we still need to update the visual filtering
      cards.visual_filter($(this).val());
    }).change(function() {
      var selected_id = $(this).attr('data-value');
      
      if(selected_id == -1) {
        template.status_text("Creating application...");
        // They want to create a new application
        var app = {};
        app.name = $(this).val().slice(7); // cut off the "Create " at the beginning
        app.owner_ids = [application.current_user_id];
        $.ajax({ url: Routes.applications_path() + ".json", data: {application: app}, type: 'POST'}).always(
          function(data) {
            template.hide_status();
            // Add to the applications list
            applications.applications[data.id] = data;
            // Clear out the input
            $("#search_applications").val("");
            cards.visual_filter("");
            // Render out the card
            cards.render_cards();
            // Bring up the details window
            cards.entity_details('4' + data.id);
          }
        );
        
      }
    });
  }
} (window.applications = window.applications || {}, jQuery));
