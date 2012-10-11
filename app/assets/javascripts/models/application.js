DssRm.Models.Application = Backbone.Model.extend({
  initialize: function() {
    this.on("change:roles", this.parseRoles);
    this.parseRoles();

  },

  parseRoles: function() {
    var rolesAttr = this.get('roles');
    this.roles = new DssRm.Collections.Roles(rolesAttr);
  },

  toJSON: function() {
    var json = _.omit(this.attributes, 'roles', 'owners', 'uids');
    json.roles_attributes = this.roles.map(function(role) {
      return { role_id: role.id };
    });
    return json;
  },

  urlRoot: '/applications'
});
