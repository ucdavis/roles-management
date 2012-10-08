DssRm.Views.ApplicationShowRole = Support.CompositeView.extend({
  tagName: "tr",
  className: "fields",

  render: function () {
    this.$el.html(JST['applications/show_role']({ role: this.model }));
    this.$('input[name=token]').val(this.model.escape('token'));
    if(this.model.get('default')) this.$('input[name=default]').attr("checked", "checked");
    this.$('input[name=descriptor]').val(this.model.escape('descriptor'));
    this.$('input[name=description]').val(this.model.escape('description'));

    return this;
  },
});
