DssRm.Views.ApplicationItem = Support.CompositeView.extend({
  tagName: "div",
  className: "card",

  initialize: function() {
    _.bindAll(this, "render");
  },

  render: function () {
    this.$el.attr("id", "application_" + this.model.id);
    this.$el.html(JST['applications/item']({ application: this.model }));
    this.renderCardContents();
    return this;
  },

  renderCardContents: function() {
    var self = this;

    self.$('h3').html(this.model.escape('name'));
    self.$('.card-title').attr("title", this.model.escape('description'));
    self.$('.application-link').attr("href", this.applicationUrl());

    this.model.roles.each(function(role) {
      var roleItem = new DssRm.Views.RoleItem({ model: role });
      self.renderChild(roleItem);
      self.$('.roles').append(roleItem.el);
    });
  },

  applicationUrl: function() {
    return "#applications/" + this.model.get('id');
  },

  update: function() {
    var complete = this.$('input').prop('checked');
    this.model.save({ complete: complete });
  }
});
