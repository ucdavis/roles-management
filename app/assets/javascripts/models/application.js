DssRm.Models.Application = Backbone.Model.extend({
  initialize: function() {
    var rolesAttr = this.get('roles');
    this.roles = new DssRm.Collections.Roles(rolesAttr);

    var ownersAttr = this.get('owners');
    this.owners = new DssRm.Collections.Entities(ownersAttr);
  },

  toJSON: function() {
    var json = _.omit(this.attributes, 'roles', 'owners', 'uids');

    json.roles_attributes = {};
    this.roles.each(function(role, i) {
      json.roles_attributes[i] = { id: role.id.toString(), entity_ids: _.map(role.get('entities'), function(e) { return e.id }) };
    });
    json.owner_ids = this.owners.map(function(owner) {
      return owner.id;
    });

    return json;
  }
});
