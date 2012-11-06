DssRm.Models.Entity = Backbone.Model.extend({
  initialize: function() {
    this.on("change:owners", this.parseOwners);
    this.parseOwners();
    this.on("change:operators", this.parseOperators);
    this.parseOperators();
    this.on("change:members", this.parseMembers);
    this.parseMembers();
  },

  parseOwners: function() {
    var ownersAttr = this.get('owners');
    this.owners = new DssRm.Collections.Entities(ownersAttr);
  },

  parseOperators: function() {
    var operatorsAttr = this.get('operators');
    this.operators = new DssRm.Collections.Entities(operatorsAttr);
  },

  parseMembers: function() {
    var membersAttr = this.get('members');
    this.members = new DssRm.Collections.Entities(membersAttr);
  },

  toJSON: function() {
    var json = _.omit(this.attributes, 'owners', 'operators', 'members', 'rules');
    json.owners_attributes = this.owners.map(function(owner) {
      return { id: owner.id };
    });
    json.operators_attributes = this.operators.map(function(operator) {
      return { id: operator.id };
    });
    json.members_attributes = this.members.map(function(member) {
      return { id: member.id };
    });
    json.rules_attributes = this.get('rules').map(function(rule) {
      return { id: rule.id, column: rule.column, condition: rule.condition, value: rule.value };
    });
    return json;
  }
});
