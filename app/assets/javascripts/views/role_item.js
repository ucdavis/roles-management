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
    //this.$('h3').html(this.model.escape('name'));
    //this.$('label').attr("for", "task_completed_" + this.model.get('id'));
    //this.$('label').html(this.model.escape('title'));

    //this.$('input').attr("id", "task_completed_" + this.model.get('id'));
    //this.$('input').prop("checked", this.model.isComplete());

    //this.$('td.assignees').html(this.model.assignedUsers.pluck('email').join(", "));

    //this.$('a').attr("href", this.taskUrl());
  },

  update: function() {
    var complete = this.$('input').prop('checked');
    this.model.save({ complete: complete });
  }
});
