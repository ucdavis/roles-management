DssRm.Models.TrackedItem = Backbone.Model.extend({})

DssRm.Collections.TrackedItems = Backbone.Collection.extend(
  model: DssRm.Models.TrackedItem
  url: Routes.admin_tracked_items_path()
)
