(function (details_modal, $, undefined) {
  details_modal.EDIT_MODE = 0;
  details_modal.VIEW_MODE = 1;
  
  // Temporarily holds edits made via AJAX saves. Used to update the DOM to match later.
  details_modal.group_edits = [];
  
  // Save whatever's in the modal
  details_modal.save = function() {
    template.status_text("Saving changes...");
    
    // Which modal is this? Person, Group, or Application?
    if($("#person_ou_tokens").length > 0) {
      $("form.edit_person").trigger("submit.rails");
    } else if($("#group_member_tokens").length > 0) {
      details_modal.group_edits['entity_id'] = $("form.edit_group input[name=entity_id]").val();
      details_modal.group_edits['name'] = $("form.edit_group input#group_name").val();
      $("form.edit_group").trigger("submit.rails");
    } else if($("#application_owner_tokens").length > 0) {
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
    // Ensure the save button works
    $(".modal #save").click(function() {
      details_modal.save();
      $(".modal").modal('hide');
      cards.render_cards();
    });
    
    if($("#person_ou_tokens").length > 0) {
      // Person details modal
      $("#person_ou_tokens").tokenInput($("#person_ou_tokens").attr("method") + ".json", {
        crossDomain: false,
        defaultText: "No organizations",
        prePopulate: $("#person_ou_tokens").data("pre"),
        theme: "facebook",
        tokenValue: "uid"
      });

      $("#person_group_tokens").tokenInput($("#person_group_tokens").attr("method") + ".json", {
        crossDomain: false,
        defaultText: "No groups",
        prePopulate: $("#person_group_tokens").data("pre"),
        theme: "facebook",
        tokenValue: "uid"
      });

      $("#person_subordinate_tokens").tokenInput($("#person_subordinate_tokens").attr("method") + ".json", {
        crossDomain: false,
        defaultText: "No subordinates",
        prePopulate: $("#person_subordinate_tokens").data("pre"),
        theme: "facebook",
        tokenValue: "uid"
      });
    
      // Remote forms
      $("form.edit_person").bind('ajax:complete', function(e, o) {
        template.hide_status();
        
        // Update the local-side models and re-render the necessary DOM bits
        var updated_person = $.parseJSON(o.responseText);
        
        cards.populate_sidebar(updated_person.uid, true);
      });
    }
  
    if($("#group_member_tokens").length > 0) {
      // Group details modal
      // Token inputs
      $("#group_member_tokens").tokenInput($("#group_member_tokens").attr("method") + ".json", {
        crossDomain: false,
        prePopulate: $("#group_member_tokens").data("pre"),
        theme: "facebook",
        tokenValue: "uid",
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
        theme: "facebook",
        tokenValue: "uid"
      });
    
      // Remote forms
      $("form.edit_group").bind('ajax:complete', function() {
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
        theme: "facebook",
        tokenValue: "uid"
      });
    
      // Remote forms
      $("form.edit_application").bind('ajax:complete', function(e, o) {
        template.hide_status();
        
        // Update the local-side models and re-render the necessary DOM bits
        var updated_application = $.parseJSON(o.responseText);
        applications.applications[updated_application.id] = updated_application;
        
        cards.render_cards();
      });
    }
  }
} (window.details_modal = window.details_modal || {}, jQuery));
