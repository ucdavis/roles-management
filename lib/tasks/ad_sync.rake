require 'rake'

namespace :ad do
  require 'authentication'
  include Authentication

  desc 'Sync the user database with Active Directory'
  task :sync_all_users => :environment do
    begin
      # require 'stringio'
      require 'active_directory'
      require 'active_directory_wrapper'

      # notify_admins = false

      # Log to a string so we can both optionally e-mail the log to the admins and merge it into the master log
      log = Rails.logger
      log.tagged "ad:sync_all_users" do
        # Cached groups list
        groups = {}

        timestamp_start = Time.now

        disable_authorization

        # Cache group 'dss-us-auto-all' because we always need it
        groups["dss-us-auto-all"] = ActiveDirectoryWrapper.fetch_group("dss-us-auto-all")
        if groups["dss-us-auto-all"].nil?
          log.error "Error: Could not load group dss-us-auto-all"
        else
          ensure_magic_descriptor_presence(groups["dss-us-auto-all"])
        end

        # Add active users to dss-us-auto-all, cluster-name-affiliation, and cluster-all groups as necessary
        Person.all.each_with_index do |p, i|
          log.tagged "person:#{p.loginid}" do
            ad_user = ActiveDirectoryWrapper.fetch_user(p.loginid)
            if ad_user.nil?
              log.warn "Could not find user '#{p.loginid}' in AD, skipping ..."
              next
            end

            if p.active
              # Add them to dss-us-auto-all if necessary
              unless ActiveDirectoryWrapper.in_group(ad_user, groups["dss-us-auto-all"])
                begin
                  if ActiveDirectoryWrapper.add_user_to_group(ad_user, groups["dss-us-auto-all"]) == false
                    log.error "Need to add to dss-us-auto-all but operation failed"
                    ActivityLog.err!("Needed to add to AD group dss-us-auto-all but operation unexpectedly failed.", ["person_#{p.id}", 'active_directory'])
                  else
                    ActivityLog.record!("Added to AD group dss-us-auto-all.", ["person_#{p.id}", 'active_directory'])
                    log.info "Added to dss-us-auto-all"
                  end
                rescue ArgumentError
                  log.error "FIXME: Unable to add user to group 'dss-us-auto-all' due to code exception: ad_user: #{ad_user.inspect}"
                end
              else
                log.info "Already in dss-us-auto-all"
              end
            else
              # Remove them from dss-us-auto-all if necessary
              if ActiveDirectoryWrapper.in_group(ad_user, groups["dss-us-auto-all"])
                if ActiveDirectoryWrapper.remove_user_from_group(ad_user, groups["dss-us-auto-all"]) == false
                  log.error "Need to remove from dss-us-auto-all but operation failed"
                  ActivityLog.err!("Needed to remove from AD group dss-us-auto-all but operation unexpectedly failed.", ["person_#{p.id}", 'active_directory'])
                else
                  log.info "Removed from dss-us-auto-all"
                  ActivityLog.record!("Removed from AD group dss-us-auto-all.", ["person_#{p.id}", 'active_directory'])
                end
              else
                log.info "Already non-existent in dss-us-auto-all"
              end
            end

            p.affiliations.each do |affiliation|
              # Write them to cluster-name-affiliation (dss-us-#{ou_to_short}-#{flatten_affiliation})
              unless p.organizations.length == 0
                short_ou = ou_to_short(p.organizations[0].name)
                flattened_affiliation = flatten_affiliation(affiliation.name)

                # Skip unknown or ignored translations
                next if ((short_ou == false) || (flattened_affiliation == false) || (short_ou == nil) || (flattened_affiliation == nil))

                unless short_ou.nil? or flattened_affiliation.nil?
                  # Write them to cluster-affiliation-all
                  caa = "dss-us-#{short_ou}-#{flattened_affiliation}".downcase
                  # Cache group if necessary
                  if groups[caa].nil?
                    groups[caa] = ActiveDirectoryWrapper.fetch_group(caa)
                  end

                  if p.active
                    # Add them if necessary
                    unless ActiveDirectoryWrapper.in_group(ad_user, groups[caa])
                      if ActiveDirectoryWrapper.add_user_to_group(ad_user, groups[caa]) == false
                        log.warn "Needed to add to #{caa} but operation failed"
                        ActivityLog.err!("Needed to add to AD group #{caa} but operation unexpectedly failed.", ["person_#{p.id}", 'active_directory'])
                      else
                        log.info "Added to #{caa}"
                        ActivityLog.record!("Added to AD group #{caa}.", ["person_#{p.id}", 'active_directory'])
                      end
                    else
                      log.info "Already in #{caa}\n"
                    end
                  else
                    # Remove them if necessary
                    if ActiveDirectoryWrapper.in_group(ad_user, groups[caa])
                      if ActiveDirectoryWrapper.remove_user_from_group(ad_user, groups[caa]) == false
                        log.warn "Needed to remove from #{caa} but operation failed"
                        ActivityLog.err!("Needed to remove from AD group #{caa} but operation unexpectedly failed.", ["person_#{p.id}", 'active_directory'])
                      else
                        log.info "Removed from #{caa}"
                        ActivityLog.record!("Removed from AD group #{caa}.", ["person_#{p.id}", 'active_directory'])
                      end
                    else
                      log.info "Already non-existent in #{caa}\n"
                    end
                  end

                  # Write them to cluster-all (dss-us-#{ou_to_short}-all)
                  ca = "dss-us-#{short_ou}-all".downcase
                  # Cache group if necessary
                  if groups[ca].nil?
                    groups[ca] = ActiveDirectoryWrapper.fetch_group(ca)
                  end

                  if p.active
                    # Add if necessary
                    unless ActiveDirectoryWrapper.in_group(ad_user, groups[caa])
                      if ActiveDirectoryWrapper.add_user_to_group(ad_user, groups[ca]) == false
                        log.warn "Needed to add to #{ca} but operation failed"
                        ActivityLog.err!("Needed to add to AD group #{ca} but operation unexpectedly failed.", ["person_#{p.id}", 'active_directory'])
                      else
                        log.info "Added to #{ca}"
                        ActivityLog.record!("Added to AD group #{ca}.", ["person_#{p.id}", 'active_directory'])
                      end
                    else
                      log.info "Already in #{ca}"
                    end
                  else
                    # Remove if necessary
                    if ActiveDirectoryWrapper.in_group(ad_user, groups[caa])
                      if ActiveDirectoryWrapper.remove_user_from_group(ad_user, groups[ca]) == false
                        log.warn "Needed to remove from #{ca} but operation failed"
                        ActivityLog.err!("Needed to remove from AD group #{ca} but operation unexpectedly failed.", ["person_#{p.id}", 'active_directory'])
                      else
                        log.info "Removed from #{ca}"
                        ActivityLog.record!("Removed from AD group #{ca}.", ["person_#{p.id}", 'active_directory'])
                      end
                    else
                      log.info "Already non-existent in #{ca}"
                    end
                  end
                end
              end
            end
          end
        end

        timestamp_finish = Time.now

        enable_authorization

        log.info "AD Sync took " + (timestamp_finish - timestamp_start).to_s + " seconds"
      end

      # Email the log
      # if notify_admins
      #   admin_role_id = Application.find_by_name("DSS Rights Management").roles.find(:first, :conditions => [ "lower(token) = 'admin'" ]).id
      #   Role.find_by_id(admin_role_id).people.each do |admin|
      #     WheneverMailer.adsync_report(admin.email, strio.string).deliver!
      #   end
      # end
    rescue => exception
      ExceptionNotifier.notify_exception(exception)
    end
  end

  desc 'Sync all roles against Active Directory.'
  task :sync_all_roles => :environment do
    begin
      Role.all.each do |r|
        if r.ad_path
          puts "Queueing role #{r.id} (#{r.name} / #{r.application.name}) for background sync ..."
          Delayed::Job.enqueue(DelayedRake.new("ad:sync_role[#{r.id}]"))
        end
      end
    rescue => exception
      ExceptionNotifier.notify_exception(exception)
    end
  end

  desc 'Sync a role against Active Directory. May create new users as needed.'
  task :sync_role, [:role_id] => :environment do |t, args|
    begin
      # require 'stringio'
      require 'active_directory'
      require 'active_directory_wrapper'

      log = Rails.logger

      timestamp_start = Time.now

      log.tagged "ad:sync_role" do
        log.tagged "role:#{args[:role_id]}" do
          r = Role.includes(:entities).find_by_id(args[:role_id])

          unless r.nil?
            disable_authorization

            unless r.ad_path.nil?
              log.info "Syncing role #{r.id} (#{r.application.name} / #{r.token}) with AD ..."

              if r.ad_guid
                g = ActiveDirectoryWrapper.fetch_group_by_guid(r.ad_guid)
              else
                g = ActiveDirectoryWrapper.fetch_group(r.ad_path)
                # Record GUID as this is our preferred method of finding an existing group
                r.ad_guid = g.objectguid unless g.nil?
              end

              ensure_magic_descriptor_presence(g)

              # Ensure name is up-to-date as GUID-based lookups allow for object name changes without affecting us
              r.ad_path = g.cn unless g.nil?

              unless g.nil?
                log.info "Found group (#{r.ad_path}, #{r.ad_guid}) in AD."

                # Add enabled members to AD
                r.members.select{ |m| m.active }.each do |member|
                  u = ActiveDirectoryWrapper.fetch_user(member.loginid)
                  unless ActiveDirectoryWrapper.in_group(u, g)
                    log.info "Adding user #{member.loginid} to AD group #{r.ad_path}"
                    if ActiveDirectoryWrapper.add_user_to_group(u, g) == false
                      ActivityLog.err!("Needed to add #{member.name} to AD group #{r.ad_path} but the operation failed.", ["person_#{member.id}", "role_#{r.id}", "application_#{r.application_id}", 'active_directory'])
                      log.error "Needed to add #{member.name} to AD group #{r.ad_path} but the operation failed."
                    else
                      ActivityLog.record!("Added #{member.name} to AD group #{r.ad_path}.", ["person_#{member.id}", "role_#{r.id}", "application_#{r.application_id}", 'active_directory'])
                      log.info "Added #{member.name} to AD group #{r.ad_path}."
                    end
                  else
                    log.info "User #{member.loginid} is already in AD group #{r.ad_path}"
                  end
                end

                # If this is our first AD sync, we will add AD entries not found locally back to our database (two-way sync),
                # else we will remove any AD members who do not match our local database (one-way sync).
                ad_members = ActiveDirectoryWrapper.list_group_members(g)
                role_members = r.members.select{ |m| m.active }.map{ |x| x.loginid }

                if r.last_ad_sync == nil
                  # Add AD entries back as local members
                  log.info "Syncing AD members back to local as this is the first recorded AD sync for this role."
                  log.info "There are #{ad_members.length} listed in AD and #{role_members.length} locally at the start."

                  ad_members.each do |m|
                    log.info "Syncing back #{m[:samaccountname]}"
                    unless role_members.include? m[:samaccountname]
                      log.info "#{m[:samaccountname]} is not already in role_members, going to add ..."
                      p = Person.find_by_loginid m[:samaccountname]
                      if p
                        r.entities << p
                        log.info "Adding user #{m[:samaccountname]} from AD group #{r.ad_path} to local group."
                        ActivityLog.record!("Added #{p.name} to role #{r.token} on #{r.application.name} because they exist in the AD group and this is a first-time sync.", ["person_#{p.id}", "role_#{r.id}", "application_#{r.application_id}", 'active_directory'])
                      else
                        log.info "Will create user #{m[:samaccountname]} from AD group #{r.ad_path} as they could not be found locally."

                        p = Person.new
                        p.loginid = m[:samaccountname]
                        p.last = p.loginid # we need the name set to something. LDAP sync will update this if possible.
                        p.save

                        ActivityLog.record!("Creating person with login ID of #{p.loginid} for the role #{r.token} on #{r.application.name} because they exist in the AD group, they do not already exist as a person in RM, and this is a first-time sync.", ["person_#{p.id}", "role_#{r.id}", "application_#{r.application_id}", 'active_directory'])

                        log.info "Created local user with only loginid #{m[:samaccountname]} and queued LDAP import to check."

                        Delayed::Job.enqueue(DelayedRake.new("ldap:import[#{m[:samaccountname]}]"))

                        # Ensure role has this individual
                        r.entities << p
                      end
                    else
                      log.info "User #{m[:samaccountname]} is already in RM and doesn't need to be synced back from AD."
                    end
                  end
                else
                  # Remove AD entries which do not match our local database
                  log.info "Removing any entries in AD which do not match our records (this is not the first AD sync for this role)."
                  ad_members.each do |m|
                    unless role_members.include? m[:samaccountname]
                      log.info "#{m[:samaccountname]} is in AD but not this role or is in this role but marked inactive. Will remove from AD ..."

                      if ActiveDirectoryWrapper.remove_user_from_group(m, g) == false
                        ActivityLog.err!("Needed to remove #{m[:samaccountname]} from AD group #{r.ad_path} because AD mentions them but RM doesn't, but the operation failed.", ["role_#{r.id}", "application_#{r.application_id}", 'active_directory'])
                        log.error "Needed to remove #{m[:samaccountname]} from AD group #{r.ad_path} because AD mentions them but RM doesn't, but the operation failed."
                      else
                        ActivityLog.record!("Removed #{m[:samaccountname]} from AD group #{r.ad_path} because RM does not agree they should be in that group.", ["role_#{r.id}", "application_#{r.application_id}", 'active_directory'])
                        log.info "Removed #{m[:samaccountname]} from AD group #{r.ad_path} because RM does not agree they should be in that group."
                      end
                    else
                      log.info "#{m[:samaccountname]} is in AD and this role. No action taken."
                    end
                  end
                end
              else
                log.error "Could not find group (#{r.ad_path}, #{r.ad_guid}) in AD."
                ActivityLog.err!("Could not find group (#{r.ad_path}, #{r.ad_guid}) in AD.", ["role_#{r.id}", "application_#{r.application_id}", 'active_directory'])
              end

              log.info "Done syncing role #{r.id} with AD."

              r.last_ad_sync = Time.now

              r.save
            else
              log.info "Not syncing role because no AD path is set."
            end

            enable_authorization
          else
            log.warn "Cannot find role with ID #{args[:role_id]}"
          end

          timestamp_finish = Time.now

          log.info "Sync finished. Time elapsed: " + (timestamp_finish - timestamp_start).to_s + " seconds"
        end
      end
    rescue => exception
      ExceptionNotifier.notify_exception(exception)
    end
  end
