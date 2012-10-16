DssRm.Views.EntityItem = Support.CompositeView.extend({
  tagName: "li",

  initialize: function() {
    _.bindAll(this, "render");
  },

  render: function () {
    this.$el.attr("uid", this.model.get('uid'));
    this.$el.html(JST['entities/item']({ entity: this.model }));
    this.$('span').html(this.model.escape('name'));
    this.$el.addClass("group");
    this.$('.entity-details-link').attr("href", this.entityUrl());

    return this;
  },

  entityUrl: function() {
    return "#" + DssRm.DetermineEntityUrl(this.model.get('uid'));
  }
});
