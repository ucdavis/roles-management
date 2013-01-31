DssRm.Models.Role = Backbone.Model.extend({
  urlRoot: '/roles',

  initialize: function() {
    this.entities = new DssRm.Collections.Entities(this.get('entities'));
  },

  tokenize: function(str) {
    return String(str).replace(/ /g, '-').replace(/'/g, '').replace(/"/g, '').toLowerCase();
  }
});
