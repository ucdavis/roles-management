$(function() {
  $( "#accordion_0" ).accordion({
    autoHeight: false,
  	navigation: true
  });
  $( "div#accordion_1" ).each(function(i) {
    $(this).accordion({
        autoHeight: false,
      	navigation: true
      });
  });
  $( "div#accordion_2" ).each(function(i) {
    $(this).accordion({
        autoHeight: false,
      	navigation: true
      });
  });
  

});
