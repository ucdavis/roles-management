namespace :ldap do
  load 'LdapHelper.rb'
  load 'LdapPersonHelper.rb'
  
  desc 'Runs the LDAP import. Takes approx. 5-10 mins.'
  task :import, [:loginid] => :environment do |t, args|
    require 'stringio'

    notify_admins = false

    Authorization.ignore_access_control(true)

    # Keep a log to e-mail to the admins
    strio = StringIO.new
    log = ActiveSupport::TaggedLogging.new(Logger.new(strio))
    
    log.tagged "ldap:import" do
      # Include the large lot of UCD info (dept codes, title codes, etc.)
      load 'UcdLookups.rb'

      timestamp_start = Time.now

      # Keep a list of untouched login IDs - we'll remove items from this list as we sync.
      # If at the end of our sync we failed to query LDAP for a user, we can manually query
      # them by their login IDs.
      # This happens to a small minority of users who aren't caught by the original LDAP query
      # design but were added to RM anyway (via AD sync, manual add, etc.)
      untouched_loginids = Person.all.map{ |x| x.loginid }

      #
      # STEP ONE: Connect to LDAP. Query needed data.
      #
      ldap = LdapHelper.new
      ldap.connect

      log.info "Connected to ldap.ucdavis.edu on port 636, LDAP protocol version 3."

      people = {}
      filters = []

      # If they specified a loginid, only import them, otherwise, do everybody
      unless args[:loginid].nil?
        # Specified a loginid
        manualFilter = []
        manualFilter << '(uid=' + args[:loginid] + ')'

        log.info "Will use query: " + manualFilter.join(",")

        filters = manualFilter
      else
        # Did not specify a loginid - import everyone

        # Build needed LDAP filters
        # Staff filter
        staffFilter = '(&(ucdPersonAffiliation=staff*)(|'
        for d in UcdLookups::DEPT_CODES.keys()
          staffFilter = staffFilter + '(ucdAppointmentDepartmentCode=' + d + ')'
        end
        staffFilter = staffFilter + '))'

        log.info "Will use query: " + staffFilter

        # Faculty filter
        facultyFilter = '(&(ucdPersonAffiliation=faculty*)(|'
        for d in UcdLookups::DEPT_CODES.keys()
            facultyFilter = facultyFilter + '(ucdAppointmentDepartmentCode=' + d + ')'
        end
        facultyFilter = facultyFilter + '))'

        log.info "Will use query: " + facultyFilter

        # Student filter
        studentFilter = '(&(ucdPersonAffiliation=student:graduate)(|'
        for m in UcdLookups::MAJORS.keys()
             studentFilter = studentFilter + '(ucdStudentMajor=' + m + ')'
        end
        studentFilter = studentFilter + '))'

        log.info "Will use query: " + studentFilter

        # Manual filter
        manualFilter = []
        for m in UcdLookups::MANUAL_INCLUDES
          manualFilter << '(uid=' + m + ')'
        end

        log.info "Will use query: " + manualFilter.join(",")

        filters = [staffFilter,facultyFilter,studentFilter] + manualFilter
      end

      num_results = 0

      # Query LDAP
      Person.transaction do
        for f in filters
          unless f.length == 0
            ldap.search(f) do |entry|
              p = LdapPersonHelper.create_or_update_person_from_ldap(entry, log)

              # Remove the login ID from the untouched list (see explanation above)
              # Even if the record is invalid, keeping them on the list only means
              # we're going to attempt this again, so there's no use in keeping them around.
              # We've effectively dealt with their record as best we can.
              untouched_loginids.delete p.loginid unless p.nil?

              log_and_save_if_needed(p, log)
              
              num_results += 1
            end
          end
        end
        
        log.info "No LDAP results were found." unless num_results > 0

        # Process the list of untouched_loginids (local users who weren't noticed by our original LDAP query).
        # Only do this if we weren't in 'single' import mode
        if args[:loginid].nil?
          log.info "Processing #{untouched_loginids.length} additional login IDs existing locally but not found in the above LDAP queries."
          untouched_loginids.each do |loginid|
            ldap.search('(uid=' + loginid + ')') do |entry|
              p = LdapPersonHelper.create_or_update_person_from_ldap(entry, log)
              log_and_save_if_needed(p, log)
            end
          end
        end
      end

      # Disconnect
      ldap.disconnect

      timestamp_finish = Time.now

      log.info "Finished LDAP import. Time elapsed: " + (timestamp_finish - timestamp_start).to_s + " seconds"
    end

    # Email the log
    # E-mail to each RM admin (anyone with 'admin' permission on this app)
    if notify_admins
      admin_role_id = rm_roles.find(:first, :conditions => [ "lower(token) = 'admin'" ]).id
      Role.find_by_id(admin_role_id).entities.each do |admin|
        WheneverMailer.ldap_report(admin.email, strio.string).deliver!
      end
    end

    Rails.logger.info strio.string

    Authorization.ignore_access_control(false)
  end

  desc 'Erases any data that might be introduced by LDAP. Be very careful and back up your database!'
  task :erase => :environment do
    if Rails.env != "production"
      Authorization.ignore_access_control(true)

      Person.destroy_all
      Group.destroy_all
      RoleAssignment.destroy_all
      Affiliation.destroy_all
      GroupRule.delete_all
      AffiliationAssignment.destroy_all
      PersonManagerAssignment.destroy_all
      Classification.destroy_all
      Title.destroy_all
      ApplicationOwnerAssignment.destroy_all
      GroupOperatorAssignment.destroy_all
      GroupOwnerAssignment.destroy_all
      Student.destroy_all

      Authorization.ignore_access_control(false)

      puts "Be sure to assign roles if you re-import the directory."
    else
      puts "This task is purposefully disabled in production mode."
    end
  end

  def log_and_save_if_needed(p, log)
    if (p == nil) or (p.valid? == false)
      if p
        log.warn "Unable to create or update persion with loginid #{p.loginid}. Reason(s): "
        p.errors.messages.each do |field,reason|
          log.warn "\tField #{field} #{reason}"
        end
      end
    else
      if p.changed? == false
        log.info "No standard record changes for #{p.loginid}"
      else
        log.info "Updating the following for #{p.loginid}:"
        p.changes.each do |field,changes|
          log.info "\t#{field}: #{changes[0]} -> #{changes[1]}"
        end
      end
      p.save!

      if p.student
        if p.student.changed? == false
          log.info "Student record exists but there are no changes for #{p.loginid}"
        else
          log.info "Updating the following student records for #{p.loginid}:"
          p.student.changes.each do |field,changes|
            log.info "\t#{field}: #{changes[0]} -> #{changes[1]}"
          end
        end
        p.student.save!
      end
    end
  end
end
