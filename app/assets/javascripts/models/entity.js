DssRm.Models.Entity = Backbone.Model.extend({
  toJSON: function() {
    var json = _.omit(this.attributes, 'owners', 'operators', 'members', 'rules', 'id', 'type');
    json.owners_attributes = this.get('owners').map(function(owner) {
      return { id: owner.id };
    });
    json.operators_attributes = this.get('operators').map(function(operator) {
      return { id: operator.id };
    });
    json.members_attributes = this.get('members').map(function(member) {
      return { id: member.id };
    });
    json.rules_attributes = this.get('rules').map(function(rule) {
      return { id: rule.id, column: rule.column, condition: rule.condition, value: rule.value };
    });
    return { entity: json };
  }
});
