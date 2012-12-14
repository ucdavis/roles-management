DssRm.Models.Role = Backbone.Model.extend({
  urlRoot: '/roles',

  initialize: function() {
    this.on('add destroy change sync', this.wasUpdated, this);
  },

  wasUpdated: function() {
    console.log("role " + this.get('id') + " was updated:");
    console.log(this.get('entities'));
  }
});
