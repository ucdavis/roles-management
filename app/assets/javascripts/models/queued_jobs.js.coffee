DssRm.Models.QueuedJob = Backbone.Model.extend({})

DssRm.Collections.QueuedJobs = Backbone.Collection.extend(
  model: DssRm.Models.QueuedJob
  url: Routes.admin_queued_jobs_path()
)
