DssRm.Views.RoleItem = Support.CompositeView.extend({
  tagName: "div",

  events: {
    "change input": "update"
  },

  initialize: function() {
    _.bindAll(this, "render");
  },

  render: function () {
    this.$el.attr("id", "role_" + this.model.id);
    this.$el.html(JST['roles/item']({ role: this.model }));
    this.renderRoleContents();
    return this;
  },

  renderRoleContents: function() {
    var self = this;

    self.$('.pin').attr("title", this.model.escape('description'));
    self.$('a').html(this.model.escape('descriptor'));
    self.$('a').attr("title", this.model.escape('description'));
  },

  update: function() {
    var complete = this.$('input').prop('checked');
    this.model.save({ complete: complete });
  }
});
