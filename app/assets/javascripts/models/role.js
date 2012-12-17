DssRm.Models.Role = Backbone.Model.extend({
  urlRoot: '/roles',

  initialize: function() {
    if(this.get('entities') == undefined) this.set('entities', []);
  }
});
