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
  
  // Remove a dropped pin from the app list
  templates.remove_pin = function (el) {
    // Since this implies removing all permissions, prompt them first on this
    bootbox.confirm("This action will remove all permissions from the entity. Continue?", function(confirmed) {
      if(confirmed) {
        // Unassign any checked permissions
        template.status_text("Removing...");
        $(el).parent().find("div.pin-content span.permission input[type=checkbox]").each(function() {
          var assignment = {};
          
          assignment.role_id = $(this).attr("data-role-id");
          assignment.uid = $(this).parent().parent().parent().attr("data-entity-id");
          
          $.ajax({ url: Routes.roles_unassign_path() + ".json", data: {assignment: assignment}, type: 'DELETE'});
        });
        template.hide_status();
        
        // Remove the element
        var ol = $(el).parent().parent();
        $(el).parent().remove();
        
        // If there are no more pins, insert the placerholder text
        if(ol.children().length == 0) {
          ol.append("<div class=\"placeholder\">Drag people and groups here</div>");
        }
      }
    });
  }

  // Creates a group for the current user named 'name' and returns the group entity
  templates.create_group = function (name) {
    $.get(Routes.new_group_path() + ".json", function(group) {
      group.name = name;
      group.owner_tokens = '1' + application.current_user_id;
      
      template.status_text("Creating group...");
      
      $.post(Routes.groups_path() + ".json", {group: group}, function (data, status) {
        template.hide_status();
        // Reset the 'New Group' entity
        $("div#groups ul.pins li.new").remove();
        $("div#groups ul.pins").append("<li class=\"new\" data-pin-type=\"group\" data-pin-entity=\"0\">Create New Group</li>");
        $("ul.pins li.new").click(applications.new_group_pin_click);
        
        // Create a new group pin with the entity and reset the blank 'New Group' one
        applications.add_to_available_list(data);
      });      
    });
  }
  
  templates.new_group_pin_click = function() {
    $(this).html("<input type=\"text\" style=\"border: 0; background: none; font-size: 12px;\" />");
    $(this).children("input").keypress(function(event) {
      if ( event.which == 13 ) {
        applications.create_group($(this).val());
        
        event.preventDefault();
      }
    });
    $(this).children("input").focus();
  }
} (window.templates = window.templates || {}, jQuery));
