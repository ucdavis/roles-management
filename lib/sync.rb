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

    if Rails.env.test?
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

    if Rails.env.test?
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

    if Rails.env.test?
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

    if Rails.env.test?
      @@trigger_test_counts[:remove_from_system] += 1
    else
      perform_sync(:remove_from_system, job_uuid, person_obj)
    end
  end

  # Triggered when a person is added to an organization.
  def Sync.person_added_to_organization(person_obj, organization_obj)
    job_uuid = SecureRandom.uuid

    Sync.logger.info "#{job_uuid}: Sync will add Person ##{person_obj[:id]} (#{person_obj[:name]}) to Organization ##{organization_obj[:id]} (#{organization_obj[:name]})"

    if Rails.env.test?
      @@trigger_test_counts[:add_to_organization] += 1
    else
      perform_sync(:add_to_organization, job_uuid, person_obj, { organization: organization_obj })
    end
  end

  # Triggered when a person is removed from an organization.
  def Sync.person_removed_from_organization(person_obj, organization_obj)
    job_uuid = SecureRandom.uuid

    Sync.logger.info "#{job_uuid}: Sync will remove Person ##{person_obj[:id]} (#{person_obj[:name]}) from Organization ##{organization_obj[:id]} (#{organization_obj[:name]})"

    if Rails.env.test?
      @@trigger_test_counts[:remove_from_organization] += 1
    else
      perform_sync(:remove_from_organization, job_uuid, person_obj, { organization: organization_obj })
    end
  end

  # Triggered when a role has one or more attribute(s) changed.
  # This is not triggered for role assignment / unassignment.
  def Sync.role_changed(role_obj)
    job_uuid = SecureRandom.uuid

    Sync.logger.info "#{job_uuid}: Sync will respond to role attribute change(s) for Role ##{role_obj[:id]} (#{role_obj[:application_name]}, #{role_obj[:token]})"

    if Rails.env.test?
      @@trigger_test_counts[:role_change] += 1
    else
      perform_sync(:role_change, job_uuid, role_obj)
    end
  end

  # Triggered to audit a role.
  # This is typically triggered by the 'sync_recently_touched_groups' task.
  def Sync.role_audit(role_obj)
    job_uuid = SecureRandom.uuid

    Sync.logger.info "#{job_uuid}: Sync will respond to role audit request for Role ##{role_obj[:id]} (#{role_obj[:application_name]}, #{role_obj[:token]})"

    if Rails.env.test?
      @@trigger_test_counts[:role_audit] += 1
    else
      perform_sync(:role_audit, job_uuid, role_obj)
    end
  end

  # Encodes a Person or Role object into a flattened JSON object to be passed
  # into the sync system. This allows the sync system to avoid using the database
  # when a job runs potentially much later in time when the original object
  # may no longer be in the database (such as when deleting a person or role).
  # We have Sync encode the object even though it is called in the Person and
  # Role class because we would like to control the format of the data in Sync
  # where it matters most.
  def Sync.encode(obj, detailed = false)
    case obj
    when Role
      if detailed
        return { id: obj.id, token: obj.token, role_name: obj.name, ad_path: obj.ad_path, ad_guid: obj.ad_guid,
                 application_id: obj.application.id, application_name: obj.application.name,
                 members: obj.members.select { |m| m.active == true }.map(&:loginid) }
      else
        return { id: obj.id, token: obj.token, role_name: obj.name, ad_path: obj.ad_path, ad_guid: obj.ad_guid,
                 application_id: obj.application.id, application_name: obj.application.name }
      end
    when Person
      return { id: obj.id, name: obj.name, first: obj.first, last: obj.last, loginid: obj.loginid,
               email: obj.email, address: obj.address, phone: obj.phone,
               affiliations: obj.affiliations.map(&:name) }
    end

    return nil # rubocop:disable Style/RedundantReturn
  end

  def Sync.logger
    unless defined?(@@sync_logger)
      logger = Logger.new(Rails.root.join('log', 'sync.log').to_s)
      logger.level = Logger::DEBUG
      logger.datetime_format = '%Y-%m-%d %H:%M:%S'
      logger = ActiveSupport::TaggedLogging.new(logger)
      logger.formatter = Logger::Formatter.new
    end
    @@sync_logger ||= logger
  end

  module_function

  def perform_sync(sync_mode, job_uuid, sync_obj, opts = {})
    require 'json'

    sync_json = {
      config_path: Rails.root.join('sync', 'config').to_s,
      mode: sync_mode,
      requested_at: DateTime.now # rubocop:disable Style/DateTime
    }.merge(opts)

    if (sync_mode == :role_change) || (sync_mode == :role_audit)
      sync_json[:role] = sync_obj
    else
      sync_json[:person] = sync_obj
    end

    sync_json = JSON.generate(sync_json)

    Sync.logger.info "#{job_uuid}: Queueing sync scripts at #{Time.now}."

    sync_scripts.each do |sync_script|
      Delayed::Job.enqueue SyncScriptJob.new(job_uuid, sync_script, sync_json), queue: 'sync'
    end
  end

  def sync_scripts
    if Rails.env.development? && false
      # In development mode, only run the test script (simply prints job details to STDOUT).
      # This is to avoid accidentally modifying Active Directory, SysAid, etc.
      Dir[Rails.root.join('sync', 'test.rb')]
    else
      Dir[Rails.root.join('sync', '*')].select { |f| File.file?(f) }
    end
  end
end
