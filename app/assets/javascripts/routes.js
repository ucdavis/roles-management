(function() {
  var NodeTypes, ParameterMissing, Utils, createGlobalJsRoutesObject, defaults, root,
    __hasProp = {}.hasOwnProperty;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

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
    serialize: function(object, prefix) {
      var element, i, key, prop, result, s, _i, _len;

      if (prefix == null) {
        prefix = null;
      }
      if (!object) {
        return "";
      }
      if (!prefix && !(this.get_object_type(object) === "object")) {
        throw new Error("Url parameters should be a javascript hash");
      }
      if (root.jQuery) {
        result = root.jQuery.param(object);
        return (!result ? "" : result);
      }
      s = [];
      switch (this.get_object_type(object)) {
        case "array":
          for (i = _i = 0, _len = object.length; _i < _len; i = ++_i) {
            element = object[i];
            s.push(this.serialize(element, prefix + "[]"));
          }
          break;
        case "object":
          for (key in object) {
            if (!__hasProp.call(object, key)) continue;
            prop = object[key];
            if (!(prop != null)) {
              continue;
            }
            if (prefix != null) {
              key = "" + prefix + "[" + key + "]";
            }
            s.push(this.serialize(prop, key));
          }
          break;
        default:
          if (object) {
            s.push("" + (encodeURIComponent(prefix.toString())) + "=" + (encodeURIComponent(object.toString())));
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
      path[last_index] = path[last_index].replace(/\/+/g, "/");
      return path.join("://");
    },
    set_default_url_options: function(optional_parts, options) {
      var i, part, _i, _len, _results;

      _results = [];
      for (i = _i = 0, _len = optional_parts.length; _i < _len; i = ++_i) {
        part = optional_parts[i];
        if (!options.hasOwnProperty(part) && defaults.default_url_options.hasOwnProperty(part)) {
          _results.push(options[part] = defaults.default_url_options[part]);
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
    extract_trailing_slash: function(options) {
      var trailing_slash;

      trailing_slash = false;
      if (defaults.default_url_options.hasOwnProperty("trailing_slash")) {
        trailing_slash = defaults.default_url_options.trailing_slash;
      }
      if (options.hasOwnProperty("trailing_slash")) {
        trailing_slash = options.trailing_slash;
        delete options.trailing_slash;
      }
      return trailing_slash;
    },
    extract_options: function(number_of_params, args) {
      var last_el;

      last_el = args[args.length - 1];
      if (args.length > number_of_params || ((last_el != null) && "object" === this.get_object_type(last_el) && !this.look_like_serialized_model(last_el))) {
        return args.pop();
      } else {
        return {};
      }
    },
    look_like_serialized_model: function(object) {
      return "id" in object || "to_param" in object;
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
      if (this.get_object_type(object) === "object") {
        if ("to_param" in object) {
          property = object.to_param;
        } else if ("id" in object) {
          property = object.id;
        } else {
          property = object;
        }
        if (this.get_object_type(property) === "function") {
          property = property.call(object);
        }
      }
      return property.toString();
    },
    clone: function(obj) {
      var attr, copy, key;

      if ((obj == null) || "object" !== this.get_object_type(obj)) {
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
        if (i < actual_parameters.length) {
          result[val] = actual_parameters[i];
        }
      }
      return result;
    },
    build_path: function(required_parameters, optional_parts, route, args) {
      var anchor, opts, parameters, result, trailing_slash, url, url_params;

      args = Array.prototype.slice.call(args);
      opts = this.extract_options(required_parameters.length, args);
      if (args.length > required_parameters.length) {
        throw new Error("Too many parameters provided for path");
      }
      parameters = this.prepare_parameters(required_parameters, args, opts);
      this.set_default_url_options(optional_parts, parameters);
      anchor = this.extract_anchor(parameters);
      trailing_slash = this.extract_trailing_slash(parameters);
      result = "" + (this.get_prefix()) + (this.visit(route, parameters));
      url = Utils.clean_path("" + result);
      if (trailing_slash === true) {
        url = url.replace(/(.*?)[\/]?$/, "$1/");
      }
      if ((url_params = this.serialize(parameters)).length) {
        url += "?" + url_params;
      }
      url += anchor;
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
    build_path_spec: function(route, wildcard) {
      var left, right, type;

      if (wildcard == null) {
        wildcard = false;
      }
      type = route[0], left = route[1], right = route[2];
      switch (type) {
        case NodeTypes.GROUP:
          return "(" + (this.build_path_spec(left)) + ")";
        case NodeTypes.CAT:
          return "" + (this.build_path_spec(left)) + (this.build_path_spec(right));
        case NodeTypes.STAR:
          return this.build_path_spec(left, true);
        case NodeTypes.SYMBOL:
          if (wildcard === true) {
            return "" + (left[0] === '*' ? '' : '*') + left;
          } else {
            return ":" + left;
          }
          break;
        case NodeTypes.SLASH:
        case NodeTypes.DOT:
        case NodeTypes.LITERAL:
          return left;
        default:
          throw new Error("Unknown Rails node type");
      }
    },
    visit_globbing: function(route, parameters, optional) {
      var left, right, type, value;

      type = route[0], left = route[1], right = route[2];
      if (left.replace(/^\*/i, "") !== left) {
        route[1] = left = left.replace(/^\*/i, "");
      }
      value = parameters[left];
      if (value == null) {
        return this.visit(route, parameters, optional);
      }
      parameters[left] = (function() {
        switch (this.get_object_type(value)) {
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
    route: function(required_parts, optional_parts, route_spec) {
      var path_fn;

      path_fn = function() {
        return Utils.build_path(required_parts, optional_parts, route_spec, arguments);
      };
      path_fn.required_params = required_parts;
      path_fn.toString = function() {
        return Utils.build_path_spec(route_spec);
      };
      return path_fn;
    },
    _classToTypeCache: null,
    _classToType: function() {
      var name, _i, _len, _ref;

      if (this._classToTypeCache != null) {
        return this._classToTypeCache;
      }
      this._classToTypeCache = {};
      _ref = "Boolean Number String Function Array Date RegExp Object Error".split(" ");
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        name = _ref[_i];
        this._classToTypeCache["[object " + name + "]"] = name.toLowerCase();
      }
      return this._classToTypeCache;
    },
    get_object_type: function(obj) {
      if (root.jQuery && (root.jQuery.type != null)) {
        return root.jQuery.type(obj);
      }
      if (obj == null) {
        return "" + obj;
      }
      if (typeof obj === "object" || typeof obj === "function") {
        return this._classToType()[Object.prototype.toString.call(obj)] || "object";
      } else {
        return typeof obj;
      }
    }
  };

  createGlobalJsRoutesObject = function() {
    var namespace;

    namespace = function(mainRoot, namespaceString) {
      var current, parts;

      parts = (namespaceString ? namespaceString.split(".") : []);
      if (!parts.length) {
        return;
      }
      current = parts.shift();
      mainRoot[current] = mainRoot[current] || {};
      return namespace(mainRoot[current], parts.join("."));
    };
    namespace(root, "Routes");
    root.Routes = {
// access_denied => /access_denied(.:format)
  // function(options)
  access_denied_path: Utils.route([], ["format"], [2,[2,[7,"/",false],[6,"access_denied",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// admin => /admin/ops/impersonate/:loginid(.:format)
  // function(loginid, options)
  admin_path: Utils.route(["loginid"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"ops",false]],[7,"/",false]],[6,"impersonate",false]],[7,"/",false]],[3,"loginid",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// admin_activity_log => /admin/activity_logs/:id(.:format)
  // function(id, options)
  admin_activity_log_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"activity_logs",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// admin_activity_logs => /admin/activity_logs(.:format)
  // function(options)
  admin_activity_logs_path: Utils.route([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"activity_logs",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// admin_api_key_user => /admin/api_key_users/:id(.:format)
  // function(id, options)
  admin_api_key_user_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"api_key_users",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// admin_api_key_users => /admin/api_key_users(.:format)
  // function(options)
  admin_api_key_users_path: Utils.route([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"api_key_users",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// admin_api_whitelisted_ip_user => /admin/api_whitelisted_ip_users/:id(.:format)
  // function(id, options)
  admin_api_whitelisted_ip_user_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"api_whitelisted_ip_users",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// admin_api_whitelisted_ip_users => /admin/api_whitelisted_ip_users(.:format)
  // function(options)
  admin_api_whitelisted_ip_users_path: Utils.route([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"api_whitelisted_ip_users",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// admin_dialogs_impersonate => /admin/dialogs/impersonate(.:format)
  // function(options)
  admin_dialogs_impersonate_path: Utils.route([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"dialogs",false]],[7,"/",false]],[6,"impersonate",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// admin_dialogs_ip_whitelist => /admin/dialogs/ip_whitelist(.:format)
  // function(options)
  admin_dialogs_ip_whitelist_path: Utils.route([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"dialogs",false]],[7,"/",false]],[6,"ip_whitelist",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// admin_ops_unimpersonate => /admin/ops/unimpersonate(.:format)
  // function(options)
  admin_ops_unimpersonate_path: Utils.route([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"ops",false]],[7,"/",false]],[6,"unimpersonate",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// admin_queued_job => /admin/queued_jobs/:id(.:format)
  // function(id, options)
  admin_queued_job_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"queued_jobs",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// admin_queued_jobs => /admin/queued_jobs(.:format)
  // function(options)
  admin_queued_jobs_path: Utils.route([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"queued_jobs",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// affiliation => /affiliations/:id(.:format)
  // function(id, options)
  affiliation_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"affiliations",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// affiliations => /affiliations(.:format)
  // function(options)
  affiliations_path: Utils.route([], ["format"], [2,[2,[7,"/",false],[6,"affiliations",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// api_application => /api/applications/:id(.:format)
  // function(id, options)
  api_application_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"applications",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// api_applications => /api/applications(.:format)
  // function(options)
  api_applications_path: Utils.route([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"applications",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// api_entities => /api/entities(.:format)
  // function(options)
  api_entities_path: Utils.route([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"entities",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// api_entity => /api/entities/:id(.:format)
  // function(id, options)
  api_entity_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"entities",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// api_people => /api/people(.:format)
  // function(options)
  api_people_path: Utils.route([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"people",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// api_person => /api/people/:id(.:format)
  // function(id, options)
  api_person_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"people",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// api_role => /api/roles/:id(.:format)
  // function(id, options)
  api_role_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"roles",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// api_roles => /api/roles(.:format)
  // function(options)
  api_roles_path: Utils.route([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"roles",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// application => /applications/:id(.:format)
  // function(id, options)
  application_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"applications",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// applications => /applications(.:format)
  // function(options)
  applications_path: Utils.route([], ["format"], [2,[2,[7,"/",false],[6,"applications",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// authorization_rules => /authorization_rules(.:format)
  // function(options)
  authorization_rules_path: Utils.route([], ["format"], [2,[2,[7,"/",false],[6,"authorization_rules",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// authorization_usages => /authorization_usages(.:format)
  // function(options)
  authorization_usages_path: Utils.route([], ["format"], [2,[2,[7,"/",false],[6,"authorization_usages",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// change_authorization_rules => /authorization_rules/change(.:format)
  // function(options)
  change_authorization_rules_path: Utils.route([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"authorization_rules",false]],[7,"/",false]],[6,"change",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// classification => /classifications/:id(.:format)
  // function(id, options)
  classification_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"classifications",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// classifications => /classifications(.:format)
  // function(options)
  classifications_path: Utils.route([], ["format"], [2,[2,[7,"/",false],[6,"classifications",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// edit_admin_activity_log => /admin/activity_logs/:id/edit(.:format)
  // function(id, options)
  edit_admin_activity_log_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"activity_logs",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// edit_admin_api_key_user => /admin/api_key_users/:id/edit(.:format)
  // function(id, options)
  edit_admin_api_key_user_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"api_key_users",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// edit_admin_api_whitelisted_ip_user => /admin/api_whitelisted_ip_users/:id/edit(.:format)
  // function(id, options)
  edit_admin_api_whitelisted_ip_user_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"api_whitelisted_ip_users",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// edit_admin_queued_job => /admin/queued_jobs/:id/edit(.:format)
  // function(id, options)
  edit_admin_queued_job_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"queued_jobs",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// edit_affiliation => /affiliations/:id/edit(.:format)
  // function(id, options)
  edit_affiliation_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"affiliations",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// edit_api_application => /api/applications/:id/edit(.:format)
  // function(id, options)
  edit_api_application_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"applications",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// edit_api_entity => /api/entities/:id/edit(.:format)
  // function(id, options)
  edit_api_entity_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"entities",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// edit_api_person => /api/people/:id/edit(.:format)
  // function(id, options)
  edit_api_person_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"people",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// edit_api_role => /api/roles/:id/edit(.:format)
  // function(id, options)
  edit_api_role_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"roles",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// edit_application => /applications/:id/edit(.:format)
  // function(id, options)
  edit_application_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"applications",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// edit_classification => /classifications/:id/edit(.:format)
  // function(id, options)
  edit_classification_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"classifications",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// edit_entity => /entities/:id/edit(.:format)
  // function(id, options)
  edit_entity_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"entities",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// edit_group => /groups/:id/edit(.:format)
  // function(id, options)
  edit_group_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"groups",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// edit_group_rule => /group_rules/:id/edit(.:format)
  // function(id, options)
  edit_group_rule_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"group_rules",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// edit_major => /majors/:id/edit(.:format)
  // function(id, options)
  edit_major_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"majors",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// edit_organization => /organizations/:id/edit(.:format)
  // function(id, options)
  edit_organization_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"organizations",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// edit_person => /people/:id/edit(.:format)
  // function(id, options)
  edit_person_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"people",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// edit_role => /roles/:id/edit(.:format)
  // function(id, options)
  edit_role_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"roles",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// edit_title => /titles/:id/edit(.:format)
  // function(id, options)
  edit_title_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"titles",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// entities => /entities(.:format)
  // function(options)
  entities_path: Utils.route([], ["format"], [2,[2,[7,"/",false],[6,"entities",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// entity => /entities/:id(.:format)
  // function(id, options)
  entity_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"entities",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// graph_authorization_rules => /authorization_rules/graph(.:format)
  // function(options)
  graph_authorization_rules_path: Utils.route([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"authorization_rules",false]],[7,"/",false]],[6,"graph",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// group => /groups/:id(.:format)
  // function(id, options)
  group_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"groups",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// group_rule => /group_rules/:id(.:format)
  // function(id, options)
  group_rule_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"group_rules",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// group_rules => /group_rules(.:format)
  // function(options)
  group_rules_path: Utils.route([], ["format"], [2,[2,[7,"/",false],[6,"group_rules",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// groups => /groups(.:format)
  // function(options)
  groups_path: Utils.route([], ["format"], [2,[2,[7,"/",false],[6,"groups",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// jasmine_rails.root => /specs/
  // function(options)
  jasmine_rails_root_path: Utils.route([], [], [2,[2,[7,"/",false],[6,"specs",false]],[7,"/",false]], arguments),
// logout => /logout(.:format)
  // function(options)
  logout_path: Utils.route([], ["format"], [2,[2,[7,"/",false],[6,"logout",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// major => /majors/:id(.:format)
  // function(id, options)
  major_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"majors",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// majors => /majors(.:format)
  // function(options)
  majors_path: Utils.route([], ["format"], [2,[2,[7,"/",false],[6,"majors",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// new_admin_activity_log => /admin/activity_logs/new(.:format)
  // function(options)
  new_admin_activity_log_path: Utils.route([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"activity_logs",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// new_admin_api_key_user => /admin/api_key_users/new(.:format)
  // function(options)
  new_admin_api_key_user_path: Utils.route([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"api_key_users",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// new_admin_api_whitelisted_ip_user => /admin/api_whitelisted_ip_users/new(.:format)
  // function(options)
  new_admin_api_whitelisted_ip_user_path: Utils.route([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"api_whitelisted_ip_users",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// new_admin_queued_job => /admin/queued_jobs/new(.:format)
  // function(options)
  new_admin_queued_job_path: Utils.route([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"queued_jobs",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// new_affiliation => /affiliations/new(.:format)
  // function(options)
  new_affiliation_path: Utils.route([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"affiliations",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// new_api_application => /api/applications/new(.:format)
  // function(options)
  new_api_application_path: Utils.route([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"applications",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// new_api_entity => /api/entities/new(.:format)
  // function(options)
  new_api_entity_path: Utils.route([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"entities",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// new_api_person => /api/people/new(.:format)
  // function(options)
  new_api_person_path: Utils.route([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"people",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// new_api_role => /api/roles/new(.:format)
  // function(options)
  new_api_role_path: Utils.route([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"roles",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// new_application => /applications/new(.:format)
  // function(options)
  new_application_path: Utils.route([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"applications",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// new_classification => /classifications/new(.:format)
  // function(options)
  new_classification_path: Utils.route([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"classifications",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// new_entity => /entities/new(.:format)
  // function(options)
  new_entity_path: Utils.route([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"entities",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// new_group => /groups/new(.:format)
  // function(options)
  new_group_path: Utils.route([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"groups",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// new_group_rule => /group_rules/new(.:format)
  // function(options)
  new_group_rule_path: Utils.route([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"group_rules",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// new_major => /majors/new(.:format)
  // function(options)
  new_major_path: Utils.route([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"majors",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// new_organization => /organizations/new(.:format)
  // function(options)
  new_organization_path: Utils.route([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"organizations",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// new_person => /people/new(.:format)
  // function(options)
  new_person_path: Utils.route([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"people",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// new_role => /roles/new(.:format)
  // function(options)
  new_role_path: Utils.route([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"roles",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// new_title => /titles/new(.:format)
  // function(options)
  new_title_path: Utils.route([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"titles",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// organization => /organizations/:id(.:format)
  // function(id, options)
  organization_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"organizations",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// organizations => /organizations(.:format)
  // function(options)
  organizations_path: Utils.route([], ["format"], [2,[2,[7,"/",false],[6,"organizations",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// people => /people(.:format)
  // function(options)
  people_path: Utils.route([], ["format"], [2,[2,[7,"/",false],[6,"people",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// people_search => /people/search/:term(.:format)
  // function(term, options)
  people_search_path: Utils.route(["term"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"people",false]],[7,"/",false]],[6,"search",false]],[7,"/",false]],[3,"term",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// person => /people/:id(.:format)
  // function(id, options)
  person_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"people",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// person_import => /people/import/:loginid(.:format)
  // function(loginid, options)
  person_import_path: Utils.route(["loginid"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"people",false]],[7,"/",false]],[6,"import",false]],[7,"/",false]],[3,"loginid",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// rails_info_properties => /rails/info/properties(.:format)
  // function(options)
  rails_info_properties_path: Utils.route([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"rails",false]],[7,"/",false]],[6,"info",false]],[7,"/",false]],[6,"properties",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// role => /roles/:id(.:format)
  // function(id, options)
  role_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"roles",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// roles => /roles(.:format)
  // function(options)
  roles_path: Utils.route([], ["format"], [2,[2,[7,"/",false],[6,"roles",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// root => /
  // function(options)
  root_path: Utils.route([], [], [7,"/",false], arguments),
// status => /status(.:format)
  // function(options)
  status_path: Utils.route([], ["format"], [2,[2,[7,"/",false],[6,"status",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// suggest_change_authorization_rules => /authorization_rules/suggest_change(.:format)
  // function(options)
  suggest_change_authorization_rules_path: Utils.route([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"authorization_rules",false]],[7,"/",false]],[6,"suggest_change",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// title => /titles/:id(.:format)
  // function(id, options)
  title_path: Utils.route(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"titles",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// titles => /titles(.:format)
  // function(options)
  titles_path: Utils.route([], ["format"], [2,[2,[7,"/",false],[6,"titles",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments),
// welcome => /welcome
  // function(options)
  welcome_path: Utils.route([], [], [2,[7,"/",false],[6,"welcome",false]], arguments)}
;
    root.Routes.options = defaults;
    return root.Routes;
  };

  if (typeof define === "function" && define.amd) {
    define([], function() {
      return createGlobalJsRoutesObject();
    });
  } else {
    createGlobalJsRoutesObject();
  }

}).call(this);
