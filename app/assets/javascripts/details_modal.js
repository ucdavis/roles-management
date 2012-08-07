(function (details_modal, $, undefined) {
  // Temporarily holds edits made via AJAX saves. Used to update the DOM to match later.
  details_modal.group_edits = [];
  details_modal.group_rules_typeahead_callback = null;
  details_modal.group_rules = null;

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
  // Note: We switch a callback function instead of re-initializing typeahead()
  //       as typeahead() does not seem to like being reinitialized (as of Bootstrap v2.0.3)
  details_modal.switch_group_rules_autocomplete = function(el) {
    // Ensure the typeahead is initialized
    // Note: As of Bootstrap 2.0.3, $(el).typeahead is always defined, so we cannot use that as a check
    //       and will have to fall back on our own data attribute
    if($(el).data('typeahead-inited') == undefined) {
      $(el).typeahead({
  			source: function( query, maxResults, callback ) {
          details_modal.group_rules_typeahead_callback( query, maxResults, callback );
        },
        valueField: 'id',
        labelField: 'label'
  		});
      $(el).data('typeahead-inited', true);
    }

    // Determine the value of the row's dropdown
    var mode = $(el).parent().parent().find("td:first select").val();

    // Change the callback accordingly
    switch(mode) {
      case 'major':
        details_modal.group_rules_typeahead_callback = function( query, maxResults, callback ) {
          $.ajax({
            url: Routes.api_major_path(),
            data: {
              q: query
            },
            complete: function( data ) {
              data = $.parseJSON(data.responseText);
              entities = [];
              _.each(data, function(entity) {
                entities.push({id: entity.uid, label: entity.name });
              });

              callback(entities);
            }
          });
        };
        break;
      case 'ou':
        details_modal.group_rules_typeahead_callback = function( query, maxResults, callback ) {
          $.ajax({
            url: Routes.api_groups_path(),
            data: {
              q: query
            },
            complete: function( data ) {
              data = $.parseJSON(data.responseText);
              entities = [];
              _.each(data, function(entity) {
                entities.push({id: entity.uid, label: entity.name });
              });

              callback(entities);
            }
          });
        };
        break;
      case 'loginid':
        details_modal.group_rules_typeahead_callback = function( query, maxResults, callback ) {
  				$.ajax({
  					url: Routes.api_loginid_path(),
  					data: {
  						q: query
  					},
  					complete: function( data ) {
              data = $.parseJSON(data.responseText);
              entities = [];
              _.each(data, function(entity) {
                entities.push({id: entity, label: entity });
              });

              callback(entities);
  					}
  				});
  			};
        break;
      case 'title':
        details_modal.group_rules_typeahead_callback = function( query, maxResults, callback ) {
          $.ajax({
  					url: Routes.api_titles_path(),
  					data: {
  						q: query
  					},
  					complete: function( data ) {
              data = $.parseJSON(data.responseText);
              entities = [];
              _.each(data, function(entity) {
                entities.push({id: entity.id, label: entity.name });
              });

              callback(entities);
  					}
  				});
  			}
        break;
      case 'affiliation':
        details_modal.group_rules_typeahead_callback = function( query, maxResults, callback ) {
          $.ajax({
  					url: Routes.api_affiliation_path(),
  					data: {
  						q: query
  					},
  					complete: function( data ) {
              data = $.parseJSON(data.responseText);
              entities = [];
              _.each(data, function(entity) {
                entities.push({id: entity, label: entity });
              });

              callback(entities);
  					}
  				});
  			}
        break;
      case 'classification':
        details_modal.group_rules_typeahead_callback = function( query, maxResults, callback ) {
          $.ajax({
  					url: Routes.api_classifications_path(),
  					data: {
  						q: query
  					},
  					complete: function( data ) {
              data = $.parseJSON(data.responseText);
              entities = [];
              _.each(data, function(entity) {
                entities.push({id: entity, label: entity });
              });

              callback(entities);
  					}
  				});
  			}
        break;
      default:
        console.log("Unimplemented group rule dropdown value: " + mode);
        break;
    }
  }

  details_modal.render_group_rules = function() {
    group_rule_template = $("#tmpl-group-rule").html();
    $rule_table = $("fieldset#rules table tbody");
    $rule_table.empty();
    _.each(details_modal.group_rules, function(rule, i) {
      var compiledTmpl = _.template(group_rule_template, { rule: rule.group_rule, index: i });
      $rule_table.append(compiledTmpl);
    });
  }

  details_modal.init = function() {
    // Ensure the apply button works
    $(".modal #apply").click(function() {
      details_modal.save();
      //$(".modal").modal('hide');
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
        excludeReadOnlyOnSubmit: true
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
      $("fieldset#rules table tbody").on("focus", "tr.fields td input", function(e) {
        $(this).focus(details_modal.switch_group_rules_autocomplete(e.currentTarget));
      });

      $("div.modal-footer").on("click", "a#delete", function(e) {
        bootstrap_modal_alert("Are you sure you want to permanently delete this group?",
          {'verify': true, 'textYes': "Permanently Delete Group", 'textNo': "Cancel"}, function(confirm) {
          if(confirm) {
            // Delete the application
            var group_id = $("form.edit_group input#group_id").val();

    				$.ajax({ url: Routes.group_path(group_id) + ".json", type: 'DELETE',
    					complete: function( data ) {
                // Group deleted. Close the dialog(s)
                $(".modal").modal('hide');

                var deleted_uid = '2' + group_id;

                // Remove the group's UID from any application listing
                _.each(applications.applications, function(app) {
                  app.uids = _.filter(app.uids, function(uid) { return uid != deleted_uid });
                });

                // Remove the deleted group from the sidebar
                cards.depopulate_sidebar([deleted_uid]);
    					}
    				});
          }
        });
      });

      // Recalculate group membership when we view the Summary tab
      $("div.modal ul.nav-tabs a").bind('shown', function(e) {
        if(e.target.innerHTML == "Summary") {
          $.getJSON(Routes.group_path($("#group_id").val()) + ".json", function (data) {
            $member_tokens = $("#group_member_tokens");
            $member_tokens.tokenInput("clear");
            $.each(data, function(key, val) {
              if(key == 'members') {
                _.each(val, function(entity) {
                  $member_tokens.tokenInput("add", { id: entity.uid, name: entity.name, readonly: entity.readonly });
                });
              }
            });
          });
        }
      });

      // Render the group rule view (done via JS because it can be updated dynmically)
      details_modal.render_group_rules();

      // Bind the Add Rule and Remove Rule buttons
      $("fieldset#rules").on("click", "button#group_rule_add", function(e) {
        details_modal.group_rules.push({group_rule: { id: '', column: 'Department', condition: 'is', value: '' }});
        details_modal.render_group_rules();
      });
      $("fieldset#rules").on("click", "button#group_rule_remove", function(e) {
        var rule_id = $(this).parent().parent().data("rule-id");
        // Remove the rule from the list and re-render
        var rule = _.find(details_modal.group_rules, function(rule) {if(rule.group_rule.id == rule_id) return true;});
        if(rule) {
          rule.group_rule._destroy = true;
          details_modal.render_group_rules();
        }
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

      $("div.modal-footer").on("click", "a#delete", function(e) {
        bootstrap_modal_alert("Are you sure you want to permanently delete this application?",
          {'verify': true, 'textYes': "Permanently Delete Application", 'textNo': "Cancel"}, function(confirm) {
          if(confirm) {
            // Delete the application
            var app_id = $("form.edit_application input#app_id").val();

    				$.ajax({ url: Routes.application_path(app_id), type: 'DELETE',
    					complete: function( data ) {
                // Application deleted. Close the dialog(s)
                $(".modal").modal('hide');
                applications.applications[app_id] = undefined;
                cards.render_cards();
    					}
    				});
          }
        });
      });
    }
  }
} (window.details_modal = window.details_modal || {}, jQuery));
