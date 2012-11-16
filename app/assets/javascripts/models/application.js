DssRm.Models.Application = Backbone.Model.extend({
  initialize: function() {
    this.on("change:roles", function() {
      this.parseRoles();
      this.parseOwners();
      this.updateMembers();
    });

    this.parseRoles();
    this.parseOwners();
    this.updateMembers();
  },

  parseRoles: function() {
    var rolesAttr = this.get('roles');
    this.roles = new DssRm.Collections.Roles(rolesAttr);
  },

  parseOwners: function() {
    var ownersAttr = this.get('owners');
    this.owners = new DssRm.Collections.Entities(ownersAttr);
  },

  updateMembers: function() {
    var self = this;

    this.members = [];

    this.roles.each(function(role) {
      _.each(role.get('entities'), function(entity) {
        self.members.push(entity);
      });
    });

    this.members = _.uniq(this.members, false, function(e) { return e.id });
  },

  toJSON: function() {
    var json = _.omit(this.attributes, 'roles', 'owners', 'uids');

    json.roles_attributes = {};
    this.roles.each(function(role, i) {
      json.roles_attributes[i] = { id: role.id.toString(), entity_ids: _.map(role.get('entities'), function(e) { return e.id }).join(",") };
    });
    json.owner_ids = this.owners.map(function(owner) {
      return owner.id;
    });

    console.log(json);

    return json;
  }
});
