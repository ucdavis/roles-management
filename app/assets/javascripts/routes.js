(function(){

  function ParameterMissing(message) {
   this.message = message;
  }
  ParameterMissing.prototype = new Error(); 

  var defaults = {
    prefix: '',
    format: ''
  };

  var NodeTypes = {"GROUP":1,"CAT":2,"SYMBOL":3,"OR":4,"STAR":5,"LITERAL":6,"SLASH":7,"DOT":8}
  
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

    set_default_format: function(options) {
      if (!options.hasOwnProperty("format") && defaults.format) options.format = defaults.format;
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

    smartIndexOf: function(array, item){
      if (Array.prototype.indexOf && array.indexOf === Array.prototype.indexOf) return array.indexOf(item);
      for (var i = 0; i < array.length; i++) if (i in array && array[i] === item) return i;
      return -1;
    },

    build_path: function(required_parameters, optional_parts, route, args) {
      args = Array.prototype.slice.call(args);
      var opts = this.extract_options(required_parameters.length, args);
      if (args.length > required_parameters.length) {
        throw new Error("Too many parameters provided for path");
      }

      var parameters = this.prepare_parameters(required_parameters, args, opts);
      // Array#indexOf is not supported by IE <= 8, so we use custom method
      if (Utils.smartIndexOf(optional_parts, 'format') !== -1) {
        this.set_default_format(parameters);
      }
      var result = Utils.get_prefix();
      var anchor = Utils.extract_anchor(parameters);

      result += this.visit(route, parameters)
      return Utils.clean_path(result + anchor) + Utils.serialize(parameters);
    },

    /*
     * This function is JavaScript impelementation of the
     * Journey::Visitors::Formatter that builds route by given parameters
     * and parsed route binary tree.
     * Binary tree is serialized in the following way:
     * [node type, left node, right node ]
     *
     *@param  {Boolean} optional  Marks the currently visited branch as optional. If set to `true`, this method will not throw when encountering a missing parameter (used in recursive calls).
     */
    visit: function(route, options, optional) {
      var type = route[0];
      var left = route[1];
      var right = route[2];
      switch (type) {
        case NodeTypes.GROUP:
          return this.visit(left, options, true)
        case NodeTypes.STAR:
          return this.visit(left, options, true)
        case NodeTypes.CAT:
          var leftPart = this.visit(left, options, optional),
              rightPart = this.visit(right, options, optional);

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
          var value = options[left];

          if (value || value === 0) {
            delete options[left];
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
// api_affiliation => /api/affiliation(.:format)
  api_affiliation_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"affiliation",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// api_application => /api/applications/:id(.:format)
  api_application_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"applications",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// api_applications => /api/applications(.:format)
  api_applications_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"applications",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// api_group => /api/groups/:id(.:format)
  api_group_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"groups",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// api_groups => /api/groups(.:format)
  api_groups_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"groups",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// api_loginid => /api/loginid(.:format)
  api_loginid_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"loginid",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// api_major => /api/major(.:format)
  api_major_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"major",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// api_ou => /api/ous/:id(.:format)
  api_ou_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"ous",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// api_ous => /api/ous(.:format)
  api_ous_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"ous",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// api_people => /api/people(.:format)
  api_people_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"people",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// api_person => /api/people/:id(.:format)
  api_person_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"people",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// api_resolve => /api/resolve(.:format)
  api_resolve_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"resolve",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// api_role => /api/roles/:id(.:format)
  api_role_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"roles",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// api_roles => /api/roles(.:format)
  api_roles_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"roles",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// api_search => /api/search(.:format)
  api_search_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"search",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// api_title => /api/titles/:id(.:format)
  api_title_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"titles",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// api_titles => /api/titles(.:format)
  api_titles_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"titles",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// application => /applications/:id(.:format)
  application_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"applications",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// applications => /applications(.:format)
  applications_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"applications",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_admin_api_whitelisted_ip => /admin/api_whitelisted_ips/:id/edit(.:format)
  edit_admin_api_whitelisted_ip_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"api_whitelisted_ips",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_api_application => /api/applications/:id/edit(.:format)
  edit_api_application_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"applications",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_api_group => /api/groups/:id/edit(.:format)
  edit_api_group_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"groups",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_api_ou => /api/ous/:id/edit(.:format)
  edit_api_ou_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"ous",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_api_person => /api/people/:id/edit(.:format)
  edit_api_person_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"people",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_api_role => /api/roles/:id/edit(.:format)
  edit_api_role_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"roles",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_api_title => /api/titles/:id/edit(.:format)
  edit_api_title_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"titles",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_application => /applications/:id/edit(.:format)
  edit_application_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"applications",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_entity => /entities/:id/edit(.:format)
  edit_entity_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"entities",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_role => /roles/:id/edit(.:format)
  edit_role_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"roles",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// entities => /entities(.:format)
  entities_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"entities",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// entity => /entities/:id(.:format)
  entity_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"entities",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_admin_api_whitelisted_ip => /admin/api_whitelisted_ips/new(.:format)
  new_admin_api_whitelisted_ip_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"api_whitelisted_ips",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_api_application => /api/applications/new(.:format)
  new_api_application_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"applications",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_api_group => /api/groups/new(.:format)
  new_api_group_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"groups",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_api_ou => /api/ous/new(.:format)
  new_api_ou_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"ous",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_api_person => /api/people/new(.:format)
  new_api_person_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"people",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_api_role => /api/roles/new(.:format)
  new_api_role_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"roles",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_api_title => /api/titles/new(.:format)
  new_api_title_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"titles",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_application => /applications/new(.:format)
  new_application_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"applications",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_entity => /entities/new(.:format)
  new_entity_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"entities",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_role => /roles/new(.:format)
  new_role_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"roles",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// role => /roles/:id(.:format)
  role_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"roles",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// roles => /roles(.:format)
  roles_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"roles",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// roles_assign => /roles/assign(.:format)
  roles_assign_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"roles",false]],[7,"/",false]],[6,"assign",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// roles_unassign => /roles/unassign(.:format)
  roles_unassign_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"roles",false]],[7,"/",false]],[6,"unassign",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
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
// site_logout => /site/logout(.:format)
  site_logout_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"site",false]],[7,"/",false]],[6,"logout",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  }}
;
  window.Routes.options = defaults;
})();
