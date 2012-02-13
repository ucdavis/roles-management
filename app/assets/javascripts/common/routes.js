(function(){

  var defaults = {
    prefix: '',
    format: ''
  };
  
  var Utils = {

    serialize: function(obj){
      if (obj === null) {return '';}
      var s = [];
      for (prop in obj){
        if (obj[prop]) {
          if (obj[prop] instanceof Array) {
            for (var i=0; i < obj[prop].length; i++) {
              key = prop + encodeURIComponent("[]");
              s.push(key + "=" + encodeURIComponent(obj[prop][i].toString()));
            }
          } else {
            s.push(prop + "=" + encodeURIComponent(obj[prop].toString()));
          }
        }
      }
      if (s.length === 0) {
        return '';
      }
      return "?" + s.join('&');
    },

    clean_path: function(path) {
      return path.replace(/\/+/g, "/").replace(/[\)\(]/g, "").replace(/\.$/m, '').replace(/\/$/m, '');
    },

    extract: function(name, options) {
      var o = undefined;
      if (options.hasOwnProperty(name)) {
        o = options[name];
        delete options[name];
      } else if (defaults.hasOwnProperty(name)) {
        o = defaults[name];
      }
      return o;
    },

    extract_format: function(options) {
      var format = options.hasOwnProperty("format") ? options.format : defaults.format;
      delete options.format;
      return format ? "." + format : "";
    },

    extract_anchor: function(options) {
      var anchor = options.hasOwnProperty("anchor") ? options.anchor : null;
      delete options.anchor;
      return anchor ? "#" + anchor : "";
    },

    extract_options: function(number_of_params, args) {
      if (args.length > number_of_params) {
        return typeof(args[args.length-1]) == "object" ?  args.pop() : {};
      } else {
        return {};
      }
    },

    path_identifier: function(object) {
      if (!object) {
        return "";
      }
      if (typeof(object) == "object") {
        return (object.to_param || object.id || object).toString();
      } else {
        return object.toString();
      }
    },

    build_path: function(number_of_params, parts, optional_params, args) {
      args = Array.prototype.slice.call(args);
      var result = Utils.get_prefix();
      var opts = Utils.extract_options(number_of_params, args);
      if (args.length > number_of_params) {
        throw new Error("Too many parameters provided for path");
      }
      var params_count = 0, optional_params_count = 0;
      for (var i=0; i < parts.length; i++) {
        var part = parts[i];
        if (Utils.optional_part(part)) {
          var name = optional_params[optional_params_count];
          optional_params_count++;
          // try and find the option in opts
          var optional = Utils.extract(name, opts);
          if (Utils.specified(optional)) {
            result += part;
            result += Utils.path_identifier(optional);
          }
        } else {
          result += part;
          if (params_count < number_of_params) {
            params_count++;
            var value = args.shift();
            if (Utils.specified(value)) {
              result += Utils.path_identifier(value);
            } else {
              throw new Error("Insufficient parameters to build path");
            }
          }
        }
      }
      var format = Utils.extract_format(opts);
      var anchor = Utils.extract_anchor(opts);
      return Utils.clean_path(result + format + anchor) + Utils.serialize(opts);
    },

    specified: function(value) {
      return !(value === undefined || value === null);
    },

    optional_part: function(part) {
      return part.match(/\(/);
    },

    get_prefix: function(){
      var prefix = defaults.prefix;

      if( prefix !== "" ){
        prefix = prefix.match('\/$') ? prefix : ( prefix + '/');
      }
      
      return prefix;
    }

  };

  window.Routes = {
// classifications => /classifications(.:format)
  classifications_path: function(options) {
  return Utils.build_path(0, ["/classifications"], ["format"], arguments)
  },
// new_classification => /classifications/new(.:format)
  new_classification_path: function(options) {
  return Utils.build_path(0, ["/classifications/new"], ["format"], arguments)
  },
// edit_classification => /classifications/:id/edit(.:format)
  edit_classification_path: function(_id, options) {
  return Utils.build_path(1, ["/classifications/", "/edit"], ["format"], arguments)
  },
// classification => /classifications/:id(.:format)
  classification_path: function(_id, options) {
  return Utils.build_path(1, ["/classifications/"], ["format"], arguments)
  },
// site_index => /site/index(.:format)
  site_index_path: function(options) {
  return Utils.build_path(0, ["/site/index"], ["format"], arguments)
  },
// site_administrate => /site/administrate(.:format)
  site_administrate_path: function(options) {
  return Utils.build_path(0, ["/site/administrate"], ["format"], arguments)
  },
// site_contact => /site/contact(.:format)
  site_contact_path: function(options) {
  return Utils.build_path(0, ["/site/contact"], ["format"], arguments)
  },
// site_logout => /site/logout(.:format)
  site_logout_path: function(options) {
  return Utils.build_path(0, ["/site/logout"], ["format"], arguments)
  },
// site_access_denied => /site/access_denied(.:format)
  site_access_denied_path: function(options) {
  return Utils.build_path(0, ["/site/access_denied"], ["format"], arguments)
  },
// admin_dialogs_impersonate => /admin/dialogs/impersonate(.:format)
  admin_dialogs_impersonate_path: function(options) {
  return Utils.build_path(0, ["/admin/dialogs/impersonate"], ["format"], arguments)
  },
// admin => /admin/ops/impersonate/:loginid(.:format)
  admin_path: function(_loginid, options) {
  return Utils.build_path(1, ["/admin/ops/impersonate/"], ["format"], arguments)
  },
// application_applications => /applications/:application_id/applications(.:format)
  application_applications_path: function(_application_id, options) {
  return Utils.build_path(1, ["/applications/", "/applications"], ["format"], arguments)
  },
// new_application_application => /applications/:application_id/applications/new(.:format)
  new_application_application_path: function(_application_id, options) {
  return Utils.build_path(1, ["/applications/", "/applications/new"], ["format"], arguments)
  },
// edit_application_application => /applications/:application_id/applications/:id/edit(.:format)
  edit_application_application_path: function(_application_id, _id, options) {
  return Utils.build_path(2, ["/applications/", "/applications/", "/edit"], ["format"], arguments)
  },
// application_application => /applications/:application_id/applications/:id(.:format)
  application_application_path: function(_application_id, _id, options) {
  return Utils.build_path(2, ["/applications/", "/applications/"], ["format"], arguments)
  },
// applications => /applications(.:format)
  applications_path: function(options) {
  return Utils.build_path(0, ["/applications"], ["format"], arguments)
  },
// new_application => /applications/new(.:format)
  new_application_path: function(options) {
  return Utils.build_path(0, ["/applications/new"], ["format"], arguments)
  },
// edit_application => /applications/:id/edit(.:format)
  edit_application_path: function(_id, options) {
  return Utils.build_path(1, ["/applications/", "/edit"], ["format"], arguments)
  },
// application => /applications/:id(.:format)
  application_path: function(_id, options) {
  return Utils.build_path(1, ["/applications/"], ["format"], arguments)
  },
// groups => /groups(.:format)
  groups_path: function(options) {
  return Utils.build_path(0, ["/groups"], ["format"], arguments)
  },
// new_group => /groups/new(.:format)
  new_group_path: function(options) {
  return Utils.build_path(0, ["/groups/new"], ["format"], arguments)
  },
// edit_group => /groups/:id/edit(.:format)
  edit_group_path: function(_id, options) {
  return Utils.build_path(1, ["/groups/", "/edit"], ["format"], arguments)
  },
// group => /groups/:id(.:format)
  group_path: function(_id, options) {
  return Utils.build_path(1, ["/groups/"], ["format"], arguments)
  },
// ous => /ous(.:format)
  ous_path: function(options) {
  return Utils.build_path(0, ["/ous"], ["format"], arguments)
  },
// new_ou => /ous/new(.:format)
  new_ou_path: function(options) {
  return Utils.build_path(0, ["/ous/new"], ["format"], arguments)
  },
// edit_ou => /ous/:id/edit(.:format)
  edit_ou_path: function(_id, options) {
  return Utils.build_path(1, ["/ous/", "/edit"], ["format"], arguments)
  },
// ou => /ous/:id(.:format)
  ou_path: function(_id, options) {
  return Utils.build_path(1, ["/ous/"], ["format"], arguments)
  },
// people => /people(.:format)
  people_path: function(options) {
  return Utils.build_path(0, ["/people"], ["format"], arguments)
  },
// new_person => /people/new(.:format)
  new_person_path: function(options) {
  return Utils.build_path(0, ["/people/new"], ["format"], arguments)
  },
// edit_person => /people/:id/edit(.:format)
  edit_person_path: function(_id, options) {
  return Utils.build_path(1, ["/people/", "/edit"], ["format"], arguments)
  },
// person => /people/:id(.:format)
  person_path: function(_id, options) {
  return Utils.build_path(1, ["/people/"], ["format"], arguments)
  },
// root => /
  root_path: function(options) {
  return Utils.build_path(0, ["/"], [], arguments)
  },
// api_person_applications => /api/people/:person_id/applications(.:format)
  api_person_applications_path: function(_person_id, options) {
  return Utils.build_path(1, ["/api/people/", "/applications"], ["format"], arguments)
  },
// new_api_person_application => /api/people/:person_id/applications/new(.:format)
  new_api_person_application_path: function(_person_id, options) {
  return Utils.build_path(1, ["/api/people/", "/applications/new"], ["format"], arguments)
  },
// edit_api_person_application => /api/people/:person_id/applications/:id/edit(.:format)
  edit_api_person_application_path: function(_person_id, _id, options) {
  return Utils.build_path(2, ["/api/people/", "/applications/", "/edit"], ["format"], arguments)
  },
// api_person_application => /api/people/:person_id/applications/:id(.:format)
  api_person_application_path: function(_person_id, _id, options) {
  return Utils.build_path(2, ["/api/people/", "/applications/"], ["format"], arguments)
  },
// api_person_exists => /api/people/:person_id/exists(.:format)
  api_person_exists_path: function(_person_id, options) {
  return Utils.build_path(1, ["/api/people/", "/exists"], ["format"], arguments)
  },
// api_people => /api/people(.:format)
  api_people_path: function(options) {
  return Utils.build_path(0, ["/api/people"], ["format"], arguments)
  },
// new_api_person => /api/people/new(.:format)
  new_api_person_path: function(options) {
  return Utils.build_path(0, ["/api/people/new"], ["format"], arguments)
  },
// edit_api_person => /api/people/:id/edit(.:format)
  edit_api_person_path: function(_id, options) {
  return Utils.build_path(1, ["/api/people/", "/edit"], ["format"], arguments)
  },
// api_person => /api/people/:id(.:format)
  api_person_path: function(_id, options) {
  return Utils.build_path(1, ["/api/people/"], ["format"], arguments)
  },
// api_groups => /api/groups(.:format)
  api_groups_path: function(options) {
  return Utils.build_path(0, ["/api/groups"], ["format"], arguments)
  },
// new_api_group => /api/groups/new(.:format)
  new_api_group_path: function(options) {
  return Utils.build_path(0, ["/api/groups/new"], ["format"], arguments)
  },
// edit_api_group => /api/groups/:id/edit(.:format)
  edit_api_group_path: function(_id, options) {
  return Utils.build_path(1, ["/api/groups/", "/edit"], ["format"], arguments)
  },
// api_group => /api/groups/:id(.:format)
  api_group_path: function(_id, options) {
  return Utils.build_path(1, ["/api/groups/"], ["format"], arguments)
  },
// api_ous => /api/ous(.:format)
  api_ous_path: function(options) {
  return Utils.build_path(0, ["/api/ous"], ["format"], arguments)
  },
// new_api_ou => /api/ous/new(.:format)
  new_api_ou_path: function(options) {
  return Utils.build_path(0, ["/api/ous/new"], ["format"], arguments)
  },
// edit_api_ou => /api/ous/:id/edit(.:format)
  edit_api_ou_path: function(_id, options) {
  return Utils.build_path(1, ["/api/ous/", "/edit"], ["format"], arguments)
  },
// api_ou => /api/ous/:id(.:format)
  api_ou_path: function(_id, options) {
  return Utils.build_path(1, ["/api/ous/"], ["format"], arguments)
  },
// api_classifications => /api/classifications(.:format)
  api_classifications_path: function(options) {
  return Utils.build_path(0, ["/api/classifications"], ["format"], arguments)
  },
// new_api_classification => /api/classifications/new(.:format)
  new_api_classification_path: function(options) {
  return Utils.build_path(0, ["/api/classifications/new"], ["format"], arguments)
  },
// edit_api_classification => /api/classifications/:id/edit(.:format)
  edit_api_classification_path: function(_id, options) {
  return Utils.build_path(1, ["/api/classifications/", "/edit"], ["format"], arguments)
  },
// api_classification => /api/classifications/:id(.:format)
  api_classification_path: function(_id, options) {
  return Utils.build_path(1, ["/api/classifications/"], ["format"], arguments)
  },
// api_titles => /api/titles(.:format)
  api_titles_path: function(options) {
  return Utils.build_path(0, ["/api/titles"], ["format"], arguments)
  },
// new_api_title => /api/titles/new(.:format)
  new_api_title_path: function(options) {
  return Utils.build_path(0, ["/api/titles/new"], ["format"], arguments)
  },
// edit_api_title => /api/titles/:id/edit(.:format)
  edit_api_title_path: function(_id, options) {
  return Utils.build_path(1, ["/api/titles/", "/edit"], ["format"], arguments)
  },
// api_title => /api/titles/:id(.:format)
  api_title_path: function(_id, options) {
  return Utils.build_path(1, ["/api/titles/"], ["format"], arguments)
  },
// api_application_roles => /api/applications/:application_id/roles(.:format)
  api_application_roles_path: function(_application_id, options) {
  return Utils.build_path(1, ["/api/applications/", "/roles"], ["format"], arguments)
  },
// new_api_application_role => /api/applications/:application_id/roles/new(.:format)
  new_api_application_role_path: function(_application_id, options) {
  return Utils.build_path(1, ["/api/applications/", "/roles/new"], ["format"], arguments)
  },
// edit_api_application_role => /api/applications/:application_id/roles/:id/edit(.:format)
  edit_api_application_role_path: function(_application_id, _id, options) {
  return Utils.build_path(2, ["/api/applications/", "/roles/", "/edit"], ["format"], arguments)
  },
// api_application_role => /api/applications/:application_id/roles/:id(.:format)
  api_application_role_path: function(_application_id, _id, options) {
  return Utils.build_path(2, ["/api/applications/", "/roles/"], ["format"], arguments)
  },
// api_applications => /api/applications(.:format)
  api_applications_path: function(options) {
  return Utils.build_path(0, ["/api/applications"], ["format"], arguments)
  },
// new_api_application => /api/applications/new(.:format)
  new_api_application_path: function(options) {
  return Utils.build_path(0, ["/api/applications/new"], ["format"], arguments)
  },
// edit_api_application => /api/applications/:id/edit(.:format)
  edit_api_application_path: function(_id, options) {
  return Utils.build_path(1, ["/api/applications/", "/edit"], ["format"], arguments)
  },
// api_application => /api/applications/:id(.:format)
  api_application_path: function(_id, options) {
  return Utils.build_path(1, ["/api/applications/"], ["format"], arguments)
  },
// api_search => /api/search(.:format)
  api_search_path: function(options) {
  return Utils.build_path(0, ["/api/search"], ["format"], arguments)
  },
// api_resolve => /api/resolve(.:format)
  api_resolve_path: function(options) {
  return Utils.build_path(0, ["/api/resolve"], ["format"], arguments)
  },
// api_org_chart => /api/org_chart(.:format)
  api_org_chart_path: function(options) {
  return Utils.build_path(0, ["/api/org_chart"], ["format"], arguments)
  },
// roles_assign => /roles/assign(.:format)
  roles_assign_path: function(options) {
  return Utils.build_path(0, ["/roles/assign"], ["format"], arguments)
  },
// roles_unassign => /roles/unassign(.:format)
  roles_unassign_path: function(options) {
  return Utils.build_path(0, ["/roles/unassign"], ["format"], arguments)
  },
// graph_authorization_rules => /authorization_rules/graph(.:format)
  graph_authorization_rules_path: function(options) {
  return Utils.build_path(0, ["/authorization_rules/graph"], ["format"], arguments)
  },
// change_authorization_rules => /authorization_rules/change(.:format)
  change_authorization_rules_path: function(options) {
  return Utils.build_path(0, ["/authorization_rules/change"], ["format"], arguments)
  },
// suggest_change_authorization_rules => /authorization_rules/suggest_change(.:format)
  suggest_change_authorization_rules_path: function(options) {
  return Utils.build_path(0, ["/authorization_rules/suggest_change"], ["format"], arguments)
  },
// authorization_rules => /authorization_rules(.:format)
  authorization_rules_path: function(options) {
  return Utils.build_path(0, ["/authorization_rules"], ["format"], arguments)
  },
// authorization_usages => /authorization_usages(.:format)
  authorization_usages_path: function(options) {
  return Utils.build_path(0, ["/authorization_usages"], ["format"], arguments)
  },
// rails_info_properties => /rails/info/properties(.:format)
  rails_info_properties_path: function(options) {
  return Utils.build_path(0, ["/rails/info/properties"], ["format"], arguments)
  }}
;
  window.Routes.options = defaults;
})();
