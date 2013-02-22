(function(){

  function ParameterMissing(message) {
   this.message = message;
  }
  ParameterMissing.prototype = new Error(); 

  var defaults = {
    prefix: '',
    default_url_options: {}
  };

  var NodeTypes = {"GROUP":1,"CAT":2,"SYMBOL":3,"OR":4,"STAR":5,"LITERAL":6,"SLASH":7,"DOT":8};
  
  var Utils = {

    serialize: function(obj){
      if (!obj) {return '';}
      if (window.jQuery) {
        var result = window.jQuery.param(obj);
        return !result ? "" : "?" + result
      }
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
      path = path.split("://");
      var last_index = path.length - 1;
      path[last_index] = path[last_index].replace(/\/+/g, "/").replace(/\/$/m, '');
      return path.join("://");
    },

    set_default_url_options: function(optional_parts, options) {
      for (var i=0;i < optional_parts.length; i++) {
        var part = optional_parts[i];
        if (!options.hasOwnProperty(part) && defaults.default_url_options.hasOwnProperty(part)) {
          options[part] = defaults.default_url_options[part];
        }
      }
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
      if (object === 0) {
        return '0';
      }

      if (! object) { // null, undefined, false or ''
        return '';
      }

      if (typeof(object) == "object") {
        var property = object.to_param || object.id || object;
        if (typeof(property) == "function") {
          property = property.call(object)
        }
        return property.toString();
      } else {
        return object.toString();
      }
    },

    clone: function (obj) {
      if (null == obj || "object" != typeof obj) return obj;
      var copy = obj.constructor();
      for (var attr in obj) {
        if (obj.hasOwnProperty(attr)) copy[attr] = obj[attr];
      }
      return copy;
    },

    prepare_parameters: function(required_parameters, actual_parameters, options) {
      var result = this.clone(options) || {};
      for (var i=0; i < required_parameters.length; i++) {
        result[required_parameters[i]] = actual_parameters[i];
      }
      return result;
    },

    build_path: function(required_parameters, optional_parts, route, args) {
      args = Array.prototype.slice.call(args);
      var opts = this.extract_options(required_parameters.length, args);
      if (args.length > required_parameters.length) {
        throw new Error("Too many parameters provided for path");
      }

      var parameters = this.prepare_parameters(required_parameters, args, opts);
      this.set_default_url_options(optional_parts, parameters);
      var result = Utils.get_prefix();
      var anchor = Utils.extract_anchor(parameters);

      result += this.visit(route, parameters)
      return Utils.clean_path(result + anchor) + Utils.serialize(parameters);
    },

    /*
     * This function is JavaScript impelementation of the
     * Journey::Visitors::Formatter that builds route by given parameters
     * from route binary tree.
     * Binary tree is serialized in the following way:
     * [node type, left node, right node ]
     *
     * @param  {Boolean} optional  Marks the currently visited branch as optional. 
     *   If set to `true`, this method will not throw when encountering 
     *   a missing parameter (used in recursive calls).
     */
    visit: function(route, parameters, optional) {
      var type = route[0];
      var left = route[1];
      var right = route[2];
      switch (type) {
        case NodeTypes.GROUP:
          return this.visit(left, parameters, true)
        case NodeTypes.STAR:
          return this.visit(left, parameters, true)
        case NodeTypes.CAT:
          var leftPart = this.visit(left, parameters, optional),
              rightPart = this.visit(right, parameters, optional);

          if (optional && ! (leftPart && rightPart))
            return '';

          return leftPart + rightPart;
        case NodeTypes.LITERAL:
          return left;
        case NodeTypes.SLASH:
          return left;
        case NodeTypes.DOT:
          return left;
        case NodeTypes.SYMBOL:
          var value = parameters[left];

          if (value || value === 0) {
            delete parameters[left];
            return this.path_identifier(value);
          }

          if (optional) {
            return '';  // missing parameter
          } else {
            throw new ParameterMissing("Route parameter missing: " + left);
          }
        /*
         * I don't know what is this node type
         * Please send your PR if you do
         */
        //case NodeTypes.OR:
        default:
          throw new Error("Unknown Rails node type");
      }
    },

    get_prefix: function(){
      var prefix = defaults.prefix;

      if( prefix !== "" ){
        prefix = prefix.match('\/$') ? prefix : ( prefix + '/');
      }
      
      return prefix;
    },

    namespace: function (root, namespaceString) {
        var parts = namespaceString ? namespaceString.split('.') : [];
        if (parts.length > 0) {
            current = parts.shift();
            root[current] = root[current] || {};
            Utils.namespace(root[current], parts.join('.'));
        }
    }
  };

  Utils.namespace(window, 'Routes');
  window.Routes = {
// admin => /admin/ops/impersonate/:loginid(.:format)
  admin_path: function(_loginid, options) {
  return Utils.build_path(["loginid"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"ops",false]],[7,"/",false]],[6,"impersonate",false]],[7,"/",false]],[3,"loginid",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// admin_ad_path_check => /admin/ad_path_check(.:format)
  admin_ad_path_check_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"ad_path_check",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// admin_api_key => /admin/api_keys/:id(.:format)
  admin_api_key_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"api_keys",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// admin_api_keys => /admin/api_keys(.:format)
  admin_api_keys_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"api_keys",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// admin_api_whitelisted_ip => /admin/api_whitelisted_ips/:id(.:format)
  admin_api_whitelisted_ip_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"api_whitelisted_ips",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// admin_api_whitelisted_ips => /admin/api_whitelisted_ips(.:format)
  admin_api_whitelisted_ips_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"api_whitelisted_ips",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// admin_dialogs_impersonate => /admin/dialogs/impersonate(.:format)
  admin_dialogs_impersonate_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"dialogs",false]],[7,"/",false]],[6,"impersonate",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// admin_dialogs_ip_whitelist => /admin/dialogs/ip_whitelist(.:format)
  admin_dialogs_ip_whitelist_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"dialogs",false]],[7,"/",false]],[6,"ip_whitelist",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// admin_ops_unimpersonate => /admin/ops/unimpersonate(.:format)
  admin_ops_unimpersonate_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"ops",false]],[7,"/",false]],[6,"unimpersonate",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// affiliation => /affiliations/:id(.:format)
  affiliation_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"affiliations",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// affiliations => /affiliations(.:format)
  affiliations_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"affiliations",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// application => /applications/:id(.:format)
  application_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"applications",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// applications => /applications(.:format)
  applications_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"applications",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// authorization_rules => /authorization_rules(.:format)
  authorization_rules_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"authorization_rules",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// authorization_usages => /authorization_usages(.:format)
  authorization_usages_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"authorization_usages",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// change_authorization_rules => /authorization_rules/change(.:format)
  change_authorization_rules_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"authorization_rules",false]],[7,"/",false]],[6,"change",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// classification => /classifications/:id(.:format)
  classification_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"classifications",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// classifications => /classifications(.:format)
  classifications_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"classifications",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_admin_api_key => /admin/api_keys/:id/edit(.:format)
  edit_admin_api_key_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"api_keys",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_admin_api_whitelisted_ip => /admin/api_whitelisted_ips/:id/edit(.:format)
  edit_admin_api_whitelisted_ip_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"api_whitelisted_ips",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_affiliation => /affiliations/:id/edit(.:format)
  edit_affiliation_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"affiliations",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_application => /applications/:id/edit(.:format)
  edit_application_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"applications",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_classification => /classifications/:id/edit(.:format)
  edit_classification_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"classifications",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_entity => /entities/:id/edit(.:format)
  edit_entity_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"entities",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_group => /groups/:id/edit(.:format)
  edit_group_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"groups",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_major => /majors/:id/edit(.:format)
  edit_major_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"majors",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_ou => /ous/:id/edit(.:format)
  edit_ou_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"ous",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_person => /people/:id/edit(.:format)
  edit_person_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"people",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_role => /roles/:id/edit(.:format)
  edit_role_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"roles",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_title => /titles/:id/edit(.:format)
  edit_title_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"titles",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// entities => /entities(.:format)
  entities_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"entities",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// entity => /entities/:id(.:format)
  entity_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"entities",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// graph_authorization_rules => /authorization_rules/graph(.:format)
  graph_authorization_rules_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"authorization_rules",false]],[7,"/",false]],[6,"graph",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// group => /groups/:id(.:format)
  group_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"groups",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// groups => /groups(.:format)
  groups_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"groups",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// major => /majors/:id(.:format)
  major_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"majors",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// majors => /majors(.:format)
  majors_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"majors",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_admin_api_key => /admin/api_keys/new(.:format)
  new_admin_api_key_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"api_keys",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_admin_api_whitelisted_ip => /admin/api_whitelisted_ips/new(.:format)
  new_admin_api_whitelisted_ip_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"api_whitelisted_ips",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_affiliation => /affiliations/new(.:format)
  new_affiliation_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"affiliations",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_application => /applications/new(.:format)
  new_application_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"applications",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_classification => /classifications/new(.:format)
  new_classification_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"classifications",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_entity => /entities/new(.:format)
  new_entity_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"entities",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_group => /groups/new(.:format)
  new_group_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"groups",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_major => /majors/new(.:format)
  new_major_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"majors",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_ou => /ous/new(.:format)
  new_ou_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"ous",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_person => /people/new(.:format)
  new_person_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"people",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_role => /roles/new(.:format)
  new_role_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"roles",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_title => /titles/new(.:format)
  new_title_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"titles",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// ou => /ous/:id(.:format)
  ou_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"ous",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// ous => /ous(.:format)
  ous_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"ous",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// people => /people(.:format)
  people_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"people",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// person => /people/:id(.:format)
  person_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"people",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// rails_info_properties => /rails/info/properties(.:format)
  rails_info_properties_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"rails",false]],[7,"/",false]],[6,"info",false]],[7,"/",false]],[6,"properties",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// role => /roles/:id(.:format)
  role_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"roles",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// roles => /roles(.:format)
  roles_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"roles",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// root => /
  root_path: function(options) {
  return Utils.build_path([], [], [7,"/",false], arguments);
  },
// site_about => /site/about(.:format)
  site_about_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"site",false]],[7,"/",false]],[6,"about",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// site_access_denied => /site/access_denied(.:format)
  site_access_denied_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"site",false]],[7,"/",false]],[6,"access_denied",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// site_contact => /site/contact(.:format)
  site_contact_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"site",false]],[7,"/",false]],[6,"contact",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// site_faq => /site/faq(.:format)
  site_faq_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"site",false]],[7,"/",false]],[6,"faq",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// site_logout => /site/logout(.:format)
  site_logout_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"site",false]],[7,"/",false]],[6,"logout",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// site_request_access => /site/request_access(.:format)
  site_request_access_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"site",false]],[7,"/",false]],[6,"request_access",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// site_welcome => /site/welcome(.:format)
  site_welcome_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"site",false]],[7,"/",false]],[6,"welcome",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// suggest_change_authorization_rules => /authorization_rules/suggest_change(.:format)
  suggest_change_authorization_rules_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"authorization_rules",false]],[7,"/",false]],[6,"suggest_change",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// title => /titles/:id(.:format)
  title_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"titles",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// titles => /titles(.:format)
  titles_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"titles",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  }}
;
  window.Routes.options = defaults;
})();
