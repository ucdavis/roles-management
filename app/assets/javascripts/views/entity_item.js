DssRm.Views.EntityItem = Support.CompositeView.extend({
  tagName: "li",

  events: {
    //"change input": "update"
  },

  initialize: function() {
    _.bindAll(this, "render");
  },

  render: function () {
    this.$el.attr("uid", this.model.get('uid'));
    this.$el.html(JST['entities/item']({ entity: this.model }));
    this.$('span').html(this.model.escape('name'));

    return this;
  },

  update: function() {
    this.model.save({ complete: complete });
  }
});
