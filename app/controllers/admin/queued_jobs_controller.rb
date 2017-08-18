class Admin::QueuedJobsController < Admin::BaseController
  before_action :load_queued_jobs, only: :index

  def index
    authorize :queued_jobs, :index?

    respond_to do |format|
      format.json { render json: @queued_jobs }
    end
  end

  private

    def load_queued_jobs
        # Load all jobs enqueued by DelayedJob gem
        @queued_jobs = []
        Delayed::Job.where('').each do |job|
        match = job.handler.match('ad:sync_role\[(?<id>[0-9]+)\]')
        if match
            # Job is 'Role Sync'
            role = Role.find_by_id(match[:id])
            @queued_jobs << { id: job.id, task: 'Role Sync', description: "Role ID #{match[:id]}, '#{role.token}' for '#{role.application.name}'", run_at: job.run_at } if role
        end
        end
    end
end
