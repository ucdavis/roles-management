class Admin::QueuedJobsController < ApplicationController
  filter_access_to :all, :attribute_check => true
  filter_access_to :index, :attribute_check => true, :load_method => :load_queued_jobs
  respond_to :json

  def index
    respond_with @queued_jobs
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
