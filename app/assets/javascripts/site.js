// Not a site-wide JS file - for use in the 'Site' controller

$(function() {
  // Set up the drag-and-drop
  $( "ul.pins li" ).draggable({
    appendTo: "body",
    helper: "clone"
  });
  $( "div.pins" ).droppable({
    activeClass: "ui-state-default",
    hoverClass: "ui-state-hover",
    accept: ":not(.ui-sortable-helper)",
    drop: function( event, ui ) {
      // Drop the element
      $( this ).find( ".placeholder" ).remove();
      
      // Get the app ID for this card based on where they dropped the pin
      var app_id = $(this).parent().parent().attr("data-represents-application");
      
      var el = site.construct_pin(ui.draggable.text(), app_id);
      $(el).trigger('click', function() {
        person_details(ui.draggable.attr("data-person-id"));
      });
      $(el).appendTo( this );
      
      $(el).children("a").click(function() {
        $(this).parent().children("div.pin-content").slideToggle('slow');
        return false;
      });
    }
  }).sortable({
    items: "li:not(.placeholder)",
    sort: function() {
      // gets added unintentionally by droppable interacting with sortable
      // using connectWithSortable fixes this, but doesn't allow you to customize active/hoverClass options
      $( this ).removeClass( "ui-state-default" );
    }
  });
});

(function (site, $, undefined) {
  // Application and role relationship (filled in by index.html.erb)
  site.applications = [];
  
  site.construct_pin = function(label, app_id) {
    var el = $( "<div></div>" ).addClass("pin");
    var el_html = "<img src=\"/images/cancel.png\" style=\"margin: 1px 0 0 5px; padding: 0 7px 0 0; float: left; cursor: pointer;\" \
                   onClick=\"site.remove_pin($(this));\" /> <a href=\"#\">" + label + "</a> \
                   <img src=\"/images/help.png\" style=\"margin: 1px 0 0 5px; padding: 0 7px 0 0; float: right; cursor: pointer;\" /> \
                   <div class=\"pin-content\"></div>";
    
    $(el).html( el_html );
    
    // Add the necessary permissions
    for(var role in site.applications[app_id].roles) {
      $(el).children("div.pin-content").append("<span class=\"permission\"><input type=\"checkbox\" data-app-id=\"" + app_id + "\" data-role-id=\"" + role.id + "\" /> (<b>" + role.token + "</b>) Allows the user to access this application</span>");
    }
    
    return el;
  }
  
  // Remove a dropped pin from the app list
  site.remove_pin = function (el) {
    var ol = $(el).parent().parent();
  
    $(el).parent().remove();
    if(ol.children().length == 0) {
      // Emptied out the last pin. Re-insert the default placerholder text so the 'ol' doesn't disappear entirely
      ol.append("<div class=\"placeholder\"><img src=\"/assets/add.png\" alt=\"\" /></div>");
    }
  }

  // Used to set up initial page view (existing permissions)
  site.add_pin = function (role, entity) {
  	console.log(role);
  	console.log(entity);
	
  	// Fetch the app "card" element
  	var app_card = $("div.card[data-represents-application=" + role.application_id + "]");
	
  	// Determine pin type (person or group), based on leading digit (see UID explanation in README)
  	if(String(entity.id)[0] == 1) {
  		// entity is a person
		
  	} else {
  		// entity is a group
		
  	}
  }

  site.person_details = function (person_id) {
    $.fancybox({
  		'orig'			: $(this),
  		'href'      : Routes.people_path() + "/" + person_id,
  		'padding'		: 0,
  		'transitionIn'	: 'elastic',
  		'transitionOut'	: 'elastic',
  		'ajax' : {
      		    type	: "GET",
      		    data	: ''
      		}
    });
  }
} (window.site = window.site || {}, jQuery));
