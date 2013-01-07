DssRm.Views.ApplicationItem = Support.CompositeView.extend({
  tagName: "div",
  className: "card",

  initialize: function(options) {
    this.model.on("add remove change destroy sync", this.render, this);

    this.draw_highlighted = (options.highlighted_application_id == this.model.id);
    this.highlighted_role_id = options.highlighted_role_id;
    this.current_user = options.current_user;

    var owner_ids = this.model.owners.map(function(i) { return i.get('id'); } );
    this.owner_names = this.model.owners.map(function(i) { return i.get('name') }).join(', ');
    this.operator_view = ! _.contains(owner_ids, this.current_user.get('id'));
  },

  render: function() {
    this.$el.attr("id", "application_" + this.model.id);
    this.$el.html(JST['applications/item']({ application: this.model }));
    this.renderCardContents();

    if(this.draw_highlighted) {
      this.$el.css("box-shadow", "#08C 0 0 10px").css("border", "1px solid #08C");
    }

    return this;
  },

  renderCardContents: function() {
    var self = this;

    self.$el.data('application-id', this.model.get('id'));
    self.$('h3').html(this.model.escape('name'));
    self.$('.card-title').attr("title", this.model.escape('description'));
    self.$('.application-link').attr("href", this.applicationUrl());
    if(this.operator_view) {
      self.$('h6').html('Owned by ' + this.owner_names);
      self.$('h6').show();
    } else {
      self.$('h6').hide();
    }

    if(this.model.roles.length == 0) {
      self.$('.roles').hide();
    } else {
      self.$('.roles').show();
      this.model.roles.each(function(role) {
        var roleItem = new DssRm.Views.RoleItem({
          model: role,
          highlighted_role_id: self.highlighted_role_id
        });
        self.renderChild(roleItem);
        self.$('.roles').append(roleItem.el);
      });
    }
  },

  applicationUrl: function() {
    return "#applications/" + this.model.get('id');
  },

  update: function() {
    var complete = this.$('input').prop('checked');
    this.model.save({ complete: complete });
  }
});
