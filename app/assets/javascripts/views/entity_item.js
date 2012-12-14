DssRm.Views.EntityItem = Support.CompositeView.extend({
  tagName: "li",

  events: {
    "click a>i"                 : "patchTooltipBehavior",
    "click a.entity-remove-link": "removeEntity"
  },

  initialize: function(options) {
    this.model.bind('change', this.render, this);

    this.highlighted = options.highlighted;
  },

  render: function () {
    var type = this.model.get('type');

    this.$el.data('entity-id', this.model.get('id'));
    this.$el.data('entity-name', this.model.get('name'));
    this.$el.html(JST['entities/item']({ entity: this.model }));
    this.$('span').html(this.model.escape('name'));
    this.$el.addClass(this.model.get('type').toLowerCase());
    this.$('.entity-details-link').attr("href", this.entityUrl());
    if(type == "Person") this.$('.entity-remove-link i').removeClass("icon-remove").addClass("icon-minus");

    if(this.highlighted) {
      this.$el.css("box-shadow", "#08C 0 0 5px").css("border", "1px solid #08C");
    }

    return this;
  },

  entityUrl: function() {
    return "#" + "/entities/" + this.model.get('id');
  },

  // This is necessary to fix a bug in tooltips (as of Bootstrap 2.1.1)
  patchTooltipBehavior: function(e) {
    $(e.currentTarget).tooltip('hide');
  },

  removeEntity: function() {
    // This is not the same as unassigning. If somebody clicks the remove link
    // on an entity, they are either deleting a group or attempting to delete
    // a person.
    var type = this.model.get('type');

    if(type == "Group") {
      this.model.destroy();
    }
  }
});
