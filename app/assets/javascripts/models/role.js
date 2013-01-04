DssRm.Models.Role = Backbone.Model.extend({
  urlRoot: '/roles',

  initialize: function() {
    if(this.get('entities') == undefined) this.set('entities', []);
  },
  
  tokenize: function(str) {
    return String(str).replace(/ /g, '-').replace(/'/g, '').replace(/"/g, '').toLowerCase();
  }
});
