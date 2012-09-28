DssRm.Views.ApplicationsIndex = Support.CompositeView.extend({
  initialize: function() {
    _.bindAll(this, "render");
    this.bindTo(this.collection, "add", this.render);
  },

  render: function () {
    this.renderTemplate();
    this.renderApplications();
    return this;
  },

  renderTemplate: function() {
    this.$el.html(JST['applications/index']({ applications: this.collection }));
  },

  renderApplications: function() {
    var self = this;
    this.collection.each(function(application) {
      var card = new DssRm.Views.ApplicationItem({ model: application });
      self.renderChild(card);
      self.$('#left').append(card.el);
    });
  }
});
