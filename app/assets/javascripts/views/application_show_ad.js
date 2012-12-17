DssRm.Views.ApplicationShowAD = Support.CompositeView.extend({
  tagName: "span",

  render: function () {
    this.$el.html(JST['applications/show_ad']({ role: this.model }));
    this.$('label').html(this.model.escape('name'));
    this.$('input[name=ad_path]').val(this.model.escape('ad_path'));

    return this;
  },
});
