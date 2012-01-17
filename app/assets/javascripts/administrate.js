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
          console.log(event);
          console.log(ui);
        }
      });
  });
});
