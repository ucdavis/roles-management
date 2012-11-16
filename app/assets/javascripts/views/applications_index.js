DssRm.Views.ApplicationsIndex = Support.CompositeView.extend({
  tagName: "div",
  className: "row-fluid",

  events: {
    //"click .card"              : "selectCard",
    "click #cards"             : "deselectAll",
    "click #cards .card .role" : "selectRole",
    "click #pins li"           : "selectEntity"
  },

  initialize: function(options) {
    var self = this;

    // View states
    this.selected = {};
    this.selected.application = null;
    this.selected.role = null;
    this.selected.entities = [];

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
        highlighted_application_id: self.selected.application ? self.selected.application.get('id') : null,
        highlighted_role_id: self.selected.role ? self.selected.role.get('id') : null
      });
      self.renderChild(card);
      self.$('#cards').append(card.el);
    });

    this.$('#pins').empty();
    this.entities.each(function(entity) {
      var pin = new DssRm.Views.EntityItem({
        model: entity,
        highlighted: _.indexOf(self.selected.entities, entity.get('id')) >= 0 // true if in selected_entities list
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

  //selectCard: function(e) {
    //e.stopPropagation();

    //this.selected.application = this.applications.get($(e.currentTarget).data('application-id'));
    //this.selected.role = null;
    //this.selected.entities = _.map(this.selected.application.members, function(e) { return e.id });

    //this.render();
  //},

  deselectAll: function(e) {
    e.preventDefault();

    this.selected.application = null;
    this.selected.role = null;
    this.selected.entities = [];

    this.render();
  },

  selectRole: function(e) {
    e.stopPropagation();

    var application_id = $(e.currentTarget).parent().parent().parent().data('application-id');

    this.selected.application = null;
    this.selected.role = this.applications.get(application_id).roles.get($(e.currentTarget).data('role-id'));

    this.render();
  },

  selectEntity: function(e) {
    var clicked_entity_id = $(e.currentTarget).data('entity-id');
    var clicked_entity_name = $(e.currentTarget).data('entity-name');

    e.stopPropagation();

    // Behavior of selecting an entity changes depending on whether an application/role
    // is selected or not.
    // If an application/role is selected, toggling an entity associates or disassociates
    // that entity from that application/role.
    // If no application/role is selected, clicking an entity merely filters the application/role
    // list to display their current assignments.

    if(this.selected.application) {
      // toggle on or off
      var matched = this.selected.application.members.filter(function(e) { return e.id == clicked_entity_id });
      if(matched.length > 0) {
        this.selected.application.members = _.without(this.selected.application.members, matched[0]);
      } else {
        this.selected.application.members.push({ id: clicked_entity_id, name: clicked_entity_name });
      }

      this.selected.application.set({
        members: this.selected.application.members
      });
      this.selected.entities = this.selected.application.members.map(function(e) { return e.id });

      this.selected.application.save();
    } else {
      //this.selected_entities.push($(e.currentTarget).data('entity-id'));
      //this.selected_entities = _.uniq(this.selected_entities);
    }

    this.render();
  }
}, {
  // Constants used in this view
  FID_ADD_PERSON: -1,
  FID_CREATE_GROUP: -2
});
