DssRm.Views.ApplicationShow = Support.CompositeView.extend({
  tagName: "div",

  events: {
    "click a#apply": "save"
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

    // Summary tab
    self.$('h3').html(this.model.escape('name'));
    self.$('input[name=name]').val(this.model.escape('name'));
    self.$('input[name=description]').val(this.model.escape('description'));

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

    // Roles tab
    this.model.roles.each(function(role) {
      var roleItem = new DssRm.Views.ApplicationShowRole({ model: role });
      self.renderChild(roleItem);
      self.$('table#roles').append(roleItem.el);
    });

    // Active Directory tab
    this.model.roles.each(function(role) {
      var roleItem = new DssRm.Views.ApplicationShowAD({ model: role });
      self.renderChild(roleItem);
      self.$('div#ad_fields').append(roleItem.el);
    });
  },

  save: function() {
    debugger;
    this.model.set({ name: this.$('input[name=name]').val() });
    this.model.save();
  },

  update: function() {
    //var complete = this.$('input').prop('checked');
    //this.model.save({ complete: complete });
  }
});
