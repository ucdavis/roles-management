DssRm.Views.RoleItem = Support.CompositeView.extend({
  tagName: "div",

  events: {
    "change input": "update"
  },

  initialize: function(options) {
    _.bindAll(this, "render");

    this.draw_highlighted = (options.highlighted_pin_id == this.model.id);
  },

  render: function () {
    this.$el.attr("id", "role_" + this.model.id);
    this.$el.data('role-id', this.model.get('id'));
    this.$el.html(JST['roles/item']({ role: this.model }));
    this.renderRoleContents();

    if(this.draw_highlighted) {
      this.$('div.pin').css("box-shadow", "#08C 0 0 5px").css("border", "1px solid #08C");
    }

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
