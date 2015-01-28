# Sync subsystem. Person, Role and other classes call trigger methods
# like Sync.person_add_to_role() to indicate such an event has happened
# and this module takes care of calling the sync scripts.
module Sync
  # Used in a testing environment to count how many times each trigger
  # is called. Not used in development or production modes.
  @@trigger_test_counts = Hash.new(0)

  # For testing: Returns the number of times sync_mode has been triggered
  def Sync.trigger_test_count(sync_mode)
    @@trigger_test_counts[sync_mode]
  end

  # For testing: Resets all trigger counts
  def Sync.reset_trigger_test_counts
    @@trigger_test_counts = Hash.new(0)
  end

  # Triggered whenever somebody is added to a role.
  # If a group is added to a role, this will be called on each group member
  # individually.
  def Sync.person_added_to_role(person_id, role_id)
    job_uuid = SecureRandom.uuid

    Sync.logger.info "#{job_uuid}: Sync will add Person ##{person_id} to Role ##{role_id}"

    if Rails.env == "test"
      @@trigger_test_counts[:add_to_role] += 1
    else
      perform_sync(:add_to_role, job_uuid, person_id, { role: get_role_sync_obj(role_id) })
    end
  end

  # Triggered whenever somebody is removed from a role.
  # If a group is removed from a role, this will be called on each group member
  # individually.
  def Sync.person_removed_from_role(person_id, role_id)
    job_uuid = SecureRandom.uuid

    Sync.logger.info "#{job_uuid}: Sync will remove Person ##{person_id} from Role ##{role_id}"

    if Rails.env == "test"
      @@trigger_test_counts[:remove_from_role] += 1
    else
      perform_sync(:remove_from_role, job_uuid, person_id, { role: get_role_sync_obj(role_id) })
    end
  end

  # Triggered when a new person is added to the system. Should they be granted
  # roles as well, person_added_to_role() will be called separately.
  def Sync.person_added_to_system(person_id)
    job_uuid = SecureRandom.uuid

    Sync.logger.info "#{job_uuid}: Sync will add Person ##{person_id} to system"

    if Rails.env == "test"
      @@trigger_test_counts[:add_to_system] += 1
    else
      perform_sync(:add_to_system, job_uuid, person_id)
    end
  end

  # Triggered when a person is removed from the system. Should they have roles
  # to be removed, person_removed_from_role() will be called separately.
  def Sync.person_removed_from_system(person_id)
    job_uuid = SecureRandom.uuid

    Sync.logger.info "#{job_uuid}: Sync will remove Person ##{person_id} from system"

    if Rails.env == "test"
      @@trigger_test_counts[:remove_from_system] += 1
    else
      perform_sync(:remove_from_system, job_uuid, person_id)
    end
  end

  # Triggered when a person is activated.
  # Note: They are active by default and this callback will not be called
  #       (use person_added_to_system() to capture that case). This will
  #       only be called if they are deactivated and then reactivated.
  def Sync.person_activated(person_id)
    job_uuid = SecureRandom.uuid

    Sync.logger.info "#{job_uuid}: Sync will activate Person ##{person_id}"

    if Rails.env == "test"
      @@trigger_test_counts[:activate_person] += 1
    else
      perform_sync(:activate_person, job_uuid, person_id)
    end
  end

  # Triggered when a person is deactivated.
  def Sync.person_deactivated(person_id)
    job_uuid = SecureRandom.uuid

    Sync.logger.info "#{job_uuid}: Sync will deactivate Person ##{person_id}"

    if Rails.env == "test"
      @@trigger_test_counts[:deactivate_person] += 1
    else
      perform_sync(:deactivate_person, job_uuid, person_id)
    end
  end

  def Sync.logger
    @@sync_logger ||= ActiveSupport::TaggedLogging.new(Logger.new("#{Rails.root.join('log', 'sync.log')}"))
  end

  module_function

  def perform_sync(sync_mode, job_uuid, person_id, opts = {})
    require 'json'

    Sync.logger.info "#{job_uuid}: Queueing all sync scripts at #{Time.now}."

    sync_json = JSON.generate(
      {
        config_path: Rails.root.join('sync', 'config').to_s,
        mode: sync_mode,
        person: get_person_sync_obj(person_id)
      }.merge(opts)
    )

    # Keep some statistics for the log
    sync_successes = 0
    sync_failures = 0

    sync_scripts.each do |sync_script|
      Delayed::Job.enqueue SyncScriptJob.new(job_uuid, sync_script, sync_json), :queue => 'sync'
    end

    Sync.logger.info "#{job_uuid}: Finished queueing sync scripts at #{Time.now}."
  end
  handle_asynchronously :perform_sync, :queue => 'sync'

  def get_person_sync_obj(person_id)
    p = Person.find_by_id(person_id)
    if p == nil
      Sync.logger.error("Sync was asked to find person with ID #{person_id} but they do not exist.")
      return nil
    end

    { id: p.id, name: p.name, loginid: p.loginid, email: p.email }
  end

  def get_role_sync_obj(role_id)
    r = Role.find_by_id(role_id)
    if r == nil
      Sync.logger.error("Sync was asked to find role ID #{role_id} but it does not exist.")
      return nil
    end

    { id: r.id, token: r.token, ad_path: r.ad_path, ad_guid: r.ad_guid, application_id: r.application.id, application_name: r.application.name }
  end

  def sync_scripts
    Dir[Rails.root.join("sync", "*")].select{ |f| File.file?(f) }
  end
end
