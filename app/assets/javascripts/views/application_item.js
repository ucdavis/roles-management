DssRm.Views.ApplicationItem = Support.CompositeView.extend({
  tagName: "div",
  className: "card",

  initialize: function(options) {
    _.bindAll(this, "render");

    this.draw_highlighted = (options.highlighted_application_id == this.model.id);
    this.highlighted_role_id = options.highlighted_role_id;
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

    this.model.roles.each(function(role) {
      var roleItem = new DssRm.Views.RoleItem({
        model: role,
        highlighted_role_id: self.highlighted_role_id
      });
      self.renderChild(roleItem);
      self.$('.roles').append(roleItem.el);
    });
  },

  applicationUrl: function() {
    return "#applications/" + this.model.get('id');
  },

  update: function() {
    var complete = this.$('input').prop('checked');
    this.model.save({ complete: complete });
  }
});
