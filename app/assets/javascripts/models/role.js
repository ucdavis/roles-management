DssRm.Models.Role = Backbone.Model.extend({
  urlRoot: '/roles',

  initialize: function() {
    this.entities = new DssRm.Collections.Entities(this.get('entities'));

    this.on("sync", this.updateAttributes, this);
    this.on("change", this.updateAttributes, this);
  },

  updateAttributes: function() {
    this.entities.reset(this.get('entities'), { silent: true });
  },

  tokenize: function(str) {
    return String(str).replace(/ /g, '-').replace(/'/g, '').replace(/"/g, '').toLowerCase();
  }
});
