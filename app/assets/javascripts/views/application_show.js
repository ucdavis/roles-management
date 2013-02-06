DssRm.Views.ApplicationShow = Support.CompositeView.extend({
  tagName: "div",

  events: {
    "click a#apply"           : "saveApplication",
    "click a#delete"          : "deleteApplication",
    "hidden"                  : "cleanUpModal",
    "click button#add_role"   : "addRole",
    "click button#remove_role": "removeRole",
    "change table#roles input": "storeRoleChanges",
    "click button#sympa_url"  : "sympaUrl"
  },

  initialize: function(options) {
    var self = this;

    //this.model.on('sync', this.render, this);
    //this.model.roles.on('add change remove sync', this.render, this);

    this.$el.html(JST['applications/show']({ application: this.model }));

    this.$("input[name=owners]").tokenInput(Routes.api_people_path(), {
      crossDomain: false,
      defaultText: "",
      theme: "facebook",
      onAdd: function(item) { self.model.owners.add(item) },
      onDelete: function(item) { self.model.owners.remove(item) }
    });

    this.$("input[name=operators]").tokenInput(Routes.api_people_path(), {
      crossDomain: false,
      defaultText: "",
      theme: "facebook",
      onAdd: function(item) { self.model.operators.add(item) },
      onDelete: function(item) { self.model.operators.remove(item) }
    });
  },

  render: function() {
    var self = this;

    // Summary tab
    self.$('h3').html(this.model.escape('name'));
    self.$('input[name=name]').val(this.model.get('name'));
    self.$('input[name=description]').val(this.model.get('description'));

    var owners_tokeninput = self.$("input[name=owners]");
    owners_tokeninput.tokenInput("clear");
    _.each(this.model.get('owners'), function(owner) {
      owners_tokeninput.tokenInput("add", {id: owner.id, name: owner.name});
    });

    var operators_tokeninput = self.$("input[name=operators]");
    operators_tokeninput.tokenInput("clear");
    _.each(this.model.get('operators'), function(operator) {
      operators_tokeninput.tokenInput("add", {id: operator.id, name: operator.name});
    });

    this.$('span#csv-download>a').attr("href", Routes.application_path(this.model.id) + ".csv");

    // Roles tab
    self.$('table#roles tbody').empty();
    this.model.roles.each(function(role) {
      var roleItem = new DssRm.Views.ApplicationShowRole({ model: role });
      self.renderChild(roleItem);
      self.$('table#roles tbody').append(roleItem.el);
    });

    // Active Directory tab
    self.$('div#ad_fields').empty();
    this.model.roles.each(function(role) {
      var roleItem = new DssRm.Views.ApplicationShowAD({ model: role });
      self.renderChild(roleItem);
      self.$('div#ad_fields').append(roleItem.el);
    });

    return this;
  },

  saveApplication: function() {
    var self = this;

    status_bar.show("Saving application ...");

    // Update the model silently, then save
    this.model.set({
      name: this.$('input[name=name]').val(),
      description: this.$('input[name=description]').val()
    }, { silent: true });

    this.$('input[name=ad_path]').each(function(i, e) {
      var role_id = $(e).data('role-id');
      var value = $(e).val();

      var r = self.model.roles.find(function(r) { return r.id == role_id });
      if(r) {
        r.set({ad_path: value}, { silent: true });
      }
    });

    this.model.save({}, {
      success: function() {
        status_bar.hide();
      },

      error: function() {
        status_bar.show("An error occurred while saving the application.", "error");
      }
    });

    this.render();

    return false;
  },

  deleteApplication: function() {
    var self = this;

    self.$el.fadeOut();
    bootbox.confirm("Are you sure you want to delete " + this.model.escape('name') + "?", function(result) {
      self.$el.fadeIn();

      if (result) {
        // delete the application and dismiss the dialog
        self.model.destroy();

        // dismiss the dialog
        self.$(".modal-header a.close").trigger("click");
      } else {
        // do nothing - do not delete
      }
    });

    return false;
  },

  cleanUpModal: function() {
    this.model.off('add change remove sync', this.render, this);
    this.model.roles.off('add change remove sync reset', this.render, this);

    // Remove any un-saved roles
    this.model.roles.reset( this.model.get('roles'), { silent: true } );

    $("div#applicationShowModal").remove();
    // Need to change URL in case they want to open the same modal again
    Backbone.history.navigate("");
  },

  addRole: function() {
    // the false ID simply needs to be unique in case the 'remove' button is hit - our backend will provide a proper ID on saving
    this.model.roles.add({ id: 'new_' + Math.round((new Date()).getTime()) });

    return false;
  },

  removeRole: function(e) {
    var role_id = $(e.target).parents("tr").data("role_id");
    var role = this.model.roles.find(function(r) { return r.id == role_id });

    this.model.roles.remove(role);

    return false;
  },

  storeRoleChanges: function(e) {
    var role_id = $(e.target).parents("tr").data("role_id");
    var role = this.model.roles.find(function(e) { return e.id == role_id });

    role.set({
      token: $(e.target).parents("tr").find('input[name=token]').val(),
      default: $(e.target).parents("tr").find('input[name=default]').attr("checked") == "checked",
      name: $(e.target).parents("tr").find('input[name=name]').val(),
      description: $(e.target).parents("tr").find('input[name=description]').val()
    });

    return true;
  },

  sympaUrl: function(e) {
    var role_id = $(e.target).parents("tr").data("role_id");
    var url = window.location.protocol + "//" + window.location.hostname + Routes.api_role_path(role_id) + ".txt";

    window.prompt ("Copy to clipboard: Ctrl+C, Enter", url);

    return false;
  }
});
