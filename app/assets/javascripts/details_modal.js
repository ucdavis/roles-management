(function (details_modal, $, undefined) {
  
} (window.details_modal = window.details_modal || {}, jQuery));

$(document).ready(function() {
  $("#person_ou_tokens").tokenInput($("#person_ou_tokens").attr("method") + ".json", {
    crossDomain: false,
    prePopulate: $("#person_ou_tokens").data("pre"),
    theme: "facebook"
  });

  $("#person_group_tokens").tokenInput($("#person_group_tokens").attr("method") + ".json", {
    crossDomain: false,
    prePopulate: $("#person_group_tokens").data("pre"),
    theme: "facebook"
  });

  $("#person_subordinate_tokens").tokenInput($("#person_subordinate_tokens").attr("method") + ".json", {
    crossDomain: false,
    prePopulate: $("#person_subordinate_tokens").data("pre"),
    theme: "facebook"
  });
  
  $("button#edit").click(function() {
    // Button toggles edit mode
    if($(this).html() == "Edit") {
      // turning editing on
      $(this).html("Done").css("color", "#db6c67");
      
    } else {
      // turning editing off
      $(this).html("Edit").css("color", "#000");
      
    }
  }).hover(
    // fix jQuery's CSS hover mistake. TODO: fix this using css / apprise patching instead?
    function() {
      $(this).css("color", "#db6c67");
    },
    function() {
      if($(this).html() == "Edit") {
        $(this).css("color", "#000");
      } else {
        $(this).css("color", "#1eaaeb");
      }
    }
  );
});
