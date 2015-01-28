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
  def Sync.person_added_to_role(person_obj, role_obj)
    job_uuid = SecureRandom.uuid

    Sync.logger.info "#{job_uuid}: Sync will add Person ##{person_obj[:id]} (#{person_obj[:name]}) to Role ##{role_obj[:id]} (#{role_obj[:application_name]}, #{role_obj[:token]})"

    if Rails.env == "test"
      @@trigger_test_counts[:add_to_role] += 1
    else
      perform_sync(:add_to_role, job_uuid, person_obj, { role: role_obj })
    end
  end

  # Triggered whenever somebody is removed from a role.
  # If a group is removed from a role, this will be called on each group member
  # individually.
  def Sync.person_removed_from_role(person_obj, role_obj)
    job_uuid = SecureRandom.uuid

    Sync.logger.info "#{job_uuid}: Sync will remove Person ##{person_obj[:id]} (#{person_obj[:name]}) from Role ##{role_obj[:id]} (#{role_obj[:application_name]}, #{role_obj[:token]})"

    if Rails.env == "test"
      @@trigger_test_counts[:remove_from_role] += 1
    else
      perform_sync(:remove_from_role, job_uuid, person_obj, { role: role_obj })
    end
  end

  # Triggered when a new person is added to the system. Should they be granted
  # roles as well, person_added_to_role() will be called separately.
  def Sync.person_added_to_system(person_obj)
    job_uuid = SecureRandom.uuid

    Sync.logger.info "#{job_uuid}: Sync will add Person ##{person_obj[:id]} (#{person_obj[:name]}) to system"

    if Rails.env == "test"
      @@trigger_test_counts[:add_to_system] += 1
    else
      perform_sync(:add_to_system, job_uuid, person_obj)
    end
  end

  # Triggered when a person is removed from the system. Should they have roles
  # to be removed, person_removed_from_role() will be called separately.
  def Sync.person_removed_from_system(person_obj)
    job_uuid = SecureRandom.uuid

    Sync.logger.info "#{job_uuid}: Sync will remove Person ##{person_obj[:id]} (#{person_obj[:name]}) from system"

    if Rails.env == "test"
      @@trigger_test_counts[:remove_from_system] += 1
    else
      perform_sync(:remove_from_system, job_uuid, person_obj)
    end
  end

  # Triggered when a person is activated.
  # Note: They are active by default and this callback will not be called
  #       (use person_added_to_system() to capture that case). This will
  #       only be called if they are deactivated and then reactivated.
  def Sync.person_activated(person_obj)
    job_uuid = SecureRandom.uuid

    Sync.logger.info "#{job_uuid}: Sync will activate Person ##{person_obj[:id]} (#{person_obj[:name]})"

    if Rails.env == "test"
      @@trigger_test_counts[:activate_person] += 1
    else
      perform_sync(:activate_person, job_uuid, person_obj)
    end
  end

  # Triggered when a person is deactivated.
  def Sync.person_deactivated(person_obj)
    job_uuid = SecureRandom.uuid

    Sync.logger.info "#{job_uuid}: Sync will deactivate Person ##{person_obj[:id]} (#{person_obj[:name]})"

    if Rails.env == "test"
      @@trigger_test_counts[:deactivate_person] += 1
    else
      perform_sync(:deactivate_person, job_uuid, person_obj)
    end
  end

  # Encodes a Person or Role object into a flattened JSON object to be passed
  # into the sync system. This allows the sync system to avoid using the database
  # when a job runs potentially much later in time when the original object
  # may no longer be in the database (such as when deleting a person or role).
  # We have Sync encode the object even though it is called in the Person and
  # Role class because we would like to control the format of the data in Sync
  # where it matters most.
  def Sync.encode(obj)
    case obj
    when Role
      return { id: obj.id, token: obj.token, ad_path: obj.ad_path, ad_guid: obj.ad_guid, application_id: obj.application.id, application_name: obj.application.name }
    when Person
      return { id: obj.id, name: obj.name, loginid: obj.loginid, email: obj.email }
    end

    return nil
  end

  def Sync.logger
    @@sync_logger ||= ActiveSupport::TaggedLogging.new(Logger.new("#{Rails.root.join('log', 'sync.log')}"))
  end

  module_function

  def perform_sync(sync_mode, job_uuid, person_obj, opts = {})
    require 'json'

    Sync.logger.info "#{job_uuid}: Queueing sync scripts at #{Time.now}."

    sync_json = JSON.generate(
      {
        config_path: Rails.root.join('sync', 'config').to_s,
        mode: sync_mode,
        person: person_obj
      }.merge(opts)
    )

    sync_scripts.each do |sync_script|
      Delayed::Job.enqueue SyncScriptJob.new(job_uuid, sync_script, sync_json), :queue => 'sync'
    end
  end
  handle_asynchronously :perform_sync, :queue => 'sync'

  def sync_scripts
    Dir[Rails.root.join("sync", "*")].select{ |f| File.file?(f) }
  end
end
