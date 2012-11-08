DssRm.Models.Entity = Backbone.Model.extend({
  toJSON: function() {
    var json = _.omit(this.attributes, 'owners', 'operators', 'members', 'rules', 'id', 'type');
    json.owner_ids = this.get('owners').map(function(owner) { return owner.id });
    json.operator_ids = this.get('operators').map(function(operator) { return operator.id });
    json.member_ids = this.get('members').map(function(member) { return member.id });
    json.rules_attributes = this.get('rules').map(function(rule) {
      return { id: rule.id, column: rule.column, condition: rule.condition, value: rule.value };
    });
    return { entity: json };
  }
});