end

# The magic descriptor used by ensure_magic_descriptor_presence
MAGIC_DESCRIPTOR = "(RM Sync)"

# Adds the MAGIC_DESCRIPTOR text to an AD group's description field if
# it is not present.
#
# +ad_group+ is an AD group object required by the active_record gem
def ensure_magic_descriptor_presence(ad_group)
  # Use exceptions as activedirectory gem will throw an ArgumentError if no description exists.
  # AD groups don't have to have description fields but we will add one if needed.
  begin
    g_desc = ad_group.description
  rescue ArgumentError
    # description not set
    g_desc = ""
  end

  unless g_desc and g_desc.index MAGIC_DESCRIPTOR
    ad_group.description = "#{MAGIC_DESCRIPTOR} #{g_desc}"
    ad_group.save
  end
end

# Converts common organization names to their AD-mapped equivalents
# Returns a match, nil (if we know the organization but do not wish to sync it), or
# false (if we do not know the organization and need to log this missing data).
def ou_to_short(name)
  name = name.upcase

  case name
  when "DSS IT SERVICE CENTER", "DSS IT SHARED SERVICE CENTER"
    return "IT"
  when "DSS HR/PAYROLL SERVICE CENTER"
    return "HR"
  when "CALIFORNIA HISTORY SS PROJECT"
    return "CHP"
  when "UC CENTER SACRAMENTO"
    return "UCCS"
  when "HEMISPHERIC INSTITUTE-AMERICAS"
    return "PHE"
  when "HISTORY PROJECT", "HISTORY PROJECT UCD"
    return "HP"
  when "SOCIAL SCIENCES PROGRAM"
    return "SSP"
  when "PHYSICAL EDUCATION PROGRAM"
    return "PHE"
  when "DSS RESEARCH SERVICE CENTER"
    return "RSC"
  when "GEOGRAPHY"
    return "GEO"
  when "ANTHROPOLOGY"
    return "ANT"
  when "COMMUNICATION"
    return "CMN"
  when "ECONOMICS"
    return "ECN"
  when "HISTORY"
    return "HIS"
  when "LINGUISTICS"
    return "LIN"
  when "MILITARY SCIENCE"
    return "MSC"
  when "PHILOSOPHY"
    return "PHI"
  when "POLITICAL SCIENCE"
    return "POL"
  when "PSYCHOLOGY"
    return "PSC"
  when "EASTERN ASIAN STUDIES"
    return "EAS"
  when "INTERNATIONAL RELATIONS"
    return "IRE"
  when "MIDDLE EAST/SOUTH ASIA STUDIES", "MIDDLE EAST/SOUTH ASIA PROGRAM"
    return "MSA"
  when "SCIENCE & TECHNOLOGY STUDIES"
    return "STS"
  when "CENTER FOR MIND AND BRAIN", "CENTER FOR MIND & BRAIN"
    return "CMB"
  when "SOCIOLOGY"
    return "SOC"
  when "COM, PHIL & LIN RED CLUSTER"
    return "RED"
  when "POLI SCI, IR ORANGE CLUSTER", "SOCIAL SCIENCE ORANGE CLUSTER"
    return "ORANGE"
  when "ECON, HIS, MS BLUE CLUSTER", "SOCIAL SCIENCES BLUE CLUSTER"
    return "BLUE"
  when "ANT, SOC GREEN CLUSTER", "SOCIAL SCIENCES GREEN CLUSTER"
    return "GREEN"
  when "L&S DEANS - SOCIAL SCIENCES"
    return "DEANS"
  when "PSYCH, CMB YELLOW CLUSTER", "SOCIAL SCIENCE YELLOW CLUSTER"
    return "YELLOW"
  when "EDUCATION - PH.D."
    return "EDU"
  when "COMMUNITY DEVELOPMENT"
    return "ComDev"
  when "NEUROSCIENCE", "CENTER FOR NEUROSCIENCE"
    return "NueroSci"
  when "CENTER FOR INNOVATION STUDIES"
    return "CSIS"
  when "ASUCD", "UC DAVIS", "ASIAN AMERICAN", "UNIVERSITY EXTENSION", "CHEDDAR", "STUDENT EMPLOYMENT CENTER",
    "TEMPORARY EMPLOYMENT SERVICE", "CAMPUS RECREATION AND UNIONS", "CRESS DEPARTMENT", "LIBRARY", "POLICE",
    "COMPARATIVE LITERATURE", "PRIMATE CENTER", "L&S DEANS - U/G ED & ADVISING", "STATISTICS",
    "AGR & ENV SCI DEANS OFFICE", "OFFICE OF THE CHANCELLOR", "UNDERGRADUATE ADMISSIONS",
    "UNIVERSITY WRITING PROGRAM", "TEXTILES & CLOTHING", "STUDENT HOUSING", "ENGLISH", "ANIMAL SCIENCE",
    "IRB ADMINISTRATION", "SCHOOL OF LAW-DEANS OFFICE", "STUDENT ACADEMIC SUCCESS CTR", "GERMAN & RUSSIAN",
    "INTERCOLLEGIATE ATHLETICS", "HUMAN ECOLOGY", "GRADUATE DIVISION", "MED: NEUROLOGY",
    "ENVIRONMENTAL TOXICOLOGY", "SCHOOL OF MED - STAFF", "L&S DEANS - DEVELOPMENT",
    "TEMPORARY EMPLOYMENT POOL ADMN", "SCHOOL OF MED - APS", "MED: GENERAL PEDIATRICS",
    "MED:PSYCHIATRY & BEHAV SCI", "NATIVE AMERICAN STUDIES", "ART", "VP UNDERGRADUATE EDUCATION", "GEOLOGY",
    "VM: CTR COMPARATIVE MEDICINE", "ENGR COMPUTER SCIENCE", "MED: DIV OF INTERNAL MED",
    "FM: CUSTODIAL SERVICES", "VOORHIES ADMINISTRATIVE UNIT", "MED: OPHTHALMOLOGY", "MED: PUBLIC HEALTH SCIENCES",
    "NEURO PHYSIO & BEHAVIOR", "INST OF TRANSPORTATION STUDIES", "ENVIRONMENTAL HEALTH & SAFETY",
    "MEDIEVAL STUDIES", "EDUCATION", "ACADEMIC AFFAIRS", "ANR SUSTAINABLE AG PROG"
    return nil
  else
    Rails.logger.warn "AD Sync: Missing OU for translation to container name: #{name}"
    ActivityLog.err!("Could not translate unknown organization to AD group equivalent: #{name}", ['active_directory'])
  end

  return false
