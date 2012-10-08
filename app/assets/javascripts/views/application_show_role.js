DssRm.Views.ApplicationShowRole = Support.CompositeView.extend({
  tagName: "tr",
  className: "fields",

  render: function () {
    this.$el.html(JST['applications/show_role']({ role: this.model }));
    this.$('input[name=token]').val(this.model.escape('token'));

    return this;
  },
});
