DssRm.Models.Application = Backbone.Model.extend({
  initialize: function() {
    // Be sure to use this.roles and this.owners and not this.get('roles'), etc.
    this.roles = new DssRm.Collections.Roles(this.get('roles'));
    this.owners = new DssRm.Collections.Entities(this.get('owners'));
    this.operators = new DssRm.Collections.Entities(this.get('operators'));

    this.on('sync', function() {
      // Adding a new role will reveal a proper ID only after the server gives us one on save
      this.roles.reset(this.get('roles'));
    }, this);
  },

  // Returns only the "highest" relationship (this order): owner, operator, admin
  // Uses DssRm.current_user as the entity
  relationship: function() {
    var current_user_id = DssRm.current_user.get('id')

    if(this.owners.find(function(o) { return o.id == current_user_id; } ) !== undefined) return "owner";
    if(this.operators.find(function(o) { return o.id == current_user_id; } ) !== undefined) return "operator";

    if(DssRm.current_user.get('admin')) return "admin";

    return null;
  },

  toJSON: function() {
    var json = _.omit(this.attributes, 'roles', 'owners', 'uids', 'operators');

    json.roles_attributes = this.roles.map(function(role) {
      var r = {};

      if(role.id) r.id = role.id.toString();
      if(role.entities.length > 0) r.entity_ids = role.entities.map(function(e) { return e.id });
      r.token = role.get('token');
      r.default = role.get('default');
      r.name = role.get('name');
      r.description = role.get('description');
      r.ad_path = role.get('ad_path');

      return r;
    });
    json.owner_ids = this.owners.map(function(owner) {
      return owner.id;
    });
    json.operator_ids = this.operators.map(function(operator) {
      return operator.id;
    });

    return json;
  }
});
