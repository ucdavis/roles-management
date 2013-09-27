namespace :ldap do
  require 'LdapHelper'
  require 'LdapPersonHelper'
  
  desc 'Runs the LDAP import. Takes approx. 5-10 mins.'
  task :import, [:loginid] => :environment do |t, args|
    require 'stringio'
    require 'os'

    notify_admins = false

    Authorization.ignore_access_control(true)

    # Keep a log to e-mail to the admins
    strio = StringIO.new
    log = ActiveSupport::TaggedLogging.new(Logger.new(strio))
    
    log.tagged "ldap:import" do
      # Include the large lot of UCD info (dept codes, title codes, etc.)
      require 'UcdLookups'

      timestamp_start = Time.now

      #
      # STEP ONE: Connect to LDAP. Query needed data.
      #
      ldap = LdapHelper.new
      ldap.connect

      log.debug "Connected to ldap.ucdavis.edu on port 636, LDAP protocol version 3."

      filters = []

      # If they specified a loginid, only import them, otherwise, do everybody
      unless args[:loginid].nil?
        # Specified a loginid
        manualFilter = []
        manualFilter << '(uid=' + args[:loginid] + ')'

        log.debug "Will use query: " + manualFilter.join(",")

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

        log.debug "Will use query: " + staffFilter

        # Faculty filter
        facultyFilter = '(&(ucdPersonAffiliation=faculty*)(|'
        for d in UcdLookups::DEPT_CODES.keys()
            facultyFilter = facultyFilter + '(ucdAppointmentDepartmentCode=' + d + ')'
        end
        facultyFilter = facultyFilter + '))'

        log.debug "Will use query: " + facultyFilter

        # Student filter
        studentFilter = '(&(ucdPersonAffiliation=student:graduate)(|'
        for m in UcdLookups::MAJORS.keys()
             studentFilter = studentFilter + '(ucdStudentMajor=' + m + ')'
        end
        studentFilter = studentFilter + '))'

        log.debug "Will use query: " + studentFilter

        # Manual filter
        manualFilter = []
        for m in UcdLookups::MANUAL_INCLUDES
          manualFilter << '(uid=' + m + ')'
        end

        log.debug "Will use query: " + manualFilter.join(",")

        filters = [staffFilter,facultyFilter,studentFilter] + manualFilter
      end

      num_results = 0

      # Query LDAP
      Person.transaction do
        for f in filters
          unless f.length == 0
            ldap.search(f) do |entry|
              p = LdapPersonHelper.create_or_update_person_from_ldap(entry, log)

              save_or_touch(p, log) if p
              
              num_results += 1
              
              p = nil
            end
          end
        end
        
        log.debug "No LDAP results were found." unless num_results > 0

        # Process the list of untouched_loginids (local users who weren't noticed by our original LDAP query).
        # Only do this if we weren't in 'single' import mode
        if args[:loginid].nil?
          log.debug "Processing additional login IDs existing locally but not found in the standard LDAP queries."
          
          Person.find(:all, :conditions => ["updated_at < ?", timestamp_start]).each do |person|
            p = nil
            
            ldap.search('(uid=' + person.loginid + ')') do |entry|
              p = LdapPersonHelper.create_or_update_person_from_ldap(entry, log)
              save_or_touch(p, log)
            end
            
            unless p
              log.debug "Person with login ID '#{person.loginid}' not found in LDAP, disabling ..."
              person.status = false
              person.save!
            end
          end
        end
      end

      # Disconnect
      ldap.disconnect

      timestamp_finish = Time.now

      log.info "Completed LDAP import. Took " + (timestamp_finish - timestamp_start).to_s + "s. Used #{OS.rss_bytes} KB at the end of the task (varies during operation but generally grows)."
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

  def save_or_touch(p, log)
    if p.valid? == false
      log.warn "Unable to create or update persion with loginid #{p.loginid}. Reason(s): "
      p.errors.messages.each do |field,reason|
        log.warn "\tField #{field} #{reason}"
      end
    else
      if p.changed? == false
        log.debug "No standard record changes for #{p.loginid}"
        
        p.touch
      else
        log.debug "Updating the following for #{p.loginid}:"
        p.changes.each do |field,changes|
          log.debug "\t#{field}: #{changes[0]} -> #{changes[1]}"
        end
        
        p.save!
      end

      if p.student
        if p.student.changed? == false
          log.debug "Student record exists but there are no changes for #{p.loginid}"
          
          p.student.touch
        else
          log.debug "Updating the following student records for #{p.loginid}:"
          p.student.changes.each do |field,changes|
            log.debug "\t#{field}: #{changes[0]} -> #{changes[1]}"
          end
          
          p.student.save!
        end
      end
    end
  end
end
