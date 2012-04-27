// Functions to interact on any page utilizing 'cards' (Manage & Template pages, namely)

$(function() {
  cards.initialize();
});

(function (cards, $, undefined) {
  cards.cards = null; // will be filled in using the view
  cards.selected_card = null;
  cards.selected_role = null;
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
      cards.entity_details('4' + $(this).parent().parent().data("application-id"));
    });
    
    // Allow clicking on blank space to deselect a card
    $("div#left").on("click", function(event) {
      event.stopPropagation();
      
      cards.selected_card = null;
      cards.selected_role = null;
      
      // Unhighlight other cards
      $("div.card").css("box-shadow", "").css("border", "");
      // Unhighlight any role pins
      $("div.pin").css("box-shadow", "").css("border", "");
      
      // Depopulate the sidebar
      cards.populate_sidebar("");
    });
    // Allow clicking on cards to trigger their adherents
    $("div#left").on("click", "div#cards div.card", function(event) {
      event.stopPropagation();
      
      // Unhighlight other cards
      $("div.card").css("box-shadow", "").css("border", "");
      // Unhighlight any role pins
      $("div.pin").css("box-shadow", "").css("border", "");
    
      // Highlight this card
      $(this).css("box-shadow", "#08C 0 0 10px").css("border", "1px solid #08C");
    
      // Re-sort the sidebar to show the associated people and groups
      cards.populate_sidebar($(this).data("uids"));
    
      // Record it
      cards.selected_card = $(this);
      cards.selected_role = null;
      
      // Clear out the sidebar
      $("#search_entities").attr("data-value", null).val("");
    });
    // Allow clicking on card pins to trigger their role-specific adherents
    $("div#left").on("click", "div#cards div.card div.pin", function(event) {
      event.stopPropagation();
      
      // Unhighlight other cards
      $("div.card").css("box-shadow", "").css("border", "");
      // Unhighlight any role pins
      $("div.pin").css("box-shadow", "").css("border", "");
      
      // Highlight this pin
      $(this).css("box-shadow", "#08C 0 0 5px").css("border", "1px solid #08C");
    
      // Record it
      cards.selected_card = $(this).parent().parent().parent();
      cards.selected_role = $(this).data("role-id");
      
      // Re-sort the sidebar to show the associated people and groups
      cards.populate_sidebar($(this).data("uids"));
      
      // Clear out the sidebar
      $("#search_entities").attr("data-value", null).val("");
    });    
    
    // Render the application cards
    cards.template = $("#tmpl-card").html();
    _.each(applications.applications, function(app) {
      var compiledTmpl = _.template(cards.template, { app: app });
      $("div#cards").append(compiledTmpl);
    });
    
    // Delete/info button(s) appear on hover for the sidebar pins
    $("div#right").on("mouseenter mouseleave", "ul.pins li", function(e) {
      if(e.type == "mouseenter") {
        if($(this).data("uid").toString()[0] == "2") {
          // only show a delete item if this is a group (you cannot delete users through this interface)
          $(this).children("i.icon-remove").css("display", "block");
        }
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

    // Enable the delete button for sidebar pins (only works on groups)
    $("div#right").on("click", "ul.pins>li>i.icon-remove", function() {
      cards.delete_group($(this).parent().data("uid"));
    });
    
    // Allow searching on the sidebar
    $("#search_entities").typeahead({
      source: function(query, maxResults, callback) {
        // Populate the search drop down
        if(query.length >= 3) {
          $.ajax({ url: Routes.api_search_path(), data: { q: query }, type: 'GET' }).always(function(data) {
            entities = [];
            _.each(data, function(entity) {
              entities.push({id: entity.uid, label: entity.name });
            });
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
      if(cards.selected_card && uid) {
        var assignment = {};
        
        assignment.entity_id = uid;
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
        
        template.status_text("Saving...");
        
        $.ajax({ url: Routes.roles_assign_path(), data: {assignment: assignment}, type: 'POST'}).always(function() {
          template.hide_status();
          
          // Update the sidebar list
          console.log("TODO: Update the sidebar list now that a new assignment has been made.");
        });
      }
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
  cards.populate_sidebar = function(uids) {
    // Clear out the existing list (fade out li elements and destroy since they are clones)
    $("#entity_list>li").remove();
    
    if(typeof uids == "undefined") return;
    
    // Generate a list of matching li elements
    $.ajax({ url: Routes.api_resolve_path(), data: { uids: uids }, type: 'GET'}).always(function(entities) {
      pin_template = $("#tmpl-pin").html();
      _.each(entities, function(entity) {
        var compiledTmpl = _.template(pin_template, { entity: entity });
        $("#entity_list").append(compiledTmpl);
      });
    });
  }
  
  cards.entity_details = function(uid) {
    var entity_type = uid.toString()[0];
    var id = uid.toString().substr(1);
    var details_url = null;
    
    if(entity_type == '1') {
      // person
      details_url = Routes.people_path() + "/" + id;
    } else if(entity_type == '2') {
      // group
      details_url = Routes.groups_path() + "/" + id;
    } else {
      // application
      details_url = Routes.applications_path() + "/" + id;
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
  
  cards.delete_group = function(uid) {
    var id = uid.toString().substr(1);
    
    if (apprise("Really delete this group?",
    {'verify': true, 'textYes': "Delete Group", 'textNo': "Cancel"}, function(confirm_delete) {
      if(confirm_delete) {
        template.status_text("Deleting group...");
    
        // Delete the group
        $.ajax({ url: Routes.group_path(id), type: 'DELETE', complete: function(data, status) {
          template.hide_status();
          // Remove the pin (Note: status = 'parseerror' because jQuery doesn't like blank 200 OK ajax responses. Ignore this.)
          var el = $("ul.pins li[data-uid=" + uid + "]");
          el.fadeOut('fast', function() { $(el).remove(); });
        }});
      }
    }));
  }  
} (window.cards = window.cards || {}, jQuery));
