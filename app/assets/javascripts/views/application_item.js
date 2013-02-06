DssRm.Views.ApplicationItem = Support.CompositeView.extend({
  tagName: "div",
  className: "card",

  events: {
    "click .role"  : "selectRole"
  },

  initialize: function(options) {
    var self = this;

    this.view_state = options.view_state;

    this.model.on("add remove change destroy sync", this.render, this);
    this.view_state.on("change", this.render, this);

    var owner_ids = this.model.owners.map(function(i) { return i.get('id'); } );
    this.owner_names = this.model.owners.map(function(i) { return i.get('name') }).join(', ');
    if(this.owner_names.length == 0) this.owner_names = "Nobody";

    this.relationship = this.model.relationship();

    this.$el.html(JST['applications/item']({ application: this.model }));
    this.$el.attr("id", "application_" + this.model.id);
    this.$el.data('application-id', this.model.get('id'));
    this.$('#application-name').html(this.model.escape('name'));
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
        var $role_item = $('<div class="role"></div>')
        $role_item.data('role-id', role.get('id'));
        $role_item.html(JST['roles/item']());
        $role_item.attr("rel", "tooltip");
        $role_item.find('a').html(role.escape('name'));
        $role_item.attr("title", role.escape('description'));

        self.$('.roles').append($role_item);
      });
    }
  },

  render: function() {
    var self = this;

    // Highlight this application?
    if(this.view_state.selected_application == this.model) {
      this.$el.css("box-shadow", "#08C 0 0 10px").css("border", "1px solid #08C");
    } else {
      this.$el.css("box-shadow", "0 1px 3px rgba(0, 0, 0, 0.3)").css("border", "1px solid #CCC");
    }

    // Highlight any roles?
    this.$('.roles>.role').each(function(i, r) {
      var role_id = $(r).data('role-id');
      if(role_id == self.view_state.selected_role_id) {
        $(r).css("box-shadow", "#08C 0 0 5px").css("border", "1px solid #08C");
      } else {
        $(r).css("box-shadow", "none").css("border", "1px solid #bce8f1");
      }
    });

    return this;
  },

  applicationUrl: function() {
    return "#applications/" + this.model.get('id');
  },

  selectRole: function(e) {
    e.stopPropagation();

    var application_id = $(e.currentTarget).parent().parent().parent().data('application-id');

    this.view_state.selected_application = DssRm.applications.get(application_id);
    this.view_state.selected_role_id = $(e.currentTarget).data('role-id');
    this.view_state.trigger('change');
  }
});
