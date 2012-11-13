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

    this.model.bind('change', this.render, this);

    this.$el.html(JST['entities/show_' + this.model.get('type') ]({ model: this.model }));

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
  },

  render: function() {
    var self = this;
    var type = this.model.get('type');

    if(type == "group") {
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
    } else if(type == "person") {
      // Summary tab
      self.$('h3').html(this.model.escape('name'));
      self.$('input[name=first]').val(this.model.escape('first'));
      self.$('input[name=last]').val(this.model.escape('last'));
      self.$('input[name=email]').val(this.model.escape('email'));
      self.$('input[name=loginid]').val(this.model.escape('loginid'));
      self.$('input[name=phone]').val(this.model.escape('phone'));
      self.$('input[name=address]').val(this.model.escape('address'));

      // Roles tab
      var roles_list = self.$("ul#roles");
      roles_list.empty();
      _.each(this.model.get('roles'), function(role, i) {
        var $role = $('<li><span id="role-descriptor"></span> (<span id="role-token"></span>) for <span id="role-application"></span></li>');
        $role.find("span#role-descriptor").html(role.descriptor);
        $role.find("span#role-token").html(role.token);
        $role.find("span#role-application").html(role.application_name);
        $role.data("role_id", role.id);
        roles_list.append($role);
      });

    }

    return this;
  },

  save: function(e) {
    var type = this.model.get('type');

    if(type == "group") {
      this.model.set({ name: this.$('input[name=name]').val() });
      this.model.set({ description: this.$('textarea[name=description]').val() });
    } else if(type == "person") {
      this.model.set({ first: this.$('input[name=first]').val() });
      this.model.set({ last: this.$('input[name=last]').val() });
    }

    this.model.save();

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
    this.model.unbind('change', this.render, this);

    $("div#entityShowModal").remove();

    // Need to change URL in case they want to open the same modal again
    Backbone.history.navigate("");
  }
});
