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
      // Get the app ID for this card based on where they dropped the pin
      var app_id = $(this).parent().parent().attr("data-represents-application");
      
      var el = site.construct_pin(ui.draggable.text(), app_id);
      $(el).appendTo( this );
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
  
  // Updates or creates pins to represent the roles it's given. Can be called multiple times for the same app/role
  site.register_role = function(entity, role) {
    // If the pin doesn't exist, create it.
    if($("div.pin[data-application-id=" + role.application_id + "]").length == 0) {
      var el = $( "<div class=\"pin\" data-application-id=\"" + role.application_id + "\"></div>" );
      var el_html = "<img src=\"/images/cancel.png\" style=\"margin: 1px 0 0 5px; padding: 0 7px 0 0; float: left; cursor: pointer;\" \
                     onClick=\"site.remove_pin($(this));\" /> <a href=\"#\">" + entity.name + "</a> \
                     <img src=\"/images/help.png\" style=\"margin: 1px 0 0 5px; padding: 0 7px 0 0; float: right; cursor: pointer;\" /> \
                     <div class=\"pin-content\"></div>";
    
      $(el).html( el_html );
    
      // Add the permissions list
      for(var i = 0; i < site.applications[role.application_id].roles.length; i++) {
        var r = site.applications[role.application_id].roles[i];
        $(el).children("div.pin-content").append("<span class=\"permission\"><input type=\"checkbox\" data-app-id=\"" + role.application_id + "\" data-role-id=\"" + r.id + "\" /> (<b>" + r.descriptor + "</b>) " + r.description + "</span>");
      }
    
      $(el).trigger('click', function() {
        person_details(ui.draggable.attr("data-person-id"));
      });
    
      $(el).children("a").click(function() {
        $(this).parent().children("div.pin-content").slideToggle('slow');
        return false;
      });
      
      var pin_list = $("div.card[data-represents-application=" + role.application_id + "]").children("div.card_content").children("div.pins");
      
      $(pin_list).append(el);
      
      // Remove the placeholder image (if it's still there)
      $(pin_list).find( ".placeholder" ).remove();
    }
    
    return true;
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
