// Not a site-wide JS file - the name implies use for the 'Site' controller

$(function() {
  applications.initialize();
});

(function (applications, $, undefined) {
  // Application and role relationship (filled in by index.html.erb)
  applications.applications = [];
  applications.current_user_id = null;
  applications.impersonate_user = null;
  
  // Constructor of sorts
  applications.initialize = function() {
    // Set up the impersonate functionality
    $("p.user a#impersonate_switch").click(function() {
      applications.impersonate_dialog();
    });
    
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
        var application = {};
        application.name = $(this).val().slice(7); // cut off the "Create " at the beginning
        application.owner_ids = [current_user_id];
        $.ajax({ url: Routes.applications_path() + ".json", data: {application: application}, type: 'POST'}).always(
          function(data) {
            template.hide_status();
            // Add to the applications list
            applications.applications[data.id] = data;
            // Render out the card
            var compiledTmpl = _.template(cards.template, { app: data });
            $("div#cards").append(compiledTmpl);
            // Bring up the details window
            applications.entity_details('4' + data.id);
            // Clear out the input
            $("#search_applications").val("");
            cards.visual_filter("");
          }
        );
        
      }
    });
  }
  
  // Displays the virtual application preferences for administrators
  applications.prefs = function(app_id) {
    details_url = Routes.applications_path() + "/" + app_id;
    
    template.status_text("Fetching details...");
    
    $.get(details_url, function(data) {
      template.hide_status();
      apprise(data, {'animate': true, 'textOk': 'Dismiss'});
      details_modal.init();
      var scope = $("div#entity_details");
      template.setup_sidebar(scope);
      template.setup_default_text(scope);
    });
  }
  
  // Updates or creates pins to represent the roles it's given. Can be called multiple times for the same app/role
  // dom_only = don't make the AJAX call to actually save the permission. Useful when merely constructing the existing list
  applications.register_role = function(entity, role, dom_only) {
    if(dom_only == undefined) { dom_only = false; }
    
    console.log("Register role called");
    
    // Update the DOM
    // Only do this if the current user has management access to the app
    if($("div.card[data-application-id=" + role.application_id + "]").length > 0) {
      // If the pin doesn't exist, create it.
      if($("div.card[data-application-id=" + role.application_id + "] div.pin[data-entity-id=" + entity.id + "]").length == 0) {
        var el = $( "<div class=\"pin\" data-application-id=\"" + role.application_id + "\" data-entity-id=\"" + entity.id + "\"></div>" );
        var el_html = "<i class=\"icon-search\" id=\"entity_details\"></i><a href=\"#\">" + entity.name + "</a> \
                       <i class=\"icon-remove\" onClick=\"applications.remove_pin($(this));\"></i> \
                       <div class=\"pin-content\"></div>";
    
        $(el).html( el_html );
        $(el).hover(
          function() {
            // hover in
            $(this).children("i").css("display", "block");
          },
          function() {
            // hover out
            $(this).children("i").css("display", "none");
          }
        );
    
        // Add the permissions list
        for(var i = 0; i < applications.applications[role.application_id].roles.length; i++) {
          var r = applications.applications[role.application_id].roles[i];
          $(el).children("div.pin-content").append("<span class=\"permission\"><input type=\"checkbox\" data-app-id=\"" + role.application_id + "\" data-role-id=\"" + r.id + "\" /> (<b>" + r.descriptor + "</b>) " + r.description + "</span>");
        }
      
        // Register the checkbox callbacks (to set/unset permissions via AJAX)
        $(el).find("div.pin-content span.permission input[type=checkbox]").change(function() {
          var assignment = {};
        
          assignment.role_id = $(this).attr("data-role-id");
          assignment.entity_id = $(this).parent().parent().parent().attr("data-entity-id");
        
          // Turning the permission on or off?
          if($(this).attr("checked") == undefined) {
            // off
            template.status_text("Saving...");
            $.ajax({ url: Routes.roles_unassign_path() + ".json", data: {assignment: assignment}, type: 'DELETE'}).always(
              function() {
                template.hide_status();
              }
            );
          } else {
            // on
            template.status_text("Saving...");
            $.ajax({ url: Routes.roles_assign_path() + ".json", data: {assignment: assignment}, type: 'POST'}).always(
              function() {
                template.hide_status();
              }
            );
          }
        });
    
        $(el).children("#entity_details").click(function() {
          applications.entity_details(entity.id);
        });
    
        $(el).children("a").click(function() {
          $(this).parent().children("div.pin-content").slideToggle('fast');
          return false;
        });
      
        // Change the pin color if this is a group
        if(String(entity.id)[0] == '2') {
          $(el).addClass("group");
        }
      
        var pin_list = $("div.card[data-application-id=" + role.application_id + "]").children("div.card-content").children("div.pins");
        
        $(pin_list).append(el);
      
        // Remove the placeholder image (if it's still there)
        $(pin_list).find( ".placeholder" ).remove();
      }
    }
    
    // Save this permission assignment
    if( dom_only == false) {
      template.status_text("Saving...");
      $.ajax({ url: Routes.roles_assign_path() + ".json", data: {assignment: {role_id: role.id, entity_id: entity.id}}, type: 'POST'}).always(
        function() {
          template.hide_status();
        }
      );
    }
    
    // Check the box representing this permission
    $("div.pin div.pin-content span.permission input[type=checkbox][data-app-id=" + role.application_id + "][data-role-id=" + role.id + "]").prop("checked", true);
    
    return true;
  }
  
  // Remove a dropped pin from the app list
  applications.remove_pin = function (el) {
    // Since this implies removing all permissions, prompt them first on this
    bootbox.confirm("This action will remove all permissions from the entity. Continue?", function(confirmed) {
      if(confirmed) {
        // Unassign any checked permissions
        template.status_text("Removing...");
        $(el).parent().find("div.pin-content span.permission input[type=checkbox]").each(function() {
          var assignment = {};
          
          assignment.role_id = $(this).attr("data-role-id");
          assignment.entity_id = $(this).parent().parent().parent().attr("data-entity-id");
          
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
  applications.create_group = function (name) {
    $.get(Routes.new_group_path() + ".json", function(group) {
      group.name = name;
      group.owner_tokens = '1' + applications.current_user_id;
      
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
  
  applications.new_group_pin_click = function() {
    $(this).html("<input type=\"text\" style=\"border: 0; background: none; font-size: 12px;\" />");
    $(this).children("input").keypress(function(event) {
      if ( event.which == 13 ) {
        applications.create_group($(this).val());
        
        event.preventDefault();
      }
    });
    $(this).children("input").focus();
  }
  
  applications.impersonate_dialog = function() {
    template.status_text("Loading...");
    
    $.get(Routes.admin_dialogs_impersonate_path(), function(data) {
      template.hide_status();
      apprise(data, {'animate': true, 'verify': true, 'textYes': 'Impersonate', 'textNo': 'Cancel'}, function(impersonate) {
        if(impersonate) {
          // Redirect to impersonation URL
          window.location.href = Routes.admin_path(applications.impersonate_user);
        }
      });
    });
  }
} (window.applications = window.applications || {}, jQuery));
