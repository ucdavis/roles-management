DssRm.Views.EntityShow = Support.CompositeView.extend({
  tagName: "div",
  className: "modal",
  id: "entityShowModal",

  events: {
    "click a#apply": "save",
    "click button#group_rule_add": "add_rule",
    "click button#remove_group_rule": "remove_rule",
    "hidden": "cleanUpModal"
  },

  initialize: function() {
    this.model.bind('change', this.render, this);

    this.resolved = DssRm.DetermineEntityType( this.model.get('id') );
    this.$el.html(JST['entities/show_' + this.resolved.type ]({ model: this.model }));

    this.$("input[name=owners]").tokenInput(Routes.api_people_path(), {
      crossDomain: false,
      defaultText: "",
      theme: "facebook",
      tokenValue: "uid"
    });

    this.$("input[name=operators]").tokenInput(Routes.api_people_path(), {
      crossDomain: false,
      defaultText: "",
      theme: "facebook",
      tokenValue: "uid"
    });

    this.$("input[name=members]").tokenInput(Routes.api_people_path(), {
      crossDomain: false,
      defaultText: "",
      theme: "facebook",
      tokenValue: "uid"
    });
  },

  render: function() {
    console.log("render called");

    var self = this;

    if(this.resolved.type == "group") {
      // Summary tab
      self.$('h3').html(this.model.escape('name'));
      self.$('input[name=name]').val(this.model.escape('name'));
      self.$('textarea[name=description]').val(this.model.escape('description'));
      self.$('span#group_member_count').html(this.model.get('members').length);

      var owners_tokeninput = self.$("input[name=owners]");
      owners_tokeninput.tokenInput("clear");
      _.each(this.model.get('owners'), function(owner) {
        owners_tokeninput.tokenInput("add", {uid: owner.uid, name: owner.name});
      });

      var operators_tokeninput = self.$("input[name=operators]");
      operators_tokeninput.tokenInput("clear");
      _.each(this.model.get('operators'), function(operator) {
        operators_tokeninput.tokenInput("add", {uid: operator.uid, name: operator.name});
      });

      var members_tokeninput = self.$("input[name=members]");
      members_tokeninput.tokenInput("clear");
      _.each(this.model.get('members'), function(member) {
        members_tokeninput.tokenInput("add", {uid: member.uid, name: member.name});
      });

      // Rules tab
      var rules_table = self.$("table#rules tbody");
      rules_table.empty();
      _.each(this.model.get('rules'), function(rule) {
        var $rule = $(JST['entities/group_rule']());
        $rule.find("td:nth-child(1) select").val(rule.column);
        $rule.find("td:nth-child(2) select").val(rule.condition);
        $rule.find("td:nth-child(3) input").val(rule.value);
        $rule.data("rule_id", rule.id);
        rules_table.append($rule);
      });
    } else if(this.resolved.type == "person") {

    }

    return this;
  },

  save: function(e) {
    //this.model.set({ name: this.$('input[name=name]').val() });
    this.model.save();

    return false;
  },

  add_rule: function(e) {
    var updated_rules = this.model.get('rules');
    updated_rules.push({ column: 'ou', condition: 'is', value: '' });

    this.model.set(
      { rules: updated_rules }
    );

    this.model.trigger('change');

    window.testers = this;
  },

  remove_rule: function(e) {
    var rule_id = $(e.target).parents("tr").data("rule_id");

    this.model.set(
      { rules: _.reject(this.model.get('rules'), function(r) { return r.id == rule_id }) }
    );
  },

  cleanUpModal: function() {
    this.model.unbind('change', this.render, this);

    $("div#entityShowModal").remove();

    // Need to change URL in case they want to open the same modal again
    Backbone.history.navigate("");
  }
});
