DssRm.Models.Application = Backbone.Model.extend({
  initialize: function() {
    this.on("change:roles", function() {
      this.parseRoles();
      this.parseOwners();
    });

    this.parseRoles();
    this.parseOwners();
  },

  parseRoles: function() {
    var rolesAttr = this.get('roles');
    this.roles = new DssRm.Collections.Roles(rolesAttr);
  },

  parseOwners: function() {
    var ownersAttr = this.get('owners');
    this.owners = new DssRm.Collections.Entities(ownersAttr);
  },

  toJSON: function() {
    var json = _.omit(this.attributes, 'roles', 'owners', 'uids');

    json.roles_attributes = {};
    _.each(this.get('roles'), function(role, i) {
      json.roles_attributes[i] = { id: role.id.toString(), entity_ids: _.map(role.entities, function(e) { return e.id }) };
    });
    json.owner_ids = this.owners.map(function(owner) {
      return owner.id;
    });

    return json;
  }
});
