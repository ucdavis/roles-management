// Not a site-wide JS file - the name implies use for the 'Site' controller

$(function() {
  // Set up the drag-and-drop
  $( "div.pins" ).droppable({
    activeClass: "ui-state-default",
    hoverClass: "ui-state-hover",
    accept: ":not(.ui-sortable-helper)",
    drop: function( event, ui ) {
      // Get the app ID for this card based on where they dropped the pin
      var app = $.parseJSON($(this).parent().parent().attr("data-application"));
      var entity = $(ui.draggable).data("pin-entity");
	    
      // Ensure this entity isn't already dragged onto this card
      if($("div.card[data-application-id=" + app.id + "] div.pins div.pin[data-entity-id=" + entity.id + "]").length == 0) {
        // Determine the default and mandatory roles for this application and pass them all along
  	    for(var i = 0; i < app.roles.length; i++) { 
          if(app.roles[i].default == true || app.roles[i].mandatory == true) {
  	  	    site.register_role(entity, app.roles[i]);
          }
  	    }
      }
    }
  }).sortable({
    items: "li:not(.placeholder)",
    sort: function() {
      // gets added unintentionally by droppable interacting with sortable
      // using connectWithSortable fixes this, but doesn't allow you to customize active/hoverClass options
      $( this ).removeClass( "ui-state-default" );
    }
  });
  
  // Set up the new group button functionality
  $("ul.pins li.new").click(site.new_group_pin_click);
  
  // Set up the virtual application preferences
  $("div.card div.card_head").hover(
    function() {
      // hover in
      $(this).children("img").css("display", "block");
    },
    function() {
      // hover out
      $(this).children("img").css("display", "none");
    }
  );
});

(function (site, $, undefined) {
  // Application and role relationship (filled in by index.html.erb)
  site.applications = [];
  site.current_user_id = null;
  
  // Displays the virtual application preferences for administrators
  site.prefs = function(app_id) {
    details_url = Routes.applications_path() + "/" + app_id;
    
    template.status_text("Fetching details...");
    
    $.get(details_url, function(data) {
      template.hide_status();
      apprise(data, {'animate': true, 'textOk': 'Dismiss'});
      var scope = $("div#entity_details");
      template.setup_sidebar(scope);
      template.setup_default_text(scope);
    });
  }
  
  // Updates or creates pins to represent the roles it's given. Can be called multiple times for the same app/role
  // dom_only = don't make the AJAX call to actually save the permission. Useful when merely constructing the existing list
  site.register_role = function(entity, role, dom_only) {
    if(dom_only == undefined) { dom_only = false; }
    
    // If the pin doesn't exist, create it.
    if($("div.card[data-application-id=" + role.application_id + "] div.pin[data-entity-id=" + entity.id + "]").length == 0) {
      var el = $( "<div class=\"pin\" data-application-id=\"" + role.application_id + "\" data-entity-id=\"" + entity.id + "\"></div>" );
      var el_html = "<img src=\"/images/remove.png\" style=\"display: none; margin: 1px 0 0 0; padding: 0 7px 0 0; float: right; cursor: pointer;\" onClick=\"site.remove_pin($(this));\" /> <a href=\"#\">" + entity.name + "</a> \
                     <img src=\"/images/help.png\" style=\"display: none; margin: 1px 0 0 5px; padding: 0 7px 0 0; float: right; cursor: pointer;\" id=\"entity_details\" /> \
                     <div class=\"pin-content\"></div>";
    
      $(el).html( el_html );
      $(el).hover(
        function() {
          // hover in
          $(this).children("img").css("display", "block");
        },
        function() {
          // hover out
          $(this).children("img").css("display", "none");
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
    
      $(el).children("img#entity_details").click(function() {
        site.entity_details(entity.id);
      });
    
      $(el).children("a").click(function() {
        $(this).parent().children("div.pin-content").slideToggle('fast');
        return false;
      });
      
      // Change the pin color if this is a group
      if(String(entity.id)[0] == '2') {
        $(el).css("background-image", "url(images/btnb_dark.gif)");
      }
      
      var pin_list = $("div.card[data-application-id=" + role.application_id + "]").children("div.card_content").children("div.pins");
      
      $(pin_list).append(el);
      
      // Remove the placeholder image (if it's still there)
      $(pin_list).find( ".placeholder" ).remove();
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
    if (apprise("This action will remove all permissions from the entity. Continue?",
    {'verify': true, 'textYes': "Remove All Permissions", 'textNo': "Cancel"}, function(confirm_remove) {
      if(confirm_remove) {
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
    }));
  }

  site.entity_details = function (entity_id) {
    var entity_type = entity_id.toString()[0];
    var entity_id = entity_id.toString().substr(1);
    var details_url = null;
    
    if(entity_type == '1') {
      // person
      details_url = Routes.people_path() + "/" + entity_id;
    } else {
      // group
      details_url = Routes.groups_path() + "/" + entity_id;
    }
    
    template.status_text("Fetching details...");
    
    $.get(details_url, function(data) {
      template.hide_status();
      apprise(data, {'animate': true, 'textOk': 'Dismiss'});
      template.setup_sidebar($("div#entity_details"));
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
    
    // Make it draggable
    $(el).draggable({
      appendTo: "body",
      helper: "clone"
    });
    
    // Delete button on hover
    $(el).hover(
      function() {
        // mouse enter
        $(this).children("img").css("display", "block");
      },
      function() {
        // mouse leave
        $(this).children("img").css("display", "none");
      }
    );
    
    if(type == '1') {
      // Person
      $(el).attr("data-pin-type", "person");
      $(el).attr("data-person-id", entity.id);
      $(el).html("<img src=\"/images/help.png\" style=\"margin: 1px 0 0 0; padding: 1px 15px 0 0; float: right; cursor: pointer; display: none;\" onClick=\"javascript:site.entity_details(" + entity.id + ");\" />" + entity.name);
      $("div#people ul.pins").append(el);
    } else if (type == '2') {
      // Group
      $(el).attr("data-pin-type", "group");
      $(el).attr("data-group-id", entity.id);
      $(el).html("<img src=\"/images/remove.png\" style=\"margin: 1px 0 0 0; padding: 1px 14px 0 0; float: right; cursor: pointer; display: none;\" onClick=\"javascript:site.delete_group($(this).parent().data('pin-entity'));\" /> <img src=\"/images/help.png\" style=\"margin: 1px 0 0 0; padding: 1px 7px 0 0; float: right; cursor: pointer; display: none;\" onClick=\"javascript:site.entity_details(" + entity.id + ");\" />" + entity.name);
      $(el).css("background-image", "url(images/btnb_dark.gif)");
      $("div#groups ul.pins li.new").before(el);
    } else {
      // Unknown
      console.log("Cannot add entity to availability list, unknown type.");
    }
  }
} (window.site = window.site || {}, jQuery));
