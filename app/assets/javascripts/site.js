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
      // Construct the dropped element
      $( this ).find( ".placeholder" ).remove();
      
      var el = $( "<div></div>" ).addClass("pin").appendTo( this );
      $(el).html( "<img src=\"/images/cancel.png\" style=\"margin: 1px 0 0 5px; padding: 0 7px 0 0; float: left; cursor: pointer;\" onClick=\"remove_pin($(this));\" /> <a href=\"#\">" + ui.draggable.text() + "</a><img src=\"/images/help.png\" style=\"margin: 1px 0 0 5px; padding: 0 7px 0 0; float: right; cursor: pointer;\" onClick=\"person_details('" + ui.draggable.attr("data-person-id")  + "');\" /><div class=\"pin-content\"><span class=\"permission\"><input type=\"checkbox\" /> (<b>Access</b>) Allows the user to access this application</span></div>");
      
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

// Remove a dropped pin from the app list
function remove_pin(el) {
  var ol = $(el).parent().parent();
  
  $(el).parent().remove();
  if(ol.children().length == 0) {
    // Emptied out the last pin. Re-insert the default placerholder text so the 'ol' doesn't disappear entirely
    ol.append("<div class=\"placeholder\"><img src=\"/assets/add.png\" alt=\"\" /></div>");
  }
}

function person_details(person_id) {
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
