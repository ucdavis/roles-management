DssRm.Models.Application = Backbone.Model.extend({
  initialize: function() {
    this.roles = new DssRm.Collections.Roles(this.get('roles'));
    this.owners = new DssRm.Collections.Entities(this.get('owners'));

    //this.bind('sync', this.updateAttributes, this);

    //this.updateAttributes();

    //this.roles.on('add destroy sync change', this.updateAttributes, this);
  },

  updateAttributes: function() {
    //var rolesAttr = this.get('roles');
    //this.roles.reset(rolesAttr);

    //if(this.get('name') == "New App") {
      //console.log("applicated updated, roles:");
      //console.log(rolesAttr);
    //}

    //var ownersAttr = this.get('owners');
    //this.owners.reset(ownersAttr);
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
