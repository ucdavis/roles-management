DssRm.Views.ApplicationItem = Support.CompositeView.extend({
  tagName: "div",

  events: {
    "change input": "update"
  },

  initialize: function() {
    _.bindAll(this, "render");
  },

  render: function () {
    this.$el.attr("id", "application_" + this.model.id);
    this.$el.html(JST['applications/item']({ application: this.model }));
    this.renderCardContents();
    return this;
  },

  renderCardContents: function() {
    var self = this;

    self.$('h3').html(this.model.escape('name'));

    this.model.roles.each(function(role) {
      var roleItem = new DssRm.Views.RoleItem({ model: role });
      self.renderChild(roleItem);
      self.$('.roles').append(roleItem.el);
    });

    //this.$('label').attr("for", "task_completed_" + this.model.get('id'));
    //this.$('label').html(this.model.escape('title'));

    //this.$('input').attr("id", "task_completed_" + this.model.get('id'));
    //this.$('input').prop("checked", this.model.isComplete());

    //this.$('td.assignees').html(this.model.assignedUsers.pluck('email').join(", "));

    //this.$('a').attr("href", this.taskUrl());
  },

  applicationUrl: function() {
    return "#applications/" + this.model.get('id');
  },

  update: function() {
    var complete = this.$('input').prop('checked');
    this.model.save({ complete: complete });
  }
});
