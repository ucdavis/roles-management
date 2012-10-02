DssRm.Views.ApplicationsIndex = Support.CompositeView.extend({
  tagName: "div",
  className: "row-fluid",

  initialize: function() {
    this.applications = this.options.applications;
    this.entities = this.options.entities;

    _.bindAll(this, "render");
    this.bindTo(this.applications, "add", this.render);
  },

  render: function () {
    this.renderTemplate();
    this.renderApplications();

    return this;
  },

  renderTemplate: function() {
    this.$el.html(JST['applications/index']({ applications: this.applications }));
  },

  renderApplications: function() {
    var self = this;
    this.applications.each(function(application) {
      var card = new DssRm.Views.ApplicationItem({ model: application });
      self.renderChild(card);
      self.$('#cards').append(card.el);
    });
  }
});
