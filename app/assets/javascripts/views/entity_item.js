DssRm.Views.EntityItem = Support.CompositeView.extend({
  tagName: "li",

  initialize: function() {
    this.model.bind('change', this.render, this);
  },

  render: function () {
    this.$el.attr("uid", this.model.get('uid'));
    this.$el.html(JST['entities/item']({ entity: this.model }));
    this.$('span').html(this.model.escape('name'));
    this.$el.addClass(this.model.get('type'));
    this.$('.entity-details-link').attr("href", this.entityUrl());

    return this;
  },

  entityUrl: function() {
    return "#" + "/entities/" + this.model.get('id');
  }
});
