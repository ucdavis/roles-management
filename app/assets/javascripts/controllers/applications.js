// Not a site-wide JS file - the name implies use for the 'Site' controller

$(function() {
  site.initialize();
});

(function (site, $, undefined) {
  // Application and role relationship (filled in by index.html.erb)
  site.applications = [];
  site.current_user_id = null;
  site.impersonate_user = null;
  
  // Constructor of sorts
  site.initialize = function() {
    // Set up the virtual application preferences
    $("div.card div.card_head").hover(
      function() {
        // hover in
        $(this).children("i").css("display", "block");
      },
      function() {
        // hover out
        $(this).children("i").css("display", "none");
      }
    );
  
    // Set up the impersonate functionality
    $("p.user a#impersonate_switch").click(function() {
      site.impersonate_dialog();
    });
        
    $("#search_applications").typeahead({
      source: function(query, maxResults, callback) {
        // Populate the search drop down
        apps = []
        var exact_match_found = false;
        _.each(_.rest(site.applications, 1), function(app) {
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
    });
    
    // .typeahead won't be called if they clear the field but we still need to update the visual filtering
    $("#search_applications").keyup(function() {
      cards.visual_filter($(this).val());
    });
    
    // Establish hover for application details
    $("div.card .card-title").hover(
      function() {
        // hover in
        $(this).children("i").css("display", "block");
      },
      function() {
        // hover out
        $(this).children("i").css("display", "none");
      }
    );
    $("div.card .card-title i").click(function() {
      site.entity_details('4' + $(this).parent().parent().data("application-id"));
    });
  }
  
  // Displays the virtual application preferences for administrators
  site.prefs = function(app_id) {
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
  site.register_role = function(entity, role, dom_only) {
    if(dom_only == undefined) { dom_only = false; }
    
    console.log("Register role called");
    
    // Update the DOM
    // Only do this if the current user has management access to the app
    if($("div.card[data-application-id=" + role.application_id + "]").length > 0) {
      // If the pin doesn't exist, create it.
      if($("div.card[data-application-id=" + role.application_id + "] div.pin[data-entity-id=" + entity.id + "]").length == 0) {
        var el = $( "<div class=\"pin\" data-application-id=\"" + role.application_id + "\" data-entity-id=\"" + entity.id + "\"></div>" );
        var el_html = "<i class=\"icon-search\" id=\"entity_details\"></i><a href=\"#\">" + entity.name + "</a> \
                       <i class=\"icon-remove\" onClick=\"site.remove_pin($(this));\"></i> \
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
        for(var i = 0; i < site.applications[role.application_id].roles.length; i++) {
          var r = site.applications[role.application_id].roles[i];
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
          site.entity_details(entity.id);
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
  site.remove_pin = function (el) {
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

  site.entity_details = function (entity_id) {
    var entity_type = entity_id.toString()[0];
    var entity_id = entity_id.toString().substr(1);
    var details_url = null;
    
    if(entity_type == '1') {
      // person
      details_url = Routes.people_path() + "/" + entity_id;
    } else if(entity_type == '2') {
      // group
      details_url = Routes.groups_path() + "/" + entity_id;
    } else {
      // application
      details_url = Routes.applications_path() + "/" + entity_id;
    }
    
    template.status_text("Fetching details...");
    
    $.get(details_url, function(response) {
      template.hide_status();
      $("#modal_container").empty();
      $("#modal_container").append(response);
      $("#person_modal").modal();
      details_modal.init();
    });
  }
  
  // Creates a group for the current user named 'name' and returns the group entity
  site.create_group = function (name) {
    $.get(Routes.new_group_path() + ".json", function(group) {
      group.name = name;
      group.owner_tokens = '1' + site.current_user_id;
      
      template.status_text("Creating group...");
      
      $.post(Routes.groups_path() + ".json", {group: group}, function (data, status) {
        template.hide_status();
        // Reset the 'New Group' entity
        $("div#groups ul.pins li.new").remove();
        $("div#groups ul.pins").append("<li class=\"new\" data-pin-type=\"group\" data-pin-entity=\"0\">Create New Group</li>");
        $("ul.pins li.new").click(site.new_group_pin_click);
        
        // Create a new group pin with the entity and reset the blank 'New Group' one
        site.add_to_available_list(data);
      });      
    });
  }
  
  site.new_group_pin_click = function() {
    $(this).html("<input type=\"text\" style=\"border: 0; background: none; font-size: 12px;\" />");
    $(this).children("input").keypress(function(event) {
      if ( event.which == 13 ) {
        site.create_group($(this).val());
        
        event.preventDefault();
      }
    });
    $(this).children("input").focus();
  }
  
  site.delete_group = function (group_pin) {
    var group_id = group_pin.id.toString().substr(1);
    
    if (apprise("Really delete this group?",
    {'verify': true, 'textYes': "Delete Group", 'textNo': "Cancel"}, function(confirm_delete) {
      if(confirm_delete) {
        template.status_text("Deleting group...");
    
        // Delete the group
        $.ajax({ url: Routes.group_path(group_id) + ".json", data: {}, type: 'DELETE', complete: function(data, status) {
          template.hide_status();
          // Remove the pin (Note: status = 'parseerror' because jQuery doesn't like blank 200 OK ajax responses. Ignore this.)
          var el = $("ul.pins li[data-group-id=" + group_pin.id + "]");
          el.fadeOut('fast', function() {
            $(el).remove();
          }); // fade out from the DOM
        }});
      }
    }));
  }
  
  site.add_to_available_list = function (entity) {
    // Person or group entity?
    var type = entity.id.toString()[0];
    
    var el = $("<li data-tooltip=\"Drag these over to the desired applications on the left.\">" + entity.name + "</li>");
    $(el).data("pin-entity", entity);
    
    // Delete button on hover
    $(el).hover(
      function() {
        // mouse enter
        $(this).children("i").css("display", "block");
      },
      function() {
        // mouse leave
        $(this).children("i").css("display", "none");
      }
    );
    
    if(type == '1') {
      // Person
      $(el).attr("data-pin-type", "person");
      $(el).attr("data-id", entity.id);
      $(el).attr("data-search-value", entity.name);
      $(el).html("<i class=\"icon-search\" onClick=\"javascript:site.entity_details(" + entity.id + ");\"></i>" + entity.name);
      $("#master_list").append(el);
    } else if (type == '2') {
      // Group
      $(el).attr("data-pin-type", "group");
      $(el).attr("data-id", entity.id);
      $(el).attr("data-search-value", entity.name);
      $(el).html("<i class=\"icon-remove\" onClick=\"javascript:site.delete_group($(this).parent().data('pin-entity'));\"></i> <i class=\"icon-search\" style=\"float: right; cursor: pointer; display: none;\" onClick=\"javascript:site.entity_details(" + entity.id + ");\"></i>" + entity.name);
      $(el).addClass("group");
      $("#master_list").append(el);
    } else {
      // Unknown
      console.log("Cannot add entity to availability list, unknown type.");
    }
  }
  
  site.impersonate_dialog = function() {
    template.status_text("Loading...");
    
    $.get(Routes.admin_dialogs_impersonate_path(), function(data) {
      template.hide_status();
      apprise(data, {'animate': true, 'verify': true, 'textYes': 'Impersonate', 'textNo': 'Cancel'}, function(impersonate) {
        if(impersonate) {
          // Redirect to impersonation URL
          window.location.href = Routes.admin_path(site.impersonate_user);
        }
      });
    });
  }
  
  // Graphically sorts the right-hand availability list based on terms in 'str'
  site.sort_availability = function(ids) {
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
} (window.site = window.site || {}, jQuery));
