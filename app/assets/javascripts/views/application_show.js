DssRm.Views.ApplicationShow = Support.CompositeView.extend({
  tagName: "div",
  className: "",

  events: {

  },

  initialize: function() {
    _.bindAll(this, "render");
  },

  render: function () {
    this.$el.html(JST['applications/show']({ application: this.model }));
    this.renderModalContents();
    return this;
  },

  renderModalContents: function() {
    var self = this;

    self.$('#sympa_url').val(window.location.protocol + "//" + window.location.hostname + Routes.api_application_path(this.model.id) + ".txt");

    //self.$('h3').html(this.model.escape('name'));
    //self.$('.card-title').attr("title", this.model.escape('description'));
    //self.$('.application-link').attr("href", this.applicationUrl());

    //this.model.roles.each(function(role) {
      //var roleItem = new DssRm.Views.RoleItem({ model: role });
      //self.renderChild(roleItem);
      //self.$('.roles').append(roleItem.el);
    //});
  },

  update: function() {
    //var complete = this.$('input').prop('checked');
    this.model.save({ complete: complete });
  }
});
