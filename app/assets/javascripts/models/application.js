DssRm.Models.Application = Backbone.Model.extend({
  initialize: function() {
    // Be sure to use this.roles and this.owners and not this.get('roles'), etc.
    this.roles = new DssRm.Collections.Roles(this.get('roles'));
    this.owners = new DssRm.Collections.Entities(this.get('owners'));
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
