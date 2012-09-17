// Functions to interact on any page utilizing 'cards' (Manage & Template pages, namely)

(function (cards, $, undefined) {
  cards.selected_card = null;
  cards.selected_role = null;
  cards.template = null;
  cards.manageable_uids = null;

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
      cards.entity_details('4' + $(this).parent().parent().data("application-id"));
    });

    // Allow clicking on blank space to deselect a card
    $("div#left").on("click", function(e) {
      e.preventDefault();

      cards.selected_card = null;
      cards.selected_role = null;

      // Unhighlight other cards
      $("div.card").css("box-shadow", "").css("border", "");
      // Unhighlight any role pins
      $("div.pin").css("box-shadow", "").css("border", "");

      // Restore default sidebar contents
      cards.populate_sidebar(_.map(cards.manageable_uids, function(e) { return e.uid }).join());
    });

    // Allow clicking on cards to trigger their adherents
    $("div#left").on("click", "div#cards div.card", function(e) {
      e.stopPropagation();

      // Unhighlight other cards
      $("div.card").css("box-shadow", "").css("border", "");
      // Unhighlight any role pins
      $("div.pin").css("box-shadow", "").css("border", "");

      // Highlight this card
      $(this).css("box-shadow", "#08C 0 0 10px").css("border", "1px solid #08C");

      // Re-sort the sidebar to show the associated people and groups (avoid populate_sidebar if they've simply clicked the same area twice)
      if(!($(cards.selected_card).data("application-id") == $(this).data("application-id") && cards.selected_role == null)) {
        cards.populate_sidebar($(this).data("uids"));
      }

      // Record it
      cards.selected_card = $(this);
      cards.selected_role = null;

      // Clear out the sidebar
      $("#search_entities").attr("data-value", null).val("");
    });

    // Allow clicking on card pins to trigger their role-specific adherents
    $("div#left").on("click", "div#cards div.card div.pin", function(e) {
      e.stopPropagation();

      // Unhighlight other cards
      $("div.card").css("box-shadow", "").css("border", "");
      // Unhighlight any role pins
      $("div.pin").css("box-shadow", "").css("border", "");

      // Highlight this pin
      $(this).css("box-shadow", "#08C 0 0 5px").css("border", "1px solid #08C");

      // Re-sort the sidebar to show the associated people and groups
      if(!($(cards.selected_card).data("application-id") == $(this).parent().parent().parent().data("application-id") && cards.selected_role == $(this).data("role-id"))) {
        cards.populate_sidebar($(this).data("uids"));
      }

      // Record it
      cards.selected_card = $(this).parent().parent().parent();
      cards.selected_role = $(this).data("role-id");

      // Clear out the sidebar
      $("#search_entities").attr("data-value", null).val("");
    });

    // Render the application cards
    cards.render_cards();

    // Delete/info button(s) appear on hover for the sidebar pins
    $("div#right").on("mouseenter mouseleave", "ul.pins li", function(e) {
      if(e.type == "mouseenter") {
        $(this).children("i.icon-remove").css("display", "block");
        $(this).children("i.icon-search").css("display", "block");
      } else {
        // hover out
        $(this).children("i").css("display", "none");
      }
    });

    // Enable the details button for sidebar pins
    $("div#right").on("click", "ul.pins>li>i.icon-search", function() {
      cards.entity_details($(this).parent().data("uid"));
    });

    // Enable the delete/disassociate button for sidebar pins
    $("div#right").on("click", "ul.pins>li>i.icon-remove", function() {
      cards.disassociate($(this).parent().data("uid"));
    });

    // Allow searching on the sidebar
    $("#search_entities").typeahead({
      source: function(query, maxResults, callback) {
        // Populate the search drop down
        if(query.length >= 3) {
          $.ajax({ url: Routes.api_search_path(), data: { q: query }, type: 'GET' }).always(function(data) {
            entities = [];
            var exact_match_found = false;
            _.each(data, function(entity) {
              if(query.toLowerCase() == entity.name.toLowerCase()) exact_match_found = true;
              entities.push({id: entity.uid, label: entity.name });
            });

            if(exact_match_found == false) {
              // Add the option to create a new one with this query
              entities.push({id: -1, label: "Add Person " + query});
              entities.push({id: -2, label: "Create Group " + query});
            }

            callback(entities);
          });
        }
      },
      valueField: 'id',
      labelField: 'label'
    }).keyup(function() {
      // need to ensure the ID field is cleared on typing
      $(this).attr('data-value', null);
    }).change(function() {
      var uid = $(this).attr('data-value');

      // They have selected a person. What to do depends on the mode of the UI
      // Is there a card highlighted? In which case, assign this person
      if(cards.selected_card && (uid >= 0)) {
        template.status_text("Saving...");

        cards.assign_role(uid, undefined, function() {
          template.hide_status();
        });

        // Clear the search field
        $("#search_entities").attr("data-value", null).val("");
      } else if(uid < 0) {
        // They want to create a new group or person
        if(uid == -1) {
          // New Person
          template.status_text("Creating person...");
          var person = {};
          person.name = $(this).val().slice(11); // cut off the "Create Person " at the beginning
          person.loginid = "SET_ME";
          $.ajax({ url: Routes.people_path() + ".json", data: {person: person}, type: 'POST'}).always(
            function(data) {
              template.hide_status();
              // Bring up the details window
              cards.entity_details(data.uid);
              // Clear out the input
              $("#search_entities").val("");
              // Assign this newly created person
              cards.assign_role(data.uid, undefined, undefined);
            }
          );
        } else {
          // New Group
          template.status_text("Creating group...");
          var group = {};
          group.name = $(this).val().slice(13); // cut off the "Create Group " at the beginning
          group.owner_ids = ['1' + application.current_user_id];
          $.ajax({ url: Routes.groups_path() + ".json", data: {group: group}, type: 'POST'}).always(
            function(data) {
              template.hide_status();
              // Bring up the details window
              cards.entity_details(data.uid);
              // Clear out the input
              $("#search_entities").val("");
              // Assign this newly created group
              cards.assign_role(data.uid, undefined, undefined);
            }
          );
        }
      }
    });

    // Allow clicking on the right sidebar pins to bring up associated applications
    $("ul.pins").on("click", "li", function(e) {
      $this = $(this);

      // Unhighlight all pins
      $("ul.pins li").css("box-shadow", "none").css("border", "none");
      // Unhighlight all applications
      cards.selected_card = null;
      cards.selected_role = null;

      // Unhighlight other cards
      $("div.card").css("box-shadow", "").css("border", "");
      // Unhighlight any role pins
      $("div.pin").css("box-shadow", "").css("border", "");

      // Highlight this pin
      $this.css("box-shadow", "#08C 0 0 2px").css("border", "1px solid #08C");
    });

    // Default sidebar contents
    cards.populate_sidebar(_.map(cards.manageable_uids, function(e) { return e.uid }).join());
  }

  // Saves an assignment. If role_id is not provided, it will be guessed from the state of the UI
  // on_complete is an optional callback. It will be called when the role is successfully saved
  cards.assign_role = function(uid, role_id, on_complete) {
    var assignment = {};

    assignment.uid = uid;
    if(role_id !== undefined) {
      assignment.role_id = role_id;
    } else {
      // role_id was not provided. Guess what it is from the interface

      if(cards.selected_role) {
        // A specific role is selected
        assignment.role_id = cards.selected_role;
      } else {
        // No specific role is selected - give them the default

        assignment.role_id = _.first(_.filter(applications.applications[$(cards.selected_card).data("application-id")].roles, function(role) {
          if(role.token == "access") {
            return true;
          } else {
            return false;
          }
        })).id;
      }
    }

    // Save the assignment
    $.ajax({ url: Routes.roles_assign_path(), data: {assignment: assignment}, type: 'POST'}).always(function() {
      // Update the sidebar list
      if(cards.selected_role) {
        // specific role updated
        var uids_arr = $("div.pin[data-role-id=" + cards.selected_role + "]").data("uids").split(",");
        uids_arr.push(uid);
        $("div.pin[data-role-id=" + cards.selected_role + "]").data("uids", uids_arr.join(","));
        cards.populate_sidebar(uids_arr.join(","));
        // also update the general role
        uids_arr = $(cards.selected_card).data("uids").split(",");
        uids_arr.push(uid);
        $(cards.selected_card).data("uids", uids_arr.join(","));
      } else {
        // general access role updated
        var uids_arr = $(cards.selected_card).data("uids").toString().split(",");
        uids_arr.push(uid);
        $(cards.selected_card).data("uids", uids_arr.join(","));
        cards.populate_sidebar(uids_arr.join(","));
      }

      if(on_complete !== undefined) on_complete();
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

  cards.render_cards = function() {
    var collection = null;
    var $left = $("div#cards-left");
    var $right = $("div#cards-right");
    var $current = $left;
    var highlighted_application_id = null;

    if(typeof applications === "undefined") {
      // template mode
      collection = templates.templates;
    } else {
      // application mode
      collection = applications.applications;
      // preserve highlighted application card, if any
      if(cards.selected_card) highlighted_application_id = $(cards.selected_card).data("application-id");
    }

    var count = 0; _.map(collection, function(x) { if(x) { count++; } });

    $left.empty();
    $right.empty();
    cards.template = $("#tmpl-card").html();

    var i = 0;
    _.each(collection, function(item) {
      if(item != undefined) { // items we set to defined when deleting an application still appear in _.each for some reason ...
        if(i >= count / 2) $current = $right;
        var compiledTmpl = _.template(cards.template, { item: item });
        //$(compiledTmpl).filter("i#entity_details").tooltip({placement: 'bottom', title: 'something'});
        //console.log($(compiledTmpl).filter("i"));
        $current.append(compiledTmpl);
        if(highlighted_application_id) {
          if(item.id == highlighted_application_id) $("div.card[data-application-id=" + item.id + "]").css("box-shadow", "#08C 0 0 10px").css("border", "1px solid #08C");
        }
        i++;
      }
    });
  }

  // Graphically sorts the right-hand availability list based on terms in 'str'
  cards.populate_sidebar = function(uids, partial) {
    if(typeof(partial) == "undefined") {
      partial = false;
    }

    if(partial == false) {
      // Clear out the existing list (fade out li elements and destroy since they are clones)
      // We do it backwards since we're altering CSS positioning
      $($("#entity_list>li").get().reverse()).each(function(i, el) {
        // Switch the positioning to absolute so the list may fade out while another fades in without affecting positioning (overlay each other)
        var offset = $(el).offset();
        $(el).css("top", offset.top - parseInt($(el).css("margin-top")));
        $(el).css("left", offset.left - parseInt($(el).css("margin-left")));
        $(el).css("width", $(el).width());
        $(el).css("position", "absolute");
      });
      $("#entity_list>li").fadeOut(500, function() {
        $(this).remove();
      });
    }

    if(typeof uids == "undefined") return;

    // Generate a list of matching li elements
    $.ajax({ url: Routes.api_resolve_path(), data: { uids: uids }, type: 'GET'}).always(function(entities) {
      pin_template = $("#tmpl-pin").html();
      _.each(entities, function(entity) {
        var compiledTmpl = _.template(pin_template, { entity: entity });
        existing_pin = $("#entity_list").find("li[data-uid=" + entity.uid + "]").first();
        if(existing_pin.length) {
          // replace the existing pin
          $(compiledTmpl).insertBefore(existing_pin);
          $(existing_pin).remove();
        } else {
          // pin doesn't already exist, just add it
          $("#entity_list").append(compiledTmpl);
        }
      });
    });
  }

  // Used to remove specific UIDs from the sidebar (e.g. when a group is deleted)
  cards.depopulate_sidebar = function(uids) {
    _.each(uids, function(uid) {
      $("#entity_list>li[data-uid=" + uid + "]").remove();
    });
  }

  cards.entity_details = function(uid) {
    var entity_type = uid.toString()[0];
    var id = uid.toString().substr(1);
    var show_url = null;

    if(entity_type == '1') {
      // person
      show_url = Routes.people_path() + "/" + id;
    } else if(entity_type == '2') {
      // group
      show_url = Routes.groups_path() + "/" + id;
    } else {
      // application
      show_url = Routes.applications_path() + "/" + id;
    }

    template.status_text("Fetching details...");

    $.get(show_url, function(response) {
      template.hide_status();
      $("#modal_container").empty();
      $("#modal_container").append(response);
      $("#details_modal").modal();
      details_modal.init();
    });
  }

  cards.disassociate = function(uid) {
    var id = uid.toString().substr(1);
    var role_id = null;
    var $selected_role = null;

    // Determine the role ID
    if(cards.selected_role == null) {
      // No specific role selected. Determine ID of implied 'access' role
      result = _.find(applications.applications[$(cards.selected_card).data("application-id")].roles, function(item) {
        if(item.token == "access")
          return true;
        else
          return false;
      });
      role_id = result.id;
      $selected_role = $(cards.selected_card);
    } else {
      // Specific role
      role_id = cards.selected_role;
      $selected_role = $("div.card div.pin[data-role-id=" + cards.selected_role + "]");
    }

    template.status_text("Removing...");

    // Disassociate the group
    $.ajax({ url: Routes.roles_unassign_path(), data: { assignment: { uid: uid, role_id: role_id } }, type: 'DELETE', complete: function(data, status) {
      template.hide_status();
      cards.depopulate_sidebar([uid]);

      // Remove group from internal application list
      var app = applications.selected_application();
      app.uids = _.filter(app.uids, function(a_uid) { return a_uid != uid; });
      // Also remove group from HTML data attributes (bad typing issues here, need to adopt a JS MVC framework badly in a future revision)
      if($selected_role.data("uids").toString().indexOf(",") == -1) {
        // only one UID in the list
        if($selected_role.data("uids") == uid) $selected_role.data("uids", "");
      } else {
        $selected_role.data("uids", _.filter($selected_role.data("uids").split(","), function(a_uid) { return a_uid != uid; }).join(","));
      }
    }});
  }
} (window.cards = window.cards || {}, jQuery));
