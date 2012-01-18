$(function() {
  $( "#accordion_0" ).accordion({
    autoHeight: false,
    active: false,
  	navigation: true,
    collapsible: true
  });
  $( "div#accordion_1" ).each(function(i) {
    $(this).accordion({
        autoHeight: false,
        active: false,
      	navigation: true,
        collapsible: true
      });
  });
  $( "div#accordion_2" ).each(function(i) {
    $(this).accordion({
        autoHeight: false,
        active: false,
      	navigation: true,
        collapsible: true,
        changestart: function(event, ui) {
            var entity_id = ui.newHeader.next().attr("data-entity-id");
            var details_url = Routes.people_path() + "/" + entity_id;
            
            $.get(details_url, function(data) {
              $(ui.newContent).html(data);
            });
        }
      });
  });
});
