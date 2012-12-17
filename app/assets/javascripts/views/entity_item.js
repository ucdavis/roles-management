DssRm.Views.EntityItem = Support.CompositeView.extend({
  tagName: "li",

  events: {
    "click a>i"                 : "patchTooltipBehavior",
    "click a.entity-remove-link": "removeEntity"
  },

  initialize: function(options) {
    this.model.bind('change', this.render, this);

    this.highlighted = options.highlighted;
    this.current_user = options.current_user;
  },

  render: function () {
    var type = this.model.get('type');

    this.$el.data('entity-id', this.model.get('id'));
    this.$el.data('entity-name', this.model.get('name'));
    this.$el.html(JST['entities/item']({ entity: this.model }));
    this.$('span').html(this.model.escape('name'));
    this.$el.addClass(this.model.get('type').toLowerCase());
    this.$('.entity-details-link').attr("href", this.entityUrl()).on("click", function(e) { e.stopPropagation(); // REMOVE TOOLTIP IF NEEDED });
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

  removeEntity: function(e) {
    e.stopPropagation();

    // REMOVE TOOLTIP HERE

    // This is not the same as unassigning. If somebody clicks the remove link
    // on an entity, they are either deleting a group or removing a favorite person.
    var type = this.model.get('type');

    if(type == "Group") {
      // Destroy the group
      this.model.destroy();
    } else if (type == "Person") {
      // Don't destroy the person - merely remove them from the favorites list
      var model_id = this.model.get('id');
      var e = this.current_user.favorites.find(function(e) { return e.id == model_id; });
      this.current_user.favorites.remove(e);
      this.current_user.save();
    }
  }
});
