(function() {
  var NodeTypes, ParameterMissing, Utils, defaults,
    __hasProp = {}.hasOwnProperty;

  ParameterMissing = function(message) {
    this.message = message;
  };

  ParameterMissing.prototype = new Error();

  defaults = {
    prefix: "",
    default_url_options: {}
  };

  NodeTypes = {"GROUP":1,"CAT":2,"SYMBOL":3,"OR":4,"STAR":5,"LITERAL":6,"SLASH":7,"DOT":8};

  Utils = {
    serialize: function(obj) {
      var i, key, prop, result, s, val, _i, _len;

      if (!obj) {
        return "";
      }
      if (window.jQuery) {
        result = window.jQuery.param(obj);
        return (!result ? "" : result);
      }
      s = [];
      for (key in obj) {
        if (!__hasProp.call(obj, key)) continue;
        prop = obj[key];
        if (prop != null) {
          if (this.getObjectType(prop) === "array") {
            for (i = _i = 0, _len = prop.length; _i < _len; i = ++_i) {
              val = prop[i];
              s.push("" + key + (encodeURIComponent("[]")) + "=" + (encodeURIComponent(val.toString())));
            }
          } else {
            s.push("" + key + "=" + (encodeURIComponent(prop.toString())));
          }
        }
      }
      if (!s.length) {
        return "";
      }
      return s.join("&");
    },
    clean_path: function(path) {
      var last_index;

      path = path.split("://");
      last_index = path.length - 1;
      path[last_index] = path[last_index].replace(/\/+/g, "/").replace(/\/$/m, "");
      return path.join("://");
    },
    set_default_url_options: function(optional_parts, options) {
      var i, part, _i, _len, _results;

      _results = [];
      for (i = _i = 0, _len = optional_parts.length; _i < _len; i = ++_i) {
        part = optional_parts[i];
        if (!options.hasOwnProperty(part) && defaults.default_url_options.hasOwnProperty(part)) {
          _results.push(options[part] = defaults.default_url_options[part]);
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    },
    extract_anchor: function(options) {
      var anchor;

      anchor = "";
      if (options.hasOwnProperty("anchor")) {
        anchor = "#" + options.anchor;
        delete options.anchor;
      }
      return anchor;
    },
    extract_options: function(number_of_params, args) {
      var ret_value;

      ret_value = {};
      if (args.length > number_of_params && this.getObjectType(args[args.length - 1]) === "object") {
        ret_value = args.pop();
      }
      return ret_value;
    },
    path_identifier: function(object) {
      var property;

      if (object === 0) {
        return "0";
      }
      if (!object) {
        return "";
      }
      property = object;
      if (this.getObjectType(object) === "object") {
        property = object.to_param || object.id || object;
        if (this.getObjectType(property) === "function") {
          property = property.call(object);
        }
      }
      return property.toString();
    },
    clone: function(obj) {
      var attr, copy, key;

      if ((obj == null) || "object" !== this.getObjectType(obj)) {
        return obj;
      }
      copy = obj.constructor();
      for (key in obj) {
        if (!__hasProp.call(obj, key)) continue;
        attr = obj[key];
        copy[key] = attr;
      }
      return copy;
    },
    prepare_parameters: function(required_parameters, actual_parameters, options) {
      var i, result, val, _i, _len;

      result = this.clone(options) || {};
      for (i = _i = 0, _len = required_parameters.length; _i < _len; i = ++_i) {
        val = required_parameters[i];
        result[val] = actual_parameters[i];
      }
      return result;
    },
    build_path: function(required_parameters, optional_parts, route, args) {
      var opts, parameters, result, url, url_params;

      args = Array.prototype.slice.call(args);
      opts = this.extract_options(required_parameters.length, args);
      if (args.length > required_parameters.length) {
        throw new Error("Too many parameters provided for path");
      }
      parameters = this.prepare_parameters(required_parameters, args, opts);
      this.set_default_url_options(optional_parts, parameters);
      result = "" + (this.get_prefix()) + (this.visit(route, parameters));
      url = Utils.clean_path("" + result + (this.extract_anchor(parameters)));
      if ((url_params = this.serialize(parameters)).length) {
        url += "?" + url_params;
      }
      return url;
    },
    visit: function(route, parameters, optional) {
      var left, left_part, right, right_part, type, value;

      if (optional == null) {
        optional = false;
      }
      type = route[0], left = route[1], right = route[2];
      switch (type) {
        case NodeTypes.GROUP:
          return this.visit(left, parameters, true);
        case NodeTypes.STAR:
          return this.visit_globbing(left, parameters, true);
        case NodeTypes.LITERAL:
        case NodeTypes.SLASH:
        case NodeTypes.DOT:
          return left;
        case NodeTypes.CAT:
          left_part = this.visit(left, parameters, optional);
          right_part = this.visit(right, parameters, optional);
          if (optional && !(left_part && right_part)) {
            return "";
          }
          return "" + left_part + right_part;
        case NodeTypes.SYMBOL:
          value = parameters[left];
          if (value != null) {
            delete parameters[left];
            return this.path_identifier(value);
          }
          if (optional) {
            return "";
          } else {
            throw new ParameterMissing("Route parameter missing: " + left);
          }
          break;
        default:
          throw new Error("Unknown Rails node type");
      }
    },
    visit_globbing: function(route, parameters, optional) {
      var left, right, type, value;

      type = route[0], left = route[1], right = route[2];
      value = parameters[left];
      if (value == null) {
        return this.visit(route, parameters, optional);
      }
      parameters[left] = (function() {
        switch (this.getObjectType(value)) {
          case "array":
            return value.join("/");
          default:
            return value;
        }
      }).call(this);
      return this.visit(route, parameters, optional);
    },
    get_prefix: function() {
      var prefix;

      prefix = defaults.prefix;
      if (prefix !== "") {
        prefix = (prefix.match("/$") ? prefix : "" + prefix + "/");
      }
      return prefix;
    },
    _classToTypeCache: null,
    _classToType: function() {
      var name, _i, _len, _ref;

      if (this._classToTypeCache != null) {
        return this._classToTypeCache;
      }
      this._classToTypeCache = {};
      _ref = "Boolean Number String Function Array Date RegExp Undefined Null".split(" ");
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        name = _ref[_i];
        this._classToTypeCache["[object " + name + "]"] = name.toLowerCase();
      }
      return this._classToTypeCache;
    },
    getObjectType: function(obj) {
      var strType;

      if (window.jQuery && (window.jQuery.type != null)) {
        return window.jQuery.type(obj);
      }
      strType = Object.prototype.toString.call(obj);
      return this._classToType()[strType] || "object";
    },
    namespace: function(root, namespaceString) {
      var current, parts;

      parts = (namespaceString ? namespaceString.split(".") : []);
      if (!parts.length) {
        return;
      }
      current = parts.shift();
      root[current] = root[current] || {};
      return Utils.namespace(root[current], parts.join("."));
    }
  };

  Utils.namespace(window, "Routes");

  window.Routes = {
// admin => /admin/ops/impersonate/:loginid(.:format)
  admin_path: function(_loginid, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["loginid"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"ops",false]],[7,"/",false]],[6,"impersonate",false]],[7,"/",false]],[3,"loginid",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// admin_ad_path_check => /admin/ad_path_check(.:format)
  admin_ad_path_check_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"ad_path_check",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// admin_api_key_user => /admin/api_key_users/:id(.:format)
  admin_api_key_user_path: function(_id, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"api_key_users",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// admin_api_key_users => /admin/api_key_users(.:format)
  admin_api_key_users_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"api_key_users",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// admin_api_whitelisted_ip => /admin/api_whitelisted_ips/:id(.:format)
  admin_api_whitelisted_ip_path: function(_id, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"api_whitelisted_ips",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// admin_api_whitelisted_ips => /admin/api_whitelisted_ips(.:format)
  admin_api_whitelisted_ips_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"api_whitelisted_ips",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// admin_dialogs_impersonate => /admin/dialogs/impersonate(.:format)
  admin_dialogs_impersonate_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"dialogs",false]],[7,"/",false]],[6,"impersonate",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// admin_dialogs_ip_whitelist => /admin/dialogs/ip_whitelist(.:format)
  admin_dialogs_ip_whitelist_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"dialogs",false]],[7,"/",false]],[6,"ip_whitelist",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// admin_ops_unimpersonate => /admin/ops/unimpersonate(.:format)
  admin_ops_unimpersonate_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"ops",false]],[7,"/",false]],[6,"unimpersonate",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// affiliation => /affiliations/:id(.:format)
  affiliation_path: function(_id, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"affiliations",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// affiliations => /affiliations(.:format)
  affiliations_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"affiliations",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// application => /applications/:id(.:format)
  application_path: function(_id, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"applications",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// applications => /applications(.:format)
  applications_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"applications",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// authorization_rules => /authorization_rules(.:format)
  authorization_rules_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"authorization_rules",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// authorization_usages => /authorization_usages(.:format)
  authorization_usages_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"authorization_usages",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// change_authorization_rules => /authorization_rules/change(.:format)
  change_authorization_rules_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"authorization_rules",false]],[7,"/",false]],[6,"change",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// classification => /classifications/:id(.:format)
  classification_path: function(_id, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"classifications",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// classifications => /classifications(.:format)
  classifications_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"classifications",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_admin_api_key_user => /admin/api_key_users/:id/edit(.:format)
  edit_admin_api_key_user_path: function(_id, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"api_key_users",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_admin_api_whitelisted_ip => /admin/api_whitelisted_ips/:id/edit(.:format)
  edit_admin_api_whitelisted_ip_path: function(_id, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"api_whitelisted_ips",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_affiliation => /affiliations/:id/edit(.:format)
  edit_affiliation_path: function(_id, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"affiliations",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_application => /applications/:id/edit(.:format)
  edit_application_path: function(_id, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"applications",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_classification => /classifications/:id/edit(.:format)
  edit_classification_path: function(_id, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"classifications",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_entity => /entities/:id/edit(.:format)
  edit_entity_path: function(_id, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"entities",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_group => /groups/:id/edit(.:format)
  edit_group_path: function(_id, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"groups",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_major => /majors/:id/edit(.:format)
  edit_major_path: function(_id, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"majors",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_ou => /ous/:id/edit(.:format)
  edit_ou_path: function(_id, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"ous",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_person => /people/:id/edit(.:format)
  edit_person_path: function(_id, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"people",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_role => /roles/:id/edit(.:format)
  edit_role_path: function(_id, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"roles",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_title => /titles/:id/edit(.:format)
  edit_title_path: function(_id, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"titles",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// entities => /entities(.:format)
  entities_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"entities",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// entity => /entities/:id(.:format)
  entity_path: function(_id, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"entities",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// graph_authorization_rules => /authorization_rules/graph(.:format)
  graph_authorization_rules_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"authorization_rules",false]],[7,"/",false]],[6,"graph",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// group => /groups/:id(.:format)
  group_path: function(_id, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"groups",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// groups => /groups(.:format)
  groups_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"groups",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// jasminerice.spec_index => /jasmine/spec(.:format)
  jasminerice_spec_index_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"jasmine",false]],[7,"/",false]],[6,"spec",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// major => /majors/:id(.:format)
  major_path: function(_id, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"majors",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// majors => /majors(.:format)
  majors_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"majors",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_admin_api_key_user => /admin/api_key_users/new(.:format)
  new_admin_api_key_user_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"api_key_users",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_admin_api_whitelisted_ip => /admin/api_whitelisted_ips/new(.:format)
  new_admin_api_whitelisted_ip_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"api_whitelisted_ips",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_affiliation => /affiliations/new(.:format)
  new_affiliation_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"affiliations",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_application => /applications/new(.:format)
  new_application_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"applications",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_classification => /classifications/new(.:format)
  new_classification_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"classifications",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_entity => /entities/new(.:format)
  new_entity_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"entities",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_group => /groups/new(.:format)
  new_group_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"groups",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_major => /majors/new(.:format)
  new_major_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"majors",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_ou => /ous/new(.:format)
  new_ou_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"ous",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_person => /people/new(.:format)
  new_person_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"people",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_role => /roles/new(.:format)
  new_role_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"roles",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_title => /titles/new(.:format)
  new_title_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"titles",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// ou => /ous/:id(.:format)
  ou_path: function(_id, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"ous",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// ous => /ous(.:format)
  ous_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"ous",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// people => /people(.:format)
  people_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"people",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// people_search => /people/search/:term(.:format)
  people_search_path: function(_term, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["term"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"people",false]],[7,"/",false]],[6,"search",false]],[7,"/",false]],[3,"term",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// person => /people/:id(.:format)
  person_path: function(_id, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"people",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// person_import => /people/import/:loginid(.:format)
  person_import_path: function(_loginid, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["loginid"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"people",false]],[7,"/",false]],[6,"import",false]],[7,"/",false]],[3,"loginid",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// rails_info_properties => /rails/info/properties(.:format)
  rails_info_properties_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"rails",false]],[7,"/",false]],[6,"info",false]],[7,"/",false]],[6,"properties",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// role => /roles/:id(.:format)
  role_path: function(_id, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"roles",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// role_sync => /roles/:role_id/sync(.:format)
  role_sync_path: function(_role_id, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["role_id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"roles",false]],[7,"/",false]],[3,"role_id",false]],[7,"/",false]],[6,"sync",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// roles => /roles(.:format)
  roles_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"roles",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// root => /
  root_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], [], [7,"/",false], arguments);
  },
// site_about => /site/about(.:format)
  site_about_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"site",false]],[7,"/",false]],[6,"about",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// site_access_denied => /site/access_denied(.:format)
  site_access_denied_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"site",false]],[7,"/",false]],[6,"access_denied",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// site_contact => /site/contact(.:format)
  site_contact_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"site",false]],[7,"/",false]],[6,"contact",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// site_faq => /site/faq(.:format)
  site_faq_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"site",false]],[7,"/",false]],[6,"faq",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// site_logout => /site/logout(.:format)
  site_logout_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"site",false]],[7,"/",false]],[6,"logout",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// site_request_access => /site/request_access(.:format)
  site_request_access_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"site",false]],[7,"/",false]],[6,"request_access",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// site_welcome => /site/welcome
  site_welcome_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], [], [2,[2,[2,[7,"/",false],[6,"site",false]],[7,"/",false]],[6,"welcome",false]], arguments);
  },
// suggest_change_authorization_rules => /authorization_rules/suggest_change(.:format)
  suggest_change_authorization_rules_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"authorization_rules",false]],[7,"/",false]],[6,"suggest_change",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// title => /titles/:id(.:format)
  title_path: function(_id, options) {
  if (!options){ options = {}; }
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"titles",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// titles => /titles(.:format)
  titles_path: function(options) {
  if (!options){ options = {}; }
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"titles",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  }}
;

  window.Routes.options = defaults;

}).call(this);
