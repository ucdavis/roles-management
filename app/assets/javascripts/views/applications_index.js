DssRm.Views.ApplicationsIndex = Support.CompositeView.extend({
  tagName: "div",
  className: "row-fluid",

  events: {
    "click #pins li"            : "selectEntity",
    "click #cards"              : "deselectAll"
  },

  initialize: function(options) {
    var self = this;

    // Create a view state to be shared with sub-views
    this.view_state = {};
    _.extend(this.view_state, Backbone.Events);

    this.view_state.selected_application = null;
    this.view_state.selected_role_id = null;

    this.view_state.on("change", this.render, this);
    DssRm.applications.on('change add remove destroy sync', this.render, this);
    DssRm.current_user.favorites.on('change add remove destroy sync', this.render, this);
    DssRm.current_user.group_ownerships.on('change add remove destroy sync', this.render, this);
    DssRm.current_user.group_operatorships.on('change add remove destroy sync', this.render, this);

    this.$el.html(JST['applications/index']({ applications: DssRm.applications }));

    this.$("#search_sidebar").typeahead({
      minLength: 3,
      sorter: function(items) { return items; }, // required to keep the order given to process() in 'source'
      highlighter: function (item) {
        var parts = item.split('####');
        var item = parts[1]; // See: https://gist.github.com/3694758 (FIXME when typeahead supports passing objects)
        var query = this.query.replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g, '\\$&');
        var ret = item.replace(new RegExp('(' + query + ')', 'ig'), function ($1, match) {
          return '<strong>' + match + '</strong>';
        });
        if(parts[2] !== undefined) ret = ret + parts[2];

        return ret;
      },
      source: self.sidebarSearch,
      updater: function(item) { self.sidebarSearchResultSelected(item, self); },
      items: 15
    });

    this.$("#search_applications").typeahead({
      minLength: 3,
      sorter: function(items) { return items; }, // required to keep the order given to process() in 'source'
      highlighter: function (item) {
        var item = item.split('####')[1]; // See: https://gist.github.com/3694758 (FIXME when typeahead supports passing objects)
        var query = this.query.replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g, '\\$&')
        return item.replace(new RegExp('(' + query + ')', 'ig'), function ($1, match) {
          return '<strong>' + match + '</strong>'
        })
      },
      source: function(query, process) {
        self.applicationSearch(query, process, self);
      },
      updater: function(item) { self.applicationSearchResultSelected(item, self); },
      items: 15
    });

    DssRm.applications.each(function(application) {
      self.renderCard(application);
    });
  },

  renderCard: function(application) {
    var self = this;

    var card = new DssRm.Views.ApplicationItem({
      model: application,
      view_state: self.view_state
    });
    self.renderChild(card);
    self.$('#cards').append(card.el);
  },

  render: function() {
    var self = this;

    // We must ensure tooltips are closed before possibly deleting their
    // associated DOM elements
    this.$('[rel=tooltip]').each(function(i, el) {
      if(el != undefined) $(el).tooltip('hide');
    });

    var _sidebar_entities = _.union(
      DssRm.current_user.group_ownerships.models,
      DssRm.current_user.group_operatorships.models,
      DssRm.current_user.favorites.models);
    var _sidebar_entities = _.sortBy(_sidebar_entities, function(e) {
      var prepend = (e.get('type') == "Group") ? '1' : '2';
      var sort_num = parseInt((prepend + e.get('name').charCodeAt(0).toString()));
      return sort_num;
    });

    if(this.sidebar_entities === undefined) this.sidebar_entities = new DssRm.Collections.Entities();
    this.sidebar_entities.reset(_sidebar_entities);
    // Need group_operatorship IDs has an array when drawing EntityItem
    var group_operatorships = DssRm.current_user.group_operatorships.map(function(group) { return group.get('id') });

    if(this.view_state.selected_role_id) var selected_role = self.view_state.selected_application.roles.where({id: self.view_state.selected_role_id})[0];

    this.$('#pins').empty();
    this.sidebar_entities.each(function(entity) {
      var pin = new DssRm.Views.EntityItem({
        model: entity,
        highlighted: self.entityAssignedToCurrentRole(entity),
        read_only: _.indexOf(group_operatorships, entity.get('id')) >= 0,
        current_role: selected_role,
        current_application: self.view_state.selected_application
      });
      self.renderChild(pin);
      self.$('#pins').append(pin.el);
    });
    if(self.view_state.selected_role_id) {
      var assigned_non_subordinates = selected_role.entities.reject(function(e) {
        var id = e.get('id');
        return self.sidebar_entities.find(function(i) { return i.get('id') == id; });
      });

      _.each(assigned_non_subordinates, function(entity) {
        var pin = new DssRm.Views.EntityItem({
          model: entity,
          highlighted: true,
          faded: true,
          current_role: selected_role,
          current_application: self.view_state.selected_application
        });
        self.renderChild(pin);
        self.$('#pins').append(pin.el);
      });
    }

    return this;
  },

  // Populates the sidebar search with results via async call to Routes.api_search_path()
  sidebarSearch: function(query, process) {
    $.ajax({ url: Routes.api_search_path(), data: { q: query }, type: 'GET' }).always(function(data) {
      entities = [];
      var exact_match_found = false;
      _.each(data, function(entity) {
        if(query.toLowerCase() == entity.name.toLowerCase()) {
          exact_match_found = true;
        }
        entities.push(
          entity.id + '####' + entity.name + '####' + "<i class=\"icon-search sidebar-details\" rel=\"tooltip\" title=\"See details\" onClick=\"var event = arguments[0] || window.event; DssRm.Views.ApplicationsIndex.sidebarDetails(event);\" />"
        );
      });

      if(exact_match_found == false) {
        // Add the option to create a new one with this query (-1 and -2 are invalid IDs to indicate these choices)
        entities.push(DssRm.Views.ApplicationsIndex.FID_ADD_PERSON + '####Import Login ID ' + query);
        entities.push(DssRm.Views.ApplicationsIndex.FID_CREATE_GROUP + '####Create Group ' + query);
      }

      process(entities);
    });
  },

  sidebarSearchResultSelected: function(item, self) {
    var parts = item.split('####');
    var id = parseInt(parts[0]);
    var label = parts[1];
    var self = this;

    switch(id) {
      case DssRm.Views.ApplicationsIndex.FID_ADD_PERSON:
        alert("Currently unsupported.");
      break;
      case DssRm.Views.ApplicationsIndex.FID_CREATE_GROUP:
        DssRm.current_user.group_ownerships.create({ name: label.slice(13), type: 'Group' }); // slice(13) is removing the "Create Group " prefix
      break;
      default:
        // Exact result selected

        // If a role is selected, the behavior is to assign to the role,
        // and not add to favorites. Adding to favorites only happens when
        // no role is selected.
        if(this.view_state.selected_role_id) {
          var selected_role = this.view_state.selected_application.roles.where({ id: self.view_state.selected_role_id })[0];

          var new_entity = new DssRm.Models.Entity({ id: id });
          new_entity.fetch({
            success: function() {
              selected_role.entities.add(new_entity);
              self.view_state.selected_application.save();
            }
          });
        } else {
          // No role selected, so we will add this entity to their favorites
          if(self.sidebar_entities.find(function(e) { return e.id === id }) === undefined) {
            // Add this result
            var p = new DssRm.Models.Entity({ id: id, name: label, type: 'Person' });
            DssRm.current_user.favorites.add(p);
            DssRm.current_user.save();
          }
        }
      break;
    }
  },

  applicationSearch: function(query, process, self) {
    entities = [];
    var exact_match_found = false;

    DssRm.applications.each(function(app) {
      if(app) {
        if(~app.get('name').toLowerCase().indexOf(query.toLowerCase())) {
          if(app.get('name').toLowerCase() == query.toLowerCase()) exact_match_found = true;
          entities.push(app.get('id') + '####' + app.get('name'));
        }
      }
    });
    if(exact_match_found == false) {
      // Add the option to create a new one with this query
      entities.push(DssRm.Views.ApplicationsIndex.FID_CREATE_APPLICATION + '####Create ' + query);
    }

    process(entities);
  },

  applicationSearchResultSelected: function(item, self) {
    var parts = item.split('####');
    var id = parseInt(parts[0]);
    var label = parts[1];

    switch(id) {
      case DssRm.Views.ApplicationsIndex.FID_CREATE_APPLICATION:
        DssRm.applications.create({ name: label.slice(7) }); // slice(7) is removing the "Create " prefix
      break;
    }
  },

  deselectAll: function(e) {
    // Ensure click event isn't due to child ignoring it --
    // we really do want only clicks on div#cards and not its
    // children
    if(e.target == $("div#cards").get(0)) {
      this.view_state.selected_application = null;
      this.view_state.selected_role_id = null;
      this.view_state.trigger('change');
    }
  },

  selectEntity: function(e) {
    var clicked_entity_id = $(e.currentTarget).data('entity-id');
    var clicked_entity_name = $(e.currentTarget).data('entity-name');
    var self = this;

    e.stopPropagation();

    // Behavior of selecting an entity changes depending on whether an application/role
    // is selected or not.
    // If an application/role is selected, toggling an entity associates or disassociates
    // that entity from that application/role.
    // If no application/role is selected, clicking an entity merely filters the application/role
    // list to display their current assignments.

    if(this.view_state.selected_role_id) {
      var selected_role = this.view_state.selected_application.roles.where({ id: this.view_state.selected_role_id })[0];
      // toggle on or off?
      var matched = selected_role.entities.filter(function(e) { return e.id == clicked_entity_id });
      if(matched.length > 0) {
        // toggling off
        selected_role.entities.remove(matched[0]);
        this.view_state.selected_application.save();
      } else {
        // toggling on
        var new_entity = new DssRm.Models.Entity({ id: clicked_entity_id });
        new_entity.fetch({
          success: function() {
            selected_role.entities.add(new_entity);
            self.view_state.selected_application.save();
          }
        });
      }
    }
  },

  entityAssignedToCurrentRole: function(e) {
    var entity_id = e.get('id');
    var self = this;

    if(this.view_state.selected_role_id) var selected_role = this.view_state.selected_application.roles.where({id: self.view_state.selected_role_id})[0];

    if(selected_role) {
      var results = selected_role.entities.find(function(i) { return i.get('id') == entity_id; });
      if(results == undefined) {
        return false;
      } else {
        return true;
      }
    }

    return false;
  }
}, {
  // Constants used in this view
  FID_ADD_PERSON: -1,
  FID_CREATE_GROUP: -2,
  FID_CREATE_APPLICATION: -3,

  // Function defined here for use in onClick.
  // Inline event handler was required on i.sidebar-search to avoid patching
  // Bootstrap's typeahead()
  sidebarDetails: function(e) {
    e.stopPropagation();

    $("input#search_sidebar").val("");

    var entity_id = $(e.target).parent().parent().data("value").split("####")[0];
    DssRm.router.showEntity(entity_id);
  }
});
