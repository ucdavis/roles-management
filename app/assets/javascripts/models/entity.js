DssRm.Models.Entity = Backbone.Model.extend({
  url: function() {
    return '/entities/' + this.get('id')
  },

  initialize: function() {
    this.bind('sync change', this.updateAttributes, this);

    this.updateAttributes();
  },

  updateAttributes: function() {
    var type = this.get('type');

    // Some attribtues may or may not exist depending on how this model was initialized.
    // Ensure needed attributes exist, even if blank.
    if(type == "Group") {
      if(this.get('owners') === undefined) this.set('owners', []);
      if(this.get('operators') === undefined) this.set('operators', []);
      if(this.get('members') === undefined) this.set('members', []);
      if(this.get('rules') === undefined) this.set('rules', []);
    } else if(type == "Person") {
      if(this.get('roles') === undefined) this.set('roles', []);
      if(this.get('favorites') === undefined) this.set('favorites', []);
      if(this.get('group_memberships') === undefined) this.set('group_memberships', []);
      if(this.get('group_ownerships') === undefined) this.set('group_ownerships', []);
      if(this.get('group_operatorships') === undefined) this.set('group_operatorships', []);
      if(this.get('ous') === undefined) this.set('ous', []);

      this.favorites = new DssRm.Collections.Entities(this.get('favorites'));
      this.group_memberships = new DssRm.Collections.Entities(this.get('group_memberships'));
      this.group_ownerships = new DssRm.Collections.Entities(this.get('group_ownerships'));
      this.group_operatorships = new DssRm.Collections.Entities(this.get('group_operatorships'));

      var _sidebar_entities = _.union(
        this.get('group_ownerships'),
        this.get('group_operatorships'),
        this.get('favorites'));
      var _sidebar_entities = _.sortBy(_sidebar_entities, function(e) {
        var prepend = (e.type == "Group") ? '1' : '2';
        var sort_num = parseInt((prepend + e.name.charCodeAt(0).toString()));
        console.log(sort_num);
        return parseInt((prepend + e.name.charCodeAt(0).toString()));
      });

      this.sidebar_entities = new DssRm.Collections.Entities(_sidebar_entities);
    }
  },

  toJSON: function() {
    var json = _.omit(this.attributes, 'owners', 'operators', 'members', 'rules', 'id', 'roles', 'favorites', 'group_memberships', 'group_ownerships', 'group_operatorships', 'ous');
    var type = this.get('type');

    if(type == "Group") {
      // Group-specific JSON
      json.owner_ids = this.get('owners').map(function(owner) { return owner.id });
      json.operator_ids = this.get('operators').map(function(operator) { return operator.id });
      json.member_ids = this.get('members').map(function(member) { return member.id });
      json.rules_attributes = this.get('rules').map(function(rule) {
        return { id: rule.id, column: rule.column, condition: rule.condition, value: rule.value };
      });
    } else if(type == "Person") {
      // Person-specific JSON
      json.role_ids = this.get('roles').map(function(role) { return role.id });
      json.favorite_ids = this.get('favorites').map(function(favorite) { return favorite.id });
      json.group_membership_ids = this.get('group_memberships').map(function(group) { return group.id });
      json.group_ownership_ids = this.get('group_ownerships').map(function(group) { return group.id });
      json.group_operatorship_ids = this.get('group_operatorships').map(function(group) { return group.id });
      json.ou_ids = this.get('ous').map(function(ou) { return ou.id });
    }

    return { entity: json };
  }
});
