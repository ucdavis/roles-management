DssRm.Models.ApiKey = Backbone.Model.extend({})

DssRm.Collections.ApiKeys = Backbone.Collection.extend(
  model: DssRm.Models.ApiKey
  url: Routes.admin_api_key_users_path()
)
