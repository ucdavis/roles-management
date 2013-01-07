DssRm.Models.Application = Backbone.Model.extend({
  initialize: function() {
    // Be sure to use this.roles and this.owners and not this.get('roles'), etc.
    this.roles = new DssRm.Collections.Roles(this.get('roles'));
    this.owners = new DssRm.Collections.Entities(this.get('owners'));

    this.on("sync", this.updateAttributes, this);
  },

  updateAttributes: function() {
    this.roles.reset(this.get('roles'), { silent: true });
    this.owners.reset(this.get('owners'), { silent: true });
  },

  toJSON: function() {
    var json = _.omit(this.attributes, 'roles', 'owners', 'uids');

    json.roles_attributes = this.roles.map(function(role) {
      var r = {};

      if(role.id) r.id = role.id.toString();
      if(role.entities.length > 0) r.entity_ids = role.entities.map(function(e) { return e.id });
      r.token = role.get('token');
      r.default = role.get('default');
      r.name = role.get('name');
      r.description = role.get('description');

      return r;
    });
    json.owner_ids = this.owners.map(function(owner) {
      return owner.id;
    });

    return json;
  }
});
