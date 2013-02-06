DssRm.Views.ApplicationItem = Support.CompositeView.extend({
  tagName: "div",
  className: "card",

  events: {
    "click .role"  : "selectRole"
  },

  initialize: function(options) {
    var self = this;

    this.view_state = options.view_state;

    this.model.on("change sync", this.render, this);
    this.view_state.on("change", this.render, this);

    var owner_ids = this.model.owners.map(function(i) { return i.get('id'); } );
    this.owner_names = this.model.owners.map(function(i) { return i.get('name') }).join(', ');
    if(this.owner_names.length == 0) this.owner_names = "Nobody";

    this.relationship = this.model.relationship();

    this.$el.html(JST['applications/item']({ application: this.model }));
    this.$el.attr("id", "application_" + this.model.id);
    this.$el.data('application-id', this.model.get('id'));
    this.$('.card-title').attr("title", this.model.escape('description'));
    this.$('.application-link').attr("href", this.applicationUrl());

    if(this.relationship == "admin" || this.relationship == "operator") {
      this.$('h6').html('Owned by ' + this.owner_names);
      this.$('h6').show();
    } else {
      this.$('h6').hide();
    }
    if(this.relationship == "operator") this.$('i.details').hide();

    if(this.model.roles.length == 0) {
      this.$('.roles').hide();
    } else {
      this.$('.roles').show();

      this.model.roles.each(function(role) {
        var $role_item = self.renderRoleItem(role);
        self.$('.roles').append($role_item);
      });
    }
  },

  render: function() {
    var self = this;

    this.$('#application-name').html(this.model.escape('name'));

    console.log("rendering application item for cid " + this.model.cid);
    console.log(this.model);

    // Highlight this application?
    if(this.view_state.selected_application == this.model) {
      this.$el.css("box-shadow", "#08C 0 0 10px").css("border", "1px solid #08C");
    } else {
      this.$el.css("box-shadow", "0 1px 3px rgba(0, 0, 0, 0.3)").css("border", "1px solid #CCC");
    }

    // Highlight, add or remove any roles?
    var roles_in_dom = [];
    var roles_in_model = this.model.roles.map(function(r) { return r.id } );
    this.$('.roles>.role').each(function(i, r) {
      var role_id = $(r).attr('data-role-id');
      roles_in_dom.push(parseInt(role_id));
      if(role_id == self.view_state.selected_role_id) {
        $(r).css("box-shadow", "#08C 0 0 5px").css("border", "1px solid #08C");
      } else {
        $(r).css("box-shadow", "none").css("border", "1px solid #bce8f1");
      }
    });
    // Remove any roles in the DOM not in our model anymore
    var roles_to_remove = _.difference(roles_in_dom, roles_in_model);

    _.each(roles_to_remove, function(r) {
      var to_remove = self.$('.roles').find("div.role[data-role-id=" + r + "]");
      $(to_remove).remove();
    });

    // Add any roles to the DOM mentioned in our model
    var roles_to_add = _.difference(roles_in_model, roles_in_dom);
    _.each(roles_to_add, function(r) {
      var role = self.model.roles.get(r);
      var $role_item = self.renderRoleItem(role);
      self.$('.roles').append($role_item);
      console.log("adding for " + r);
      console.log(role);
      //debugger;
    });

    return this;
  },

  renderRoleItem: function(role) {
    var $role_item = $('<div class="role"><a href="#">name</a></div>')
    $role_item.attr('data-role-id', role.get('id'));
    $role_item.attr("rel", "tooltip");
    $role_item.find('a').html(role.escape('name'));
    $role_item.attr("title", role.escape('description'));

    return $role_item;
  },

  applicationUrl: function() {
    return "#applications/" + this.model.get('id');
  },

  selectRole: function(e) {
    e.stopPropagation();

    var application_id = $(e.currentTarget).parent().parent().parent().data('application-id');

    this.view_state.selected_application = DssRm.applications.get(application_id);
    this.view_state.selected_role_id = $(e.currentTarget).attr('data-role-id');
    this.view_state.trigger('change');
  }
});
