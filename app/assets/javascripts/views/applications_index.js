DssRm.Views.ApplicationsIndex = Support.CompositeView.extend({
  tagName: "div",
  className: "row-fluid",

  initialize: function() {
    this.applications = this.options.applications;
    this.entities = this.options.entities;

    this.applications.bind('change', this.render, this);

    this.$el.html(JST['applications/index']({ applications: this.applications }));

    this.$("#search_entities").typeahead({
      source: function(query, maxResults, callback) {
        console.log("source");
        // Populate the search drop down
        if(query.length >= 3) {
          $.ajax({ url: Routes.api_search_path(), data: { q: query }, type: 'GET' }).always(function(data) {
            entities = [];
            var exact_match_found = false;
            _.each(data, function(entity) {
              if(query.toLowerCase() == entity.name.toLowerCase()) exact_match_found = true;
              entities.push({id: entity.uid, label: entity.name });
            });

            if(exact_match_found == false) {
              // Add the option to create a new one with this query
              entities.push({id: -1, label: "Add Person " + query});
              entities.push({id: -2, label: "Create Group " + query});
            }

            callback(entities);
          });
        }
      },
      valueField: 'id',
      labelField: 'label'
    });
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
  }
});
