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
  		$( this ).find( ".placeholder" ).remove();
  		$( "<li></li>" ).html( "<img src=\"/images/cancel.png\" style=\"margin: 1px 0 0 0; padding: 0 7px 0 0; float: left; cursor: pointer;\" onClick=\"$(this).parent().remove();\" />" + ui.draggable.text() ).addClass("pin").appendTo( this );
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
