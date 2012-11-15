DssRm.Views.ApplicationsIndex = Support.CompositeView.extend({
  tagName: "div",
  className: "row-fluid",

  events: {
    "click .card"             : "selectCard",
    "click #cards"            : "deselectAll",
    "click #cards .card .pin" : "selectRole",
    "click #pins li"          : "selectEntity"
  },

  initialize: function() {
    var self = this;

    this.selected_application = null;
    this.selected_pin = null;
    this.selected_entities = [];

    this.applications = this.options.applications;
    this.entities = this.options.entities;

    this.applications.on('change add', this.render, this);
    this.entities.on('change add', this.render, this);

    this.$el.html(JST['applications/index']({ applications: this.applications }));

    this.$("#sidebar_search").typeahead({
      minLength: 2,
      sorter: function(items) { return items; }, // required to keep the order given to process() in 'source'
      highlighter: function (item) {
        var item = item.split('####')[1]; // See: https://gist.github.com/3694758 (FIXME when typeahead supports passing objects)
        var query = this.query.replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g, '\\$&')
        return item.replace(new RegExp('(' + query + ')', 'ig'), function ($1, match) {
          return '<strong>' + match + '</strong>'
        })
      },
      source: self.sidebarSearch,
      updater: function(item) { self.searchResultSelected(item, self); }
    });
  },

  render: function () {
    var self = this;

    // We must ensure tooltips are closed before possibly deleting their
    // associated DOM elements
    this.$('[rel=tooltip]').each(function(i, el) {
      if(el != undefined) $(el).tooltip('hide');
    });

    this.$('#cards').empty();
    this.applications.each(function(application) {
      var card = new DssRm.Views.ApplicationItem({
        model: application,
        highlighted_application_id: self.selected_application,
        highlighted_pin_id: self.selected_pin
      });
      self.renderChild(card);
      self.$('#cards').append(card.el);
    });

    this.$('#pins').empty();
    this.entities.each(function(entity) {
      var pin = new DssRm.Views.EntityItem({
        model: entity,
        highlighted: _.indexOf(self.selected_entities, entity.get('id')) >= 0 // true if in selected_entities list
      });
      self.renderChild(pin);
      self.$('#pins').append(pin.el);
    });

    return this;
  },

  // Populates the sidebar search with results via async call to Routes.api_search_path()
  sidebarSearch: function(query, process) {
    var self = this;

    $.ajax({ url: Routes.api_search_path(), data: { q: query }, type: 'GET' }).always(function(data) {
      entities = [];
      var exact_match_found = false;
      _.each(data, function(entity) {
        if(query.toLowerCase() == entity.name.toLowerCase()) exact_match_found = true;
        entities.push(entity.id + '####' + entity.name);
      });

      if(exact_match_found == false) {
        // Add the option to create a new one with this query (-1 and -2 are invalid IDs to indicate these choices)
        entities.push(DssRm.Views.ApplicationsIndex.FID_ADD_PERSON + '####Add Person ' + query);
        entities.push(DssRm.Views.ApplicationsIndex.FID_CREATE_GROUP + '####Create Group ' + query);
      }

      process(entities);
    });
  },

  searchResultSelected: function(item, self) {
    var parts = item.split('####');
    var id = parseInt(parts[0]);
    var label = parts[1];

    switch(id) {
      case DssRm.Views.ApplicationsIndex.FID_ADD_PERSON:

      break;
      case DssRm.Views.ApplicationsIndex.FID_CREATE_GROUP:
        self.entities.create({ name: label.slice(13), type: 'Group' }); // slice(13) is removing the "Create Group " prefix
      break;
    }
  },

  selectCard: function(e) {
    e.stopPropagation();

    this.selected_application = $(e.currentTarget).data('application-id');
    this.selected_pin = null;

    this.render();
  },

  deselectAll: function(e) {
    e.preventDefault();

    this.selected_application = null;
    this.selected_pin = null;
    this.selected_entities = [];

    this.render();
  },

  selectRole: function(e) {
    e.stopPropagation();

    this.selected_application = null;
    this.selected_pin = $(e.currentTarget).parent().data('role-id');

    this.render();
  },

  selectEntity: function(e) {
    e.stopPropagation();

    this.selected_entities.push($(e.currentTarget).data('entity-id'));
    this.selected_entities = _.uniq(this.selected_entities);

    this.render();
  }
}, {
  // Constants used in this view
  FID_ADD_PERSON: -1,
  FID_CREATE_GROUP: -2
});
