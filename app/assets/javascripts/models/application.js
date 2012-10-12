DssRm.Models.Application = Backbone.Model.extend({
  initialize: function() {
    this.on("change:roles", this.parseRoles);
    this.parseRoles();
    this.on("change:owners", this.parseOwners);
    this.parseOwners();
  },

  parseRoles: function() {
    var rolesAttr = this.get('roles');
    this.roles = new DssRm.Collections.Roles(rolesAttr);
  },

  parseOwners: function() {
    var ownersAttr = this.get('owners');
    this.owners = new DssRm.Collections.Owners(ownersAttr);
  },

  toJSON: function() {
    var json = _.omit(this.attributes, 'roles', 'owners', 'uids');
    json.roles_attributes = this.roles.map(function(role) {
      return { role_id: role.id };
    });
    json.owners_attributes = this.owners.map(function(owner) {
      return { owner_id: owner.id };
    });
    return json;
  },

  urlRoot: '/applications'
});
