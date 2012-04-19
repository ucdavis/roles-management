(function (details_modal, $, undefined) {
  details_modal.EDIT_MODE = 0;
  details_modal.VIEW_MODE = 1;
  
  // Temporarily holds edits made via AJAX saves. Used to update the DOM to match later.
  details_modal.person_edits = [];
  details_modal.group_edits = [];
  details_modal.application_edits = [];
  
  details_modal.switch_mode = function(mode) {
    switch(mode) {
      case details_modal.EDIT_MODE:
      // Turn on inputs
      $("div#details_view .sidebar_content input:not(.submit),textarea")
        .css("border", "1px solid #bbb")
        .attr("readonly", false);
      // Turn on token inputs
      $("div#entity_details .token_input").each(function() {
        $(this).tokenInput("toggleDisabled", {disable: false});
      });
      // Turn on dropdowns
      $("div#entity_details select")
        .removeClass("disabled")
        .attr("disabled", false);
      // Turn on any anchor-based controls
      $("div#entity_details a.edit_mode").show();
      // Turn on any 'JS submit' buttons
      $("div#entity_details input.submit").show();
      // Show unchecked boxes
      $("div#entity_details input[type=checkbox]:not(:checked)").show();
      // Enable the other checkboxes
      $("div#entity_details input[type=checkbox]:checked").removeAttr("disabled");
      break;
      case details_modal.VIEW_MODE:
      // Turn off inputs
      $("div#details_view .sidebar_content input,textarea")
        .css("border", "1px solid #fff")
        .attr("readonly", true);
      // Turn off token inputs
      $("div#entity_details .token_input").each(function() {
        $(this).tokenInput("toggleDisabled", {disable: true});
      });
      // Turn off dropdowns
      $("div#entity_details select")
        .addClass("disabled")
        .attr("disabled", true);
      // Turn off any anchor-based controls
      $("div#entity_details a.edit_mode").hide();
      // Turn off any 'JS submit' buttons
      $("div#entity_details input.submit").hide();
      // Hide unchecked boxes
      $("div#entity_details input[type=checkbox]:not(:checked)").hide();
      // Disable remaining checkboxes
      $("div#entity_details input[type=checkbox]:checked").attr("disabled", true);
      break;
      default: break;
    }
  }
  
  // Save whatever's in the modal
  details_modal.save = function() {
    template.status_text("Saving changes...");
    
    // Which modal is this? Person, Group, or Application?
    if($("#person_ou_tokens").length > 0) {
      details_modal.person_edits['entity_id'] = $("form.edit_person input[name=entity_id]").val();
      details_modal.person_edits['name'] = $("form.edit_person input#person_first").val() + " " + $("form.edit_person input#person_last").val();
      $("form.edit_person").trigger("submit.rails");
    } else if($("#group_member_tokens").length > 0) {
      details_modal.group_edits['entity_id'] = $("form.edit_group input[name=entity_id]").val();
      details_modal.group_edits['name'] = $("form.edit_group input#group_name").val();
      $("form.edit_group").trigger("submit.rails");
    } else if($("#application_ou_tokens").length > 0) {
      details_modal.application_edits['app_id'] = $("form.edit_application input[name=app_id]").val();
      details_modal.application_edits['display_name'] = $("form.edit_application input#application_display_name").val();
      details_modal.application_edits['description'] = $("form.edit_application input#application_description").val();
      $("form.edit_application").trigger("submit.rails");
    }
  }
  
  // Called whenever a group rule input is focused.
  // We need to switch modes depending on the state of the
  // corresponding dropdown in order to set up the look ahead field.
  details_modal.switch_group_rules_autocomplete = function() {
    // Determine the value of the row's dropdown
    var mode = $(this).parent().parent().find("td:first select").val();
    
    // Change the callback accordingly
    switch(mode) {
      case 'loginid':
      $(this).autocomplete({
      			source: function( request, response ) {
      				$.ajax({
      					url: Routes.api_loginid_path() + ".json",
      					data: {
      						q: request.term
      					},
      					success: function( data, status, xmlhttp ) {
      						response( $.map( data, function( item ) {
      							return {
      								label: item,
      								value: item
      							}
      						}));
      					}
      				});
      			},
      			minLength: 2,
      			open: function() {
      				$( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
      			},
      			close: function() {
      				$( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
      			}
      		});
        break;
      case 'title':
      $(this).autocomplete({
      			source: function( request, response ) {
      				$.ajax({
      					url: Routes.api_titles_path() + ".json",
      					data: {
      						q: request.term
      					},
      					success: function( data, status, xmlhttp ) {
      						response( $.map( data, function( item ) {
      							return {
      								label: item.name,
      								value: item.name
      							}
      						}));
      					}
      				});
      			},
      			minLength: 2,
      			open: function() {
      				$( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
      			},
      			close: function() {
      				$( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
      			}
      		});
        break;
      case 'major':
        
        break;
      case 'affiliation':
      $(this).autocomplete({
      			source: function( request, response ) {
      				$.ajax({
      					url: Routes.api_affiliation_path() + ".json",
      					data: {
      						q: request.term
      					},
      					success: function( data, status, xmlhttp ) {
      						response( $.map( data, function( item ) {
      							return {
      								label: item,
      								value: item
      							}
      						}));
      					}
      				});
      			},
      			minLength: 2,
      			open: function() {
      				$( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
      			},
      			close: function() {
      				$( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
      			}
      		});
        break;
      case 'classification':
      $(this).autocomplete({
      			source: function( request, response ) {
      				$.ajax({
      					url: Routes.api_classifications_path() + ".json",
      					data: {
      						q: request.term
      					},
      					success: function( data, status, xmlhttp ) {
      						response( $.map( data, function( item ) {
      							return {
      								label: item.name,
      								value: item.name
      							}
      						}));
      					}
      				});
      			},
      			minLength: 2,
      			open: function() {
      				$( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
      			},
      			close: function() {
      				$( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
      			}
      		});
        break;
      case 'ou':
        
        break;
      default:
        console.log("Unimplemented group rule dropdown value: " + mode);
        break;
    }
  }
  
  details_modal.init = function() {
    if($("#person_ou_tokens").length > 0) {
      // Person details modal
      $("#person_ou_tokens").tokenInput($("#person_ou_tokens").attr("method") + ".json", {
        crossDomain: false,
        defaultText: "No organizations",
        prePopulate: $("#person_ou_tokens").data("pre"),
        theme: "facebook"
      });

      $("#person_group_tokens").tokenInput($("#person_group_tokens").attr("method") + ".json", {
        crossDomain: false,
        defaultText: "No groups",
        prePopulate: $("#person_group_tokens").data("pre"),
        theme: "facebook"
      });

      $("#person_subordinate_tokens").tokenInput($("#person_subordinate_tokens").attr("method") + ".json", {
        crossDomain: false,
        defaultText: "No subordinates",
        prePopulate: $("#person_subordinate_tokens").data("pre"),
        theme: "facebook"
      });
    
      // Remote forms
      $("form.edit_person").bind('ajax:complete', function(){
        template.hide_status();
      
        // Update any pins
        $("div.pin[data-entity-id=" + details_modal.person_edits['entity_id'] + "] a").each(function() {
          $(this).html(details_modal.person_edits['name']);
        });
        details_modal.person_edits = [];
      });
    }
  
    if($("#group_member_tokens").length > 0) {
      // Group details modal
      // Token inputs
      $("#group_member_tokens").tokenInput($("#group_member_tokens").attr("method") + ".json", {
        crossDomain: false,
        prePopulate: $("#group_member_tokens").data("pre"),
        theme: "facebook",
        defaultText: "No members",
        onAdd: function (item) {
          console.log("Added " + item);
        },
        onDelete: function (item) {
          console.log("Deleted " + item);
        }
      });

      $("#group_owner_tokens").tokenInput($("#group_owner_tokens").attr("method") + ".json", {
        crossDomain: false,
        defaultText: "No owners",
        prePopulate: $("#group_owner_tokens").data("pre"),
        theme: "facebook"
      });
    
      // Remote forms
      $("form.edit_group").bind('ajax:complete', function(){
        template.hide_status();
      
        // Update any pins
        $("div.pin[data-entity-id=" + details_modal.group_edits['entity_id'] + "] a").each(function() {
          $(this).html(details_modal.group_edits['name']);
        });
        details_modal.group_edits = [];
      });
    
      // Auto-complete for group rules
      // Set up auto-complete for existing dropdown default settings
      $("form.edit_group table tbody tr.fields td:nth-child(3) input").each(function(i, el) {
        $(this).focus(details_modal.switch_group_rules_autocomplete);
        details_modal.switch_group_rules_autocomplete(0);
      });
      // Set up auto-complete for dropdowns which may not exist yet
      $("form.edit_group table tbody").on("focus", "tr.fields td:nth-child(3) input", function(event) {
        $(this).focus(details_modal.switch_group_rules_autocomplete);
      });
    }
  
    if($("#application_owner_tokens").length > 0) {
      // Application details modal
      $("#application_owner_tokens").tokenInput($("#application_owner_tokens").attr("method") + ".json", {
        crossDomain: false,
        defaultText: "",
        prePopulate: $("#application_owner_tokens").data("pre"),
        theme: "facebook"
      });
    
      // Remote forms
      $("form.edit_application").bind('ajax:complete', function(){
        template.hide_status();
      
        // Update any pins
        $("div.card[data-application-id=" + details_modal.application_edits['app_id'] + "] div.card_head h2").each(function() {
          $(this).html(details_modal.application_edits['display_name']);
        });
        $("div.card[data-application-id=" + details_modal.application_edits['app_id'] + "] div.card_content p").each(function() {
          $(this).html("<i>“" + details_modal.application_edits['description'] + "”</i>");
        });
      
        details_modal.application_edits = [];
      });
    }
  
    $("button#edit").click(function() {
      // Button toggles edit mode
      if($(this).html() == "Edit") {
        // Turning editing on
        $(this).html("Done").css("color", "#db6c67");
        details_modal.switch_mode(details_modal.EDIT_MODE);
      } else {
        // Turning editing off
        $(this).html("Edit").css("color", "#000");
        // And save the form, of course
        details_modal.save();
        // Switch back to 'view' _last_ - it disables elements that causes form elements not be to submitted
        details_modal.switch_mode(details_modal.VIEW_MODE);
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
  
    // Assume view mode
    //details_modal.switch_mode(details_modal.VIEW_MODE);
  }
} (window.details_modal = window.details_modal || {}, jQuery));
