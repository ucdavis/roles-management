$(function() {
  templates.initialize();
});

(function (templates, $, undefined) {
  // Application and role relationship (filled in by index.html.erb)
  templates.templates = [];
  
  templates.selected_template = function() {
    return templates.templates[$(cards.selected_card).data("application-id")];
  }
  
  // Constructor of sorts
  templates.initialize = function() {
    $("#search_templates").typeahead({
      source: function(query, maxResults, callback) {
        // Populate the search drop down
        templates = []
        var exact_match_found = false;
        _.each(_.rest(templates.templates, 1), function(template) {
          if(~template.name.toLowerCase().indexOf(query.toLowerCase())) {
            if(template.name.toLowerCase() == query.toLowerCase()) exact_match_found = true;
            templates.push({id: template.id, label: template.name });
          }
        });
        if(exact_match_found == false) {
          // Add the option to create a new one with this query
          templates.push({id: -1, label: "Create " + query});
        }
        
        callback(templates);
      },
      valueField: 'id',
      labelField: 'label'
    }).keyup(function() {
      // .typeahead won't be called if they clear the field but we still need to update the visual filtering
      cards.visual_filter($(this).val());
    }).change(function() {
      var selected_id = $(this).attr('data-value');
      
      if(selected_id == -1) {
        template.status_text("Creating template...");
        // They want to create a new template
        var tmpl = {};
        tmpl.name = $(this).val().slice(7); // cut off the "Create " at the beginning
        $.ajax({ url: Routes.templates_path() + ".json", data: {template: tmpl}, type: 'POST'}).always(
          function(data) {
            template.hide_status();
            // Add to the templates list
            templates.templates[data.id] = data;
            // Render out the card
            var compiledTmpl = _.template(cards.template, { item: data });
            $("div#cards").append(compiledTmpl);
            // Bring up the details window
            cards.entity_details('5' + data.id);
            // Clear out the input
            $("#search_templates").val("");
            cards.visual_filter("");
          }
        );
        
      }
    });
  }
} (window.templates = window.templates || {}, jQuery));
