DssRm.Views.EntityShow = Support.CompositeView.extend({
  tagName: "div",
  className: "modal",
  id: "entityShowModal",

  events: {
    "click a#apply": "save",
    "click button#group_rule_add": "addRule",
    "click button#remove_group_rule": "removeRule",
    "change table#rules select": "storeRuleChanges",
    "change table#rules input": "storeRuleChanges",
    "hidden": "cleanUpModal"
  },

  initialize: function() {
    var self = this;
    var type = this.model.get('type');

    this.model.on('change', this.render, this);

    this.$el.html(JST['entities/show_' + this.model.get('type').toLowerCase() ]({ model: this.model }));

    if(type == "Group") {
      this.$("input[name=owners]").tokenInput(Routes.api_people_path(), {
        crossDomain: false,
        defaultText: "",
        theme: "facebook",
        onAdd: function(item) {
          var owners = self.model.get('owners');
          if (! _.find(owners, function(i) { return i.id == item.id })) {
            // onAdd is triggered by the .tokenInput("add") lines in render,
            // so we need to ensure this actually is a new item
            owners.push(item);
            self.model.set('owners', owners);
          }
        },
        onDelete: function(item) {
          var owners = _.filter(self.model.get('owners'), function(owner) { return owner.id != item.id });
          self.model.set('owners', owners);
        }
      });

      this.$("input[name=operators]").tokenInput(Routes.api_people_path(), {
        crossDomain: false,
        defaultText: "",
        theme: "facebook",
        onAdd: function(item) {
          var operators = self.model.get('operators');
          if (! _.find(operators, function(i) { return i.id == item.id })) {
            // onAdd is triggered by the .tokenInput("add") lines in render,
            // so we need to ensure this actually is a new item
            operators.push(item);
            self.model.set('operators', operators);
          }
        },
        onDelete: function(item) {
          var operators = _.filter(self.model.get('operators'), function(operator) { return operator.id != item.id });
          self.model.set('operators', operators);
        }
      });

      this.$("input[name=members]").tokenInput(Routes.api_people_path(), {
        crossDomain: false,
        defaultText: "",
        theme: "facebook",
        onAdd: function(item) {
          var members = self.model.get('members');
          if (! _.find(members, function(i) { return i.id == item.id })) {
            // onAdd is triggered by the .tokenInput("add") lines in render,
            // so we need to ensure this actually is a new item
            members.push(item);
            self.model.set('members', members);
          }
        },
        onDelete: function(item) {
          var members = _.filter(self.model.get('members'), function(member) { return member.id != item.id });
          self.model.set('members', members);
        }
      });

      this.$el.on("keyup", "table#rules tbody tr input", function(e) {
        console.log("keyup on tbody tr");
      });
    } else if (type == "Person") {
      this.$("input[name=favorites]").tokenInput(Routes.api_people_path(), {
        crossDomain: false,
        defaultText: "",
        theme: "facebook",
        onAdd: function(item) {
          var favorites = self.model.get('favorites');
          if (! _.find(favorites, function(i) { return i.id == item.id })) {
            // onAdd is triggered by the .tokenInput("add") lines in render,
            // so we need to ensure this actually is a new item
            favorites.push(item);
            self.model.set('favorites', favorites);
          }
        },
        onDelete: function(item) {
          var favorites = _.filter(self.model.get('favorites'), function(favorite) { return favorite.id != item.id });
          self.model.set('favorites', favorites);
        }
      });

      this.$("input[name=groups]").tokenInput(Routes.api_groups_path(), {
        crossDomain: false,
        defaultText: "",
        theme: "facebook",
        onAdd: function(item) {
          var group_memberships = self.model.get('group_memberships');
          if (! _.find(group_memberships, function(i) { return i.id == item.id })) {
            // onAdd is triggered by the .tokenInput("add") lines in render,
            // so we need to ensure this actually is a new item
            group_memberships.push(item);
            self.model.set('group_memberships', group_memberships);
          }
        },
        onDelete: function(item) {
          var group_memberships = _.filter(self.model.get('group_memberships'), function(group) { return group.id != item.id });
          self.model.set('group_memberships', group_memberships);
        }
      });

      this.$("input[name=ous]").tokenInput(Routes.api_ous_path(), {
        crossDomain: false,
        defaultText: "",
        theme: "facebook",
        onAdd: function(item) {
          var ous = self.model.get('ous');
          if (! _.find(ous, function(i) { return i.id == item.id })) {
            // onAdd is triggered by the .tokenInput("add") lines in render,
            // so we need to ensure this actually is a new item
            ous.push(item);
            self.model.set('ous', ous);
          }
        },
        onDelete: function(item) {
          var ous = _.filter(self.model.get('ous'), function(ou) { return ou.id != item.id });
          self.model.set('ous', ous);
        }
      });

      $rolesTab = this.$('fieldset#roles');
      _.each(this.model.roles.groupBy("application_name"), function(roleset) {
        var app_name = roleset[0].get('application_name');
        var app_id = roleset[0].get('application_id');

        $rolesTab.append(" \
          <p> \
            <label for=\"_token_input_" + app_id + "\">" + app_name + "</label> \
            <input type=\"text\" name=\"_token_input_" + app_id + "\" class=\"token_input\" /> \
          </p>"
        );

        $rolesTab.find("input[name=_token_input_" + app_id + "]").tokenInput(Routes.api_roles_path() + "?app_id=" + app_id, {
          crossDomain: false,
          defaultText: "",
          theme: "facebook"
          //onAdd: function(item) {
          //  var owners = self.model.get('owners');
          //  if (! _.find(owners, function(i) { return i.id == item.id })) {
          //    // onAdd is triggered by the .tokenInput("add") lines in render,
          //    // so we need to ensure this actually is a new item
          //    owners.push(item);
          //    self.model.set('owners', owners);
          //  }
          //},
          //onDelete: function(item) {
          //  var owners = _.filter(self.model.get('owners'), function(owner) { return owner.id != item.id });
          //  self.model.set('owners', owners);
          //}
        });

        //_.each(roleset, function(role) {
        //  debugger;
        //});
      });

    }
  },

  render: function() {
    var self = this;
    var type = this.model.get('type');

    if(type == "Group") {
      // Summary tab
      self.$('h3').html(this.model.escape('name'));
      self.$('input[name=name]').val(this.model.escape('name'));
      self.$('textarea[name=description]').val(this.model.escape('description'));
      self.$('span#group_member_count').html(this.model.get('members').length);

      var owners_tokeninput = self.$("input[name=owners]");
      owners_tokeninput.tokenInput("clear");
      _.each(this.model.get('owners'), function(owner) {
        owners_tokeninput.tokenInput("add", {id: owner.id, name: owner.name});
      });

      var operators_tokeninput = self.$("input[name=operators]");
      operators_tokeninput.tokenInput("clear");
      _.each(this.model.get('operators'), function(operator) {
        operators_tokeninput.tokenInput("add", {id: operator.id, name: operator.name});
      });

      var members_tokeninput = self.$("input[name=members]");
      members_tokeninput.tokenInput("clear");
      _.each(this.model.get('members'), function(member) {
        members_tokeninput.tokenInput("add", {id: member.id, name: member.name});
      });

      // Rules tab
      var rules_table = self.$("table#rules tbody");
      rules_table.empty();
      _.each(this.model.get('rules'), function(rule, i) {
        var $rule = $(JST['entities/group_rule']());
        $rule.find("td:nth-child(1) select").val(rule.column);
        $rule.find("td:nth-child(2) select").val(rule.condition);
        $rule.find("td:nth-child(3) input").val(rule.value);
        $rule.data("rule_id", rule.id);
        rules_table.append($rule);
      });

      self.$("table#rules tbody tr").each(function(i, e) {
        $(e).find("input#value").typeahead({
          minLength: 2,
          sorter: function(items) { return items; }, // required to keep the order given to process() in 'source'
          highlighter: function (item) {
            var item = item.split('####')[1]; // See: https://gist.github.com/3694758 (FIXME when typeahead supports passing objects)
            var query = this.query.replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g, '\\$&')
            return item.replace(new RegExp('(' + query + ')', 'ig'), function ($1, match) {
              return '<strong>' + match + '</strong>'
            })
          },
          source: self.ruleSearch,
          updater: function(item) { return self.ruleSearchResultSelected(item, self); }
        });
      });
    } else if(type == "Person") {
      // Summary tab
      self.$('h3').html(this.model.escape('name'));
      self.$('h5').html(this.model.escape('byline'));
      self.$('input[name=first]').val(this.model.escape('first'));
      self.$('input[name=last]').val(this.model.escape('last'));
      self.$('input[name=email]').val(this.model.escape('email'));
      self.$('input[name=loginid]').val(this.model.escape('loginid'));
      self.$('input[name=phone]').val(this.model.escape('phone'));
      self.$('input[name=address]').val(this.model.escape('address'));

      var favorites_tokeninput = self.$("input[name=favorites]");
      favorites_tokeninput.tokenInput("clear");
      _.each(this.model.get('favorites'), function(favorite) {
        favorites_tokeninput.tokenInput("add", {id: favorite.id, name: favorite.name});
      });

      var groups_tokeninput = self.$("input[name=groups]");
      groups_tokeninput.tokenInput("clear");
      _.each(this.model.get('group_memberships'), function(group) {
        groups_tokeninput.tokenInput("add", {id: group.id, name: group.name});
      });

      var ous_tokeninput = self.$("input[name=ous]");
      ous_tokeninput.tokenInput("clear");
      _.each(this.model.get('ous'), function(ou) {
        ous_tokeninput.tokenInput("add", {id: ou.id, name: ou.name});
      });

      // Roles tab
      $rolesTab = this.$('fieldset#roles');
      _.each(this.model.roles.groupBy("application_name"), function(roleset) {
        var app_name = roleset[0].get('application_name');
        var app_id = roleset[0].get('application_id');

        role_tokeninput = self.$("input[name=_token_input_" + app_id + "]");
        role_tokeninput.tokenInput("clear");
        _.each(roleset, function(role) {
          role_tokeninput.tokenInput("add", {id: role.get('id'), name: role.get('name') });
        });
      });

    }

    return this;
  },

  save: function(e) {
    var type = this.model.get('type');

    status_bar.show("Saving ...");

    if(type == "Group") {
      this.model.set({
        name: this.$('input[name=name]').val(),
        description: this.$('textarea[name=description]').val()
      });
    } else if(type == "Person") {
      this.model.set({
        first: this.$('input[name=first]').val(),
        last: this.$('input[name=last]').val(),
        email: this.$('input[name=email]').val(),
        loginid: this.$('input[name=loginid]').val(),
        phone: this.$('input[name=phone]').val(),
        address: this.$('input[name=address]').val()
      });
    }

    this.model.save({}, {
      success: function() {
        status_bar.hide();
      },

      error: function() {
        status_bar.show("An error occurred while saving.", "error");
      }
    });

    return false;
  },

  addRule: function(e) {
    var updated_rules = _.clone(this.model.get('rules'));
    // the false ID simply needs to be unique in case the 'remove' button is hit - our backend will provide a proper ID on saving
    updated_rules.push({ column: 'ou', condition: 'is', value: '', id: 'new_' + Math.round((new Date()).getTime()) });

    this.model.set(
      { rules: updated_rules }
    );
  },

  removeRule: function(e) {
    var rule_id = $(e.target).parents("tr").data("rule_id");

    this.model.set(
      { rules: _.reject(this.model.get('rules'), function(r) { return r.id == rule_id }) }
    );
  },

  updateOwnersFromDOM: function(item) {
    console.log("owners updated");
    console.log(item);
  },

  // Copies values off the DOM into this.model
  storeRuleChanges: function(e) {
    var rule_id = $(e.target).parents("tr").data("rule_id");
    var column = $(e.target).parents("tr").children("td:nth-child(1)").find("select").val();
    var condition = $(e.target).parents("tr").children("td:nth-child(2)").find("select").val();
    var value = $(e.target).parents("tr").children("td:nth-child(3)").find("input").val();

    this.model.set(
      { rules: _.map(this.model.get('rules'), function(r) { if(r.id == rule_id) { r.column = column; r.condition = condition; r.value = value; }; return r; } ) }
    );
  },

  cleanUpModal: function() {
    this.model.off('change', this.render, this);

    $("div#entityShowModal").remove();

    // Need to change URL in case they want to open the same modal again
    Backbone.history.navigate("");
  },

  // Populates the sidebar search with results via async call to Routes.api_search_path()
  ruleSearch: function(query, process, e) {
    var lookahead_type = this.$element.parents("tr").find("td:first select").val();
    var lookahead_url = "";

    switch(lookahead_type) {
      case 'major':
        lookahead_url = Routes.api_major_path();
        break;
      case 'ou':
        lookahead_url = Routes.api_ous_path();
        break;
      case 'loginid':
        lookahead_url = Routes.api_loginid_path();
        break;
      case 'title':
        lookahead_url = Routes.api_titles_path();
        break;
      case 'affiliation':
        lookahead_url = Routes.api_affiliation_path();
        break;
      case 'classification':
        lookahead_url = Routes.api_classifications_path();
        break;
    }

    $.ajax({ url: lookahead_url, data: { q: query }, type: 'GET' }).always(function(data) {
      entities = [];
      _.each(data, function(entity) {
        entities.push(entity.id + '####' + entity.name);
      });

      process(entities);
    });
  },

  ruleSearchResultSelected: function(item, self) {
    var parts = item.split('####');
    var id = parseInt(parts[0]);
    var label = parts[1];

    return label;
  }
});
