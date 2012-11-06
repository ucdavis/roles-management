DssRm.Views.ApplicationsIndex = Support.CompositeView.extend({
  tagName: "div",
  className: "row-fluid",

  initialize: function() {
    var self = this;

    this.applications = this.options.applications;
    this.entities = this.options.entities;

    this.applications.bind('change', this.render, this);

    this.$el.html(JST['applications/index']({ applications: this.applications }));

    this.$("#sidebar_search").typeahead({ source: self.sidebar_search });
  },

  render: function () {
    var self = this;
    this.applications.each(function(application) {
      var card = new DssRm.Views.ApplicationItem({ model: application });
      self.renderChild(card);
      self.$('#cards').append(card.el);
    });

    this.entities.each(function(entity) {
      var pin = new DssRm.Views.EntityItem({ model: entity });
      self.renderChild(pin);
      self.$('#pins').append(pin.el);
    });

    return this;
  },

  // Populates the sidebar search with results via async call to Routes.api_search_path()
  sidebar_search: function(query, process) {
    if(query.length >= 3) {
      $.ajax({ url: Routes.api_search_path(), data: { q: query }, type: 'GET' }).always(function(data) {
        entities = [];
        var exact_match_found = false;
        _.each(data, function(entity) {
          if(query.toLowerCase() == entity.name.toLowerCase()) exact_match_found = true;
          entities.push(entity.name);
        });

        if(exact_match_found == false) {
          // Add the option to create a new one with this query
          entities.push("Add Person " + query);
          entities.push("Create Group " + query);
        }

        process(entities);
      });
    }
  }
});
