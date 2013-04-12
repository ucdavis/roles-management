DssRm.Collections.WhitelistedIPs = Backbone.Collection.extend(
  model: DssRm.Models.WhitelistedIP
  url: Routes.admin_api_whitelisted_ip_users_path()
)