DssRm.Models.Entity = Backbone.Model.extend({
  toJSON: function() {
    var json = _.omit(this.attributes, 'owners', 'operators', 'members', 'rules', 'id', 'type', 'roles', 'subordinates', 'groups', 'ous');
    var type = this.get('type');

    if(type == "group") {
      // Group-specific JSON
      json.owner_ids = this.get('owners').map(function(owner) { return owner.id });
      json.operator_ids = this.get('operators').map(function(operator) { return operator.id });
      json.member_ids = this.get('members').map(function(member) { return member.id });
      json.rules_attributes = this.get('rules').map(function(rule) {
        return { id: rule.id, column: rule.column, condition: rule.condition, value: rule.value };
      });
    } else if(type == "person") {
      // Person-specific JSON
      json.role_ids = this.get('roles').map(function(role) { return role.id });
      json.subordinate_ids = this.get('subordinates').map(function(subordinate) { return subordinate.id });
      json.group_ids = this.get('groups').map(function(group) { return group.id });
      json.ou_ids = this.get('ous').map(function(ou) { return ou.id });
    }

    return { entity: json };
  }
});
