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

    set_default_format: function(options) {
      if (!options.hasOwnProperty("format")) options.format = defaults.format;
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
        return ((typeof(object.to_param) == "function" && object.to_param()) || object.to_param || object.id || object).toString();
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
      var result = this.clone(options);
      for (var i=0; i < required_parameters.length; i++) {
        result[required_parameters[i]] = actual_parameters[i];
      }
      return result;
    },

    build_path: function(required_parameters, route, args) {
      args = Array.prototype.slice.call(args);
      var opts = this.extract_options(required_parameters.length, args);
      if (args.length > required_parameters.length) {
        throw new Error("Too many parameters provided for path");
      }

      parameters = this.prepare_parameters(required_parameters, args, opts);
      this.set_default_format(parameters);
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
     */
    visit: function(route, options) {
      var type = route[0];
      var left = route[1];
      var right = route[2];
      switch (type) {
        case NodeTypes.GROUP:
          try {
            return this.visit(left, options);
          } catch(e) {
            if (e instanceof ParameterMissing) {
              return "";
            } else {
              throw e;
            }
          }
        case NodeTypes.CAT:
          return this.visit(left, options) + this.visit(right, options);
        case NodeTypes.SYMBOL:
          var value = options[left];
          if (value) {
            delete options[left];
            return this.path_identifier(value); 
          } else {
            //throw new ParameterMissing("Route parameter missing: " + left);
          }
        /*
         * I don't know what are these node types
         * Please send your PR if you do
         */
        //case NodeTypes.OR:
        //case NodeTypes.STAR:
        case NodeTypes.LITERAL:
          return left;
        case NodeTypes.SLASH:
          return left;
        case NodeTypes.DOT:
          return left;
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
    }

  };

  window.Routes = {
// classifications => /classifications(.:format)
  classifications_path: function(options) {
  return Utils.build_path([], [2,[2,[7,"/",false],[6,"classifications",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// new_classification => /classifications/new(.:format)
  new_classification_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"classifications",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// edit_classification => /classifications/:id/edit(.:format)
  edit_classification_path: function(_id, options) {
  return Utils.build_path(["id"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"classifications",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// classification => /classifications/:id(.:format)
  classification_path: function(_id, options) {
  return Utils.build_path(["id"], [2,[2,[2,[2,[7,"/",false],[6,"classifications",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// site_index => /site/index(.:format)
  site_index_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"site",false]],[7,"/",false]],[6,"index",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// site_administrate => /site/administrate(.:format)
  site_administrate_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"site",false]],[7,"/",false]],[6,"administrate",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// site_logout => /site/logout(.:format)
  site_logout_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"site",false]],[7,"/",false]],[6,"logout",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// site_access_denied => /site/access_denied(.:format)
  site_access_denied_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"site",false]],[7,"/",false]],[6,"access_denied",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// admin_dialogs_impersonate => /admin/dialogs/impersonate(.:format)
  admin_dialogs_impersonate_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"dialogs",false]],[7,"/",false]],[6,"impersonate",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// admin => /admin/ops/impersonate/:loginid(.:format)
  admin_path: function(_loginid, options) {
  return Utils.build_path(["loginid"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"ops",false]],[7,"/",false]],[6,"impersonate",false]],[7,"/",false]],[3,"loginid",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// admin_ops_unimpersonate => /admin/ops/unimpersonate(.:format)
  admin_ops_unimpersonate_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"ops",false]],[7,"/",false]],[6,"unimpersonate",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// application_applications => /applications/:application_id/applications(.:format)
  application_applications_path: function(_application_id, options) {
  return Utils.build_path(["application_id"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"applications",false]],[7,"/",false]],[3,"application_id",false]],[7,"/",false]],[6,"applications",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// new_application_application => /applications/:application_id/applications/new(.:format)
  new_application_application_path: function(_application_id, options) {
  return Utils.build_path(["application_id"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"applications",false]],[7,"/",false]],[3,"application_id",false]],[7,"/",false]],[6,"applications",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// edit_application_application => /applications/:application_id/applications/:id/edit(.:format)
  edit_application_application_path: function(_application_id, _id, options) {
  return Utils.build_path(["application_id","id"], [2,[2,[2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"applications",false]],[7,"/",false]],[3,"application_id",false]],[7,"/",false]],[6,"applications",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// application_application => /applications/:application_id/applications/:id(.:format)
  application_application_path: function(_application_id, _id, options) {
  return Utils.build_path(["application_id","id"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"applications",false]],[7,"/",false]],[3,"application_id",false]],[7,"/",false]],[6,"applications",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// applications => /applications(.:format)
  applications_path: function(options) {
  return Utils.build_path([], [2,[2,[7,"/",false],[6,"applications",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// new_application => /applications/new(.:format)
  new_application_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"applications",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// edit_application => /applications/:id/edit(.:format)
  edit_application_path: function(_id, options) {
  return Utils.build_path(["id"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"applications",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// application => /applications/:id(.:format)
  application_path: function(_id, options) {
  return Utils.build_path(["id"], [2,[2,[2,[2,[7,"/",false],[6,"applications",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// templates_assign => /templates/assign(.:format)
  templates_assign_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"templates",false]],[7,"/",false]],[6,"assign",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// templates_unassign => /templates/unassign(.:format)
  templates_unassign_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"templates",false]],[7,"/",false]],[6,"unassign",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// groups => /groups(.:format)
  groups_path: function(options) {
  return Utils.build_path([], [2,[2,[7,"/",false],[6,"groups",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// new_group => /groups/new(.:format)
  new_group_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"groups",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// edit_group => /groups/:id/edit(.:format)
  edit_group_path: function(_id, options) {
  return Utils.build_path(["id"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"groups",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// group => /groups/:id(.:format)
  group_path: function(_id, options) {
  return Utils.build_path(["id"], [2,[2,[2,[2,[7,"/",false],[6,"groups",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// ous => /ous(.:format)
  ous_path: function(options) {
  return Utils.build_path([], [2,[2,[7,"/",false],[6,"ous",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// new_ou => /ous/new(.:format)
  new_ou_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"ous",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// edit_ou => /ous/:id/edit(.:format)
  edit_ou_path: function(_id, options) {
  return Utils.build_path(["id"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"ous",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// ou => /ous/:id(.:format)
  ou_path: function(_id, options) {
  return Utils.build_path(["id"], [2,[2,[2,[2,[7,"/",false],[6,"ous",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// templates => /templates(.:format)
  templates_path: function(options) {
  return Utils.build_path([], [2,[2,[7,"/",false],[6,"templates",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// new_template => /templates/new(.:format)
  new_template_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"templates",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// edit_template => /templates/:id/edit(.:format)
  edit_template_path: function(_id, options) {
  return Utils.build_path(["id"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"templates",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// template => /templates/:id(.:format)
  template_path: function(_id, options) {
  return Utils.build_path(["id"], [2,[2,[2,[2,[7,"/",false],[6,"templates",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// people => /people(.:format)
  people_path: function(options) {
  return Utils.build_path([], [2,[2,[7,"/",false],[6,"people",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// new_person => /people/new(.:format)
  new_person_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"people",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// edit_person => /people/:id/edit(.:format)
  edit_person_path: function(_id, options) {
  return Utils.build_path(["id"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"people",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// person => /people/:id(.:format)
  person_path: function(_id, options) {
  return Utils.build_path(["id"], [2,[2,[2,[2,[7,"/",false],[6,"people",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// root => /
  root_path: function(options) {
  return Utils.build_path([], [7,"/",false], arguments)
  },
// api_person_applications => /api/people/:person_id/applications(.:format)
  api_person_applications_path: function(_person_id, options) {
  return Utils.build_path(["person_id"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"people",false]],[7,"/",false]],[3,"person_id",false]],[7,"/",false]],[6,"applications",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// new_api_person_application => /api/people/:person_id/applications/new(.:format)
  new_api_person_application_path: function(_person_id, options) {
  return Utils.build_path(["person_id"], [2,[2,[2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"people",false]],[7,"/",false]],[3,"person_id",false]],[7,"/",false]],[6,"applications",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// edit_api_person_application => /api/people/:person_id/applications/:id/edit(.:format)
  edit_api_person_application_path: function(_person_id, _id, options) {
  return Utils.build_path(["person_id","id"], [2,[2,[2,[2,[2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"people",false]],[7,"/",false]],[3,"person_id",false]],[7,"/",false]],[6,"applications",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// api_person_application => /api/people/:person_id/applications/:id(.:format)
  api_person_application_path: function(_person_id, _id, options) {
  return Utils.build_path(["person_id","id"], [2,[2,[2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"people",false]],[7,"/",false]],[3,"person_id",false]],[7,"/",false]],[6,"applications",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// api_person_exists => /api/people/:person_id/exists(.:format)
  api_person_exists_path: function(_person_id, options) {
  return Utils.build_path(["person_id"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"people",false]],[7,"/",false]],[3,"person_id",false]],[7,"/",false]],[6,"exists",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// api_people => /api/people(.:format)
  api_people_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"people",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// new_api_person => /api/people/new(.:format)
  new_api_person_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"people",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// edit_api_person => /api/people/:id/edit(.:format)
  edit_api_person_path: function(_id, options) {
  return Utils.build_path(["id"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"people",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// api_person => /api/people/:id(.:format)
  api_person_path: function(_id, options) {
  return Utils.build_path(["id"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"people",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// api_groups => /api/groups(.:format)
  api_groups_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"groups",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// new_api_group => /api/groups/new(.:format)
  new_api_group_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"groups",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// edit_api_group => /api/groups/:id/edit(.:format)
  edit_api_group_path: function(_id, options) {
  return Utils.build_path(["id"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"groups",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// api_group => /api/groups/:id(.:format)
  api_group_path: function(_id, options) {
  return Utils.build_path(["id"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"groups",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// api_ous => /api/ous(.:format)
  api_ous_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"ous",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// new_api_ou => /api/ous/new(.:format)
  new_api_ou_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"ous",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// edit_api_ou => /api/ous/:id/edit(.:format)
  edit_api_ou_path: function(_id, options) {
  return Utils.build_path(["id"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"ous",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// api_ou => /api/ous/:id(.:format)
  api_ou_path: function(_id, options) {
  return Utils.build_path(["id"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"ous",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// api_classifications => /api/classifications(.:format)
  api_classifications_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"classifications",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// new_api_classification => /api/classifications/new(.:format)
  new_api_classification_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"classifications",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// edit_api_classification => /api/classifications/:id/edit(.:format)
  edit_api_classification_path: function(_id, options) {
  return Utils.build_path(["id"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"classifications",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// api_classification => /api/classifications/:id(.:format)
  api_classification_path: function(_id, options) {
  return Utils.build_path(["id"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"classifications",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// api_titles => /api/titles(.:format)
  api_titles_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"titles",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// new_api_title => /api/titles/new(.:format)
  new_api_title_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"titles",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// edit_api_title => /api/titles/:id/edit(.:format)
  edit_api_title_path: function(_id, options) {
  return Utils.build_path(["id"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"titles",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// api_title => /api/titles/:id(.:format)
  api_title_path: function(_id, options) {
  return Utils.build_path(["id"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"titles",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// api_application_roles => /api/applications/:application_id/roles(.:format)
  api_application_roles_path: function(_application_id, options) {
  return Utils.build_path(["application_id"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"applications",false]],[7,"/",false]],[3,"application_id",false]],[7,"/",false]],[6,"roles",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// new_api_application_role => /api/applications/:application_id/roles/new(.:format)
  new_api_application_role_path: function(_application_id, options) {
  return Utils.build_path(["application_id"], [2,[2,[2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"applications",false]],[7,"/",false]],[3,"application_id",false]],[7,"/",false]],[6,"roles",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// edit_api_application_role => /api/applications/:application_id/roles/:id/edit(.:format)
  edit_api_application_role_path: function(_application_id, _id, options) {
  return Utils.build_path(["application_id","id"], [2,[2,[2,[2,[2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"applications",false]],[7,"/",false]],[3,"application_id",false]],[7,"/",false]],[6,"roles",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// api_application_role => /api/applications/:application_id/roles/:id(.:format)
  api_application_role_path: function(_application_id, _id, options) {
  return Utils.build_path(["application_id","id"], [2,[2,[2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"applications",false]],[7,"/",false]],[3,"application_id",false]],[7,"/",false]],[6,"roles",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// api_applications => /api/applications(.:format)
  api_applications_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"applications",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// new_api_application => /api/applications/new(.:format)
  new_api_application_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"applications",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// edit_api_application => /api/applications/:id/edit(.:format)
  edit_api_application_path: function(_id, options) {
  return Utils.build_path(["id"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"applications",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// api_application => /api/applications/:id(.:format)
  api_application_path: function(_id, options) {
  return Utils.build_path(["id"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"applications",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// api_search => /api/search(.:format)
  api_search_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"search",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// api_resolve => /api/resolve(.:format)
  api_resolve_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"resolve",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// api_org_chart => /api/org_chart(.:format)
  api_org_chart_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"org_chart",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// api_loginid => /api/loginid(.:format)
  api_loginid_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"loginid",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// api_major => /api/major(.:format)
  api_major_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"major",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// api_affiliation => /api/affiliation(.:format)
  api_affiliation_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"api",false]],[7,"/",false]],[6,"affiliation",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// roles_assign => /roles/assign(.:format)
  roles_assign_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"roles",false]],[7,"/",false]],[6,"assign",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// roles_unassign => /roles/unassign(.:format)
  roles_unassign_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"roles",false]],[7,"/",false]],[6,"unassign",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// graph_authorization_rules => /authorization_rules/graph(.:format)
  graph_authorization_rules_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"authorization_rules",false]],[7,"/",false]],[6,"graph",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// change_authorization_rules => /authorization_rules/change(.:format)
  change_authorization_rules_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"authorization_rules",false]],[7,"/",false]],[6,"change",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// suggest_change_authorization_rules => /authorization_rules/suggest_change(.:format)
  suggest_change_authorization_rules_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[7,"/",false],[6,"authorization_rules",false]],[7,"/",false]],[6,"suggest_change",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// authorization_rules => /authorization_rules(.:format)
  authorization_rules_path: function(options) {
  return Utils.build_path([], [2,[2,[7,"/",false],[6,"authorization_rules",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// authorization_usages => /authorization_usages(.:format)
  authorization_usages_path: function(options) {
  return Utils.build_path([], [2,[2,[7,"/",false],[6,"authorization_usages",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  },
// rails_info_properties => /rails/info/properties(.:format)
  rails_info_properties_path: function(options) {
  return Utils.build_path([], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"rails",false]],[7,"/",false]],[6,"info",false]],[7,"/",false]],[6,"properties",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments)
  }}
;
  window.Routes.options = defaults;
})();
