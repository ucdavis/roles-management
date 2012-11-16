DssRm.Views.RoleItem = Support.CompositeView.extend({
  tagName: "div",
  className: "role",

  events: {
    "change input": "update"
  },

  initialize: function(options) {
    _.bindAll(this, "render");

    this.draw_highlighted = (options.highlighted_role_id == this.model.id);
  },

  render: function () {
    this.$el.data('role-id', this.model.get('id'));
    this.$el.html(JST['roles/item']({ role: this.model }));
    this.$el.attr("rel", "tooltip");
    this.renderRoleContents();

    if(this.draw_highlighted) {
      this.$el.css("box-shadow", "#08C 0 0 5px").css("border", "1px solid #08C");
    }

    return this;
  },

  renderRoleContents: function() {
    var self = this;

    self.$('a').html(this.model.escape('descriptor'));
    self.$el.attr("title", this.model.escape('description'));
  },

  update: function() {
    var complete = this.$('input').prop('checked');
    this.model.save({ complete: complete });
  }
});
