// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
  $("#group_people_tokens").tokenInput("/people.json", {
    crossDomain: false,
    prePopulate: $("#group_people_tokens").data("pre"),
    theme: "facebook"
  });

	$("#role_people_tokens").tokenInput("/people.json", {
    crossDomain: false,
    prePopulate: $("#role_people_tokens").data("pre"),
    theme: "facebook"
  });
});