end

# Converts common affiliations to their AD-mapped equivalents
# Returns a match, nil (if we know the affiliation but do not wish to sync it), or
# false (if we do not know the affiliation and need to log this missing data).
def flatten_affiliation(affiliation)
  if affiliation.include? "staff" and not (affiliation.include? ":")
    return "staff-academic"
  end

  case affiliation
  when "faculty:senate"
    return "faculty"
  when "faculty:federation"
    return "lecturer"
  when "staff:career"
    return "staff"
  when "staff:casual"
    return "staff"
  when "staff:contract"
    return "staff"
  when "staff:student"
    return "staff-student"
  when "student:graduate"
    return "student-graduate"
  when "visitor:student:graduate"
    return "student-graduate"
  when "faculty"
    return "faculty"
  when "student:undergraduate", "student:law", "visitor:consultant", "student:medicine",
    "visitor:student:concurrent", "visitor:lecturer", "visitor:faculty:research", "visitor:staff:temporary",
    "visitor:postdoc:research", "visitor:faculty:teaching", "visitor:student", "student:vetmed", "student",
    "visitor"
    return nil
  else
    Rails.logger.warn "AD Sync: Missing affiliation for translation to container name: #{affiliation}"
    ActivityLog.err!("Could not translate unknown affiliation to AD group equivalent: #{affiliation}", ['active_directory'])
  end

  return false
end
