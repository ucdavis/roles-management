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

    self.$('h3').html(this.model.escape('name'));
    self.$('input[name=name]').val(this.model.escape('name'));
    self.$('input[name=description]').val(this.model.escape('description'));

    // Populate owners via jQuery.tokenInput
    var owners_tokeninput = self.$("input[name=owners]");
    owners_tokeninput.tokenInput(Routes.api_people_path(), {
      crossDomain: false,
      defaultText: "",
      theme: "facebook",
      tokenValue: "uid"
    });
    _.each(this.model.get('owners'), function(owner) {
      owners_tokeninput.tokenInput("add", {uid: owner.uid, name: owner.name});
    });


    self.$('#sympa_url').val(window.location.protocol + "//" + window.location.hostname + Routes.api_application_path(this.model.id) + ".txt");

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
