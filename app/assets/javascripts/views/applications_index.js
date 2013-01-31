DssRm.Views.ApplicationsIndex = Support.CompositeView.extend({
  tagName: "div",
  className: "row-fluid",

  events: {
    "click #cards .card .role"  : "selectRole",
    "click #pins li"            : "selectEntity",
    "click #cards"              : "deselectAll"
  },

  initialize: function(options) {
    var self = this;

    // View states
    this.selected = {};
    this.selected.application = null;
    this.selected.role_id = null;

    this.applications = this.options.applications;
    this.current_user = this.options.current_user;

    this.applications.on('change add remove destroy sync', this.render, this);
    this.current_user.favorites.on('change add remove destroy sync', this.render, this);
    this.current_user.group_ownerships.on('change add remove destroy sync', this.render, this);
    this.current_user.group_operatorships.on('change add remove destroy sync', this.render, this);

    this.$el.html(JST['applications/index']({ applications: this.applications }));

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
  },

  render: function () {
    var self = this;

    console.log("rendering application index");

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
        highlighted_role_id: self.selected.role_id ? self.selected.role_id : null,
        current_user: self.current_user
      });
      self.renderChild(card);
      self.$('#cards').append(card.el);
    });

    var _sidebar_entities = _.union(
      this.current_user.group_ownerships.models,
      this.current_user.group_operatorships.models,
      this.current_user.favorites.models);
    var _sidebar_entities = _.sortBy(_sidebar_entities, function(e) {
      var prepend = (e.get('type') == "Group") ? '1' : '2';
      var sort_num = parseInt((prepend + e.get('name').charCodeAt(0).toString()));
      return sort_num;
    });

    if(this.sidebar_entities === undefined) this.sidebar_entities = new DssRm.Collections.Entities();
    this.sidebar_entities.reset(_sidebar_entities);
    // Need group_operatorship IDs has an array when drawing EntityItem
    var group_operatorships = this.current_user.group_operatorships.map(function(group) { return group.get('id') });

    if(this.selected.role_id) var selected_role = this.selected.application.roles.where({id: this.selected.role_id})[0];

    this.$('#pins').empty();
    console.log("rendering sidebar_entities:");
    console.log(this.sidebar_entities);
    this.sidebar_entities.each(function(entity) {
      var pin = new DssRm.Views.EntityItem({
        model: entity,
        current_user: self.current_user,
        highlighted: self.entityAssignedToCurrentRole(entity),
        read_only: _.indexOf(group_operatorships, entity.get('id')) >= 0,
        current_role: selected_role,
        current_application: self.selected.application
      });
      self.renderChild(pin);
      self.$('#pins').append(pin.el);
    });
    if(this.selected.role_id) {
      console.log("rendering based on selected role:");
      console.log(selected_role);
      var assigned_non_subordinates = selected_role.entities.reject(function(e) {
        var id = e.get('id');
        return self.sidebar_entities.find(function(i) { return i.get('id') == id; });
      });
      console.log("which has calculated assigned_non_subordinates of:");
      console.log(assigned_non_subordinates);

      _.each(assigned_non_subordinates, function(entity) {
        var pin = new DssRm.Views.EntityItem({
          model: entity,
          current_user: self.current_user,
          highlighted: true,
          faded: true,
          current_role: selected_role,
          current_application: self.selected.application
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
        self.current_user.group_ownerships.create({ name: label.slice(13), type: 'Group' }); // slice(13) is removing the "Create Group " prefix
      break;
      default:
        // Exact result selected

        // If a role is selected, the behavior is to assign to the role,
        // and not add to favorites. Adding to favorites only happens when
        // no role is selected.
        if(this.selected.role_id) {
          console.log("start - selected application role cids:");
          this.selected.application.roles.each(function(r) {
            console.log(r.cid);
          });
          var selected_role = this.selected.application.roles.where({ id: this.selected.role_id })[0];
          console.log("selected_role has cid of " + selected_role.cid);

          console.log("Adding id of " + id + " with name " + label);

          var new_entity = new DssRm.Models.Entity({ id: id });
          new_entity.fetch({
            success: function() {
              selected_role.entities.add(new_entity);
              self.selected.application.save();
            }
          });
        } else {
          // No role selected, so we will add this entity to their favorites
          if(self.sidebar_entities.find(function(e) { return e.id === id }) === undefined) {
            // Add this result
            var p = new DssRm.Models.Entity({ id: id, name: label, type: 'Person' });
            self.current_user.favorites.add(p);
            self.current_user.save();
          }
        }
      break;
    }
  },

  applicationSearch: function(query, process, self) {
    entities = [];
    var exact_match_found = false;

    self.applications.each(function(app) {
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
        self.applications.create({ name: label.slice(7) }); // slice(7) is removing the "Create " prefix
      break;
    }
  },

  deselectAll: function(e) {
    this.selected.application = null;
    this.selected.role_id = null;

    this.render();
  },

  selectRole: function(e) {
    e.stopPropagation();

    var application_id = $(e.currentTarget).parent().parent().parent().data('application-id');

    this.selected.application = this.applications.get(application_id);
    this.selected.role_id = $(e.currentTarget).data('role-id');

    this.render();
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

    if(this.selected.role_id) {
      var selected_role = this.selected.application.roles.where({ id: this.selected.role_id })[0];
      // toggle on or off?
      var matched = selected_role.entities.filter(function(e) { return e.id == clicked_entity_id });
      if(matched.length > 0) {
        // toggling off
        selected_role.entities.remove(matched[0]);
        this.selected.application.save();
      } else {
        // toggling on
        var new_entity = new DssRm.Models.Entity({ id: clicked_entity_id });
        new_entity.fetch({
          success: function() {
            selected_role.entities.add(new_entity);
            self.selected.application.save();
          }
        });
      }
    }
  },

  entityAssignedToCurrentRole: function(e) {
    var entity_id = e.get('id');

    if(this.selected.role_id) var selected_role = this.selected.application.roles.where({id: this.selected.role_id})[0];

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
