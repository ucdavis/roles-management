namespace :ldap do
  require 'ldap_helper'
  require 'ldap_person_helper'

  require 'authentication'
  include Authentication

  desc 'Import users from LDAP based on filters, or by login ID'
  task :import, [:loginid] => :environment do |t, args|
    begin
      require 'stringio'

      # If 'loginid' was specified, we're only importing a single login ID,
      # else we import everyone.
      single_import_mode = args[:loginid].nil? ? false : true

      disable_authorization

      log = ActiveSupport::TaggedLogging.new(Logger.new("#{Rails.root.join('log', 'ldap-sync.log')}"))
      log.formatter = Logger::Formatter.new # ensure log is timestamped

      # Track who was found in LDAP so we can compare against existing users
      # to find users who have since disappeared from LDAP.
      loginids_touched = []

      log.tagged "ldap:import" do
        timestamp_start = Time.now

        #
        # STEP ONE: Connect to LDAP. Query needed data.
        #
        ldap = LdapHelper.new
        unless ldap.connect(log)
          log.error "Cannot run LDAP import task; could not connect to LDAP."
          raise "Cannot run LDAP import task; could not connect to LDAP."
        else
          log.debug "Connected to ldap.ucdavis.edu on port 636, LDAP protocol version 3."
        end

        filters = []

        # If a login ID was specified, process only that login ID, else, process the standard (broad) filters
        if single_import_mode
          # Specified a loginid
          manualFilter = []
          manualFilter << '(uid=' + args[:loginid] + ')'

          log.debug "Query: " + manualFilter.join(",")

          filters = manualFilter
        else
          # Did not specify a loginid - import everyone
          filters = ldap.build_filters(log)
        end

        num_results = 0

        # Query LDAP
        for filter in filters
          unless filter.length == 0
            results = ldap.search(filter, log)

            log.debug "LDAP filter(s) search returned #{results.length} results."

            results.each_with_index do |result, i|
              p = LdapPersonHelper.create_or_update_person_from_ldap(result, log)
              loginids_touched << p.loginid unless p.nil?

              num_results += 1

              log.debug "Processed #{i + 1} of #{results.length} results" if (i % 10) == 0
            end
          end
        end

        log.debug "Finished processing #{num_results} of #{results.length} results"

        log.debug "No LDAP result(s) were found." unless num_results > 0

        # Process the list of untouched_loginids (local users who weren't noticed by our original LDAP query).
        # Only do this if we weren't in 'single' import mode
        unless single_import_mode
          log.debug "Processing additional login IDs existing locally but not found in the standard LDAP queries."

          if loginids_touched.count > 0
            Person.where("active = true AND loginid NOT IN (?)", loginids_touched).each do |person|
              p = nil

              results = ldap.search('(uid=' + person.loginid + ')', log)

              unless results == false
                if results.length > 0
                  p = LdapPersonHelper.create_or_update_person_from_ldap(results[0], log)
                end

                unless p
                  log.info "Person with login ID '#{person.loginid}' not found in LDAP, disabling ..."
                  person.active = false
                  unless person.save
                    log.error "Could not save person (#{person.loginid}), reason(s):"
                    log.error "\t#{person.errors.full_messages.join(', ')}"
                  else
                    ActivityLog.info!("De-activated #{person.name} as they are not in LDAP.", ["person_#{person.id}", 'ldap'])
                  end
                end
              else
                log.warn "'#{person.loginid}' was not found during mass LDAP import but could not be looked up individually due to an LDAP error. RM will take no action on this record at this time."
                next
              end
            end
          end
        end

        timestamp_finish = Time.now

        log.info "Completed LDAP import. Took " + (timestamp_finish - timestamp_start).to_s + "s."
      end

      enable_authorization
    rescue => exception
      ExceptionNotifier.notify_exception(exception)
    end
  end
end
