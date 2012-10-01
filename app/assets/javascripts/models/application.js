DssRm.Models.Application = Backbone.Model.extend({
  initialize: function() {
    this.on("change:roles", this.parseRoles);
    this.parseRoles();

  },

  parseRoles: function() {
    var rolesAttr = this.get('roles');
    this.roles = new DssRm.Collections.Roles(rolesAttr);
  },

  urlRoot: '/applications'
});
