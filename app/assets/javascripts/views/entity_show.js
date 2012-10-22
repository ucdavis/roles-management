DssRm.Views.EntityShow = Support.CompositeView.extend({
  tagName: "div",

  events: {
    "click a#apply": "save",
    "hidden": "cleanUpModal"
  },

  initialize: function() {
    this.model.bind('change', this.render, this);
  },

  render: function () {
    this.$el.html(JST['entities/show']({ model: this.model }));
    this.renderModalContents();
    return this;
  },

  renderModalContents: function() {
    var self = this;

    // Summary tab
    //self.$('h3').html(this.model.escape('name'));
    //self.$('input[name=name]').val(this.model.escape('name'));
    //self.$('input[name=description]').val(this.model.escape('description'));

    //var owners_tokeninput = self.$("input[name=owners]");
    //owners_tokeninput.tokenInput(Routes.api_people_path(), {
      //crossDomain: false,
      //defaultText: "",
      //theme: "facebook",
      //tokenValue: "uid"
    //});
    //_.each(this.model.get('owners'), function(owner) {
      //owners_tokeninput.tokenInput("add", {uid: owner.uid, name: owner.name});
    //});

    //self.$('#sympa_url').val(window.location.protocol + "//" + window.location.hostname + Routes.api_application_path(this.model.id) + ".txt");

    // Roles tab
    //this.model.roles.each(function(role) {
      //var roleItem = new DssRm.Views.ApplicationShowRole({ model: role });
      //self.renderChild(roleItem);
      //self.$('table#roles').append(roleItem.el);
    //});

    // Active Directory tab
    //this.model.roles.each(function(role) {
      //var roleItem = new DssRm.Views.ApplicationShowAD({ model: role });
      //self.renderChild(roleItem);
      //self.$('div#ad_fields').append(roleItem.el);
    //});
  },

  save: function() {
    //this.model.set({ name: this.$('input[name=name]').val() });
    //this.model.save();
  },

  cleanUpModal: function() {
    //$("div#applicationShowModal").remove();
    // Need to change URL in case they want to open the same modal again
    Backbone.history.navigate("");
  }
});
