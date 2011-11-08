// Not a site-wide JS file - for use in the 'Site' controller

// Set up the drag-and-drop
$(function() {
  $( "ul.pins li" ).draggable({
  	appendTo: "body",
  	helper: "clone"
  });
  $( "ol.pins" ).droppable({
  	activeClass: "ui-state-default",
  	hoverClass: "ui-state-hover",
  	accept: ":not(.ui-sortable-helper)",
  	drop: function( event, ui ) {
  	  // Construct the dropped element
  		$( this ).find( ".placeholder" ).remove();
  		var el = $( "<li></li>" ).addClass("pin").appendTo( this );
  		$(el).html( "<img src=\"/images/cancel.png\" style=\"margin: 1px 0 0 0; padding: 0 7px 0 0; float: left; cursor: pointer;\" onClick=\"remove_pin($(this));\" />" + ui.draggable.text() + "<select id=\"s1\" multiple=\"multiple\"><option>Low</option><option>Medium</option></select>");
  		$("select#s1").dropdownchecklist();
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
    ol.append("<li class=\"placeholder\">Drag people or groups here to assign permissions</li>");
  }
}
