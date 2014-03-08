require 'rake'

namespace :ad do
  desc 'Sync the user database with Active Directory'
  task :sync_all_users => :environment do
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

      # Cache group 'dss-us-auto-all' because we always need it
      groups["dss-us-auto-all"] = ActiveDirectoryWrapper.fetch_group("dss-us-auto-all")
      if groups["dss-us-auto-all"].nil?
        log.error "Error: Could not load group dss-us-auto-all"
      else
        ensure_magic_descriptor_presence(groups["dss-us-auto-all"])
      end
      
      # Add active users to dss-us-auto-all, cluster-name-affiliation, and cluster-all groups as necessary
      Person.where(:active => true).each_with_index do |p, i|
        log.tagged "person:#{p.loginid}" do
          ad_user = ActiveDirectoryWrapper.fetch_user(p.loginid)
          if ad_user.nil?
            log.warn "Could not find user in AD"
          end

          # Add them to dss-us-auto-all if necessary
          unless ActiveDirectoryWrapper.in_group(ad_user, groups["dss-us-auto-all"])
            if ActiveDirectoryWrapper.add_user_to_group(ad_user, groups["dss-us-auto-all"]) == false
              log.error "Need to add to dss-us-auto-all but operation failed"
            else
              log.info "Added to dss-us-auto-all"
            end
          else
            log.info "Already in dss-us-auto-all"
          end

          p.affiliations.each do |affiliation|
            # Write them to cluster-name-affiliation (dss-us-#{ou_to_short}-#{flatten_affiliation})
            unless p.organizations.length == 0
              short_ou = ou_to_short(p.organizations[0].name)
              flattened_affiliation = flatten_affiliation(affiliation.name)

              # Skip unknown translations
              if ((short_ou == false) || (flattened_affiliation == false))
                log.warn "Skipping AD affiliation group sync for user #{p.loginid} as OU shortened translation is unknown for '#{p.organizations[0].name}'." unless short_ou
                log.warn "Skipping AD affiliation group sync for user #{p.loginid} as affiliation shortened translation is unknown for '#{affiliation.name}'." unless flattened_affiliation
                next
              end

              unless short_ou.nil? or flattened_affiliation.nil?
                # Write them to cluster-affiliation-all
                caa = "dss-us-#{short_ou}-#{flattened_affiliation}".downcase
                # Cache group if necessary
                if groups[caa].nil?
                  groups[caa] = ActiveDirectoryWrapper.fetch_group(caa)
                end
                unless ActiveDirectoryWrapper.in_group(ad_user, groups[caa])
                  if ActiveDirectoryWrapper.add_user_to_group(ad_user, groups[caa]) == false
                    log.warn "Needed to add to #{caa} but operation failed"
                  else
                    log.info "Added to #{caa}"
                  end
                else
                  log.info "Already in #{caa}\n"
                end

                # Write them to cluster-all (dss-us-#{ou_to_short}-all)
                ca = "dss-us-#{short_ou}-all".downcase
                # Cache group if necessary
                if groups[ca].nil?
                  groups[ca] = ActiveDirectoryWrapper.fetch_group(ca)
                end
                unless ActiveDirectoryWrapper.in_group(ad_user, groups[caa])
                  if ActiveDirectoryWrapper.add_user_to_group(ad_user, groups[ca]) == false
                    log.warn "Warning: Needed to add to #{ca} but operation failed"
                  else
                    log.info "Added to #{ca}"
                  end
                else
                  log.info "Already in #{ca}"
                end
              end
            end
          end
        end
      end

      timestamp_finish = Time.now

      log.info "AD Sync took " + (timestamp_finish - timestamp_start).to_s + " seconds"
    end

    # Email the log
    # if notify_admins
    #   admin_role_id = Application.find_by_name("DSS Rights Management").roles.find(:first, :conditions => [ "lower(token) = 'admin'" ]).id
    #   Role.find_by_id(admin_role_id).people.each do |admin|
    #     WheneverMailer.adsync_report(admin.email, strio.string).deliver!
    #   end
    # end
  end
  
  desc 'Sync all roles against Active Directory.'
  task :sync_all_roles => :environment do
    Role.all.each do |r|
      if r.ad_path
        puts "Queueing role #{r.id} (#{r.name} / #{r.application.name}) for background sync ..."
        Delayed::Job.enqueue(DelayedRake.new("ad:sync_role[#{r.id}]"))
      end
    end
  end

  desc 'Sync a role against Active Directory. May create new users as needed.'
  task :sync_role, [:role_id] => :environment do |t, args|
    # require 'stringio'
    require 'active_directory'
    require 'active_directory_wrapper'
    
    log = Rails.logger
    
    timestamp_start = Time.now
    
    log.tagged "ad:sync_role" do
      log.tagged "role:#{args[:role_id]}" do
        r = Role.includes(:entities).find_by_id(args[:role_id])

        unless r.nil?
          Authorization.ignore_access_control(true)

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
                  ActiveDirectoryWrapper.add_user_to_group(u, g)
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
                    else
                      log.info "Will create user #{m[:samaccountname]} from AD group #{r.ad_path} as they could not be found locally."

                      p = Person.new
                      p.loginid = m[:samaccountname]
                      p.last = p.loginid # we need the name set to something. LDAP sync will update this if possible.
                      p.save

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
                    log.info "#{m[:samaccountname]} is in AD but not this role. Will remove from AD ..."
            
                    ActiveDirectoryWrapper.remove_user_from_group(m, g)
                  else
                    log.info "#{m[:samaccountname]} is in AD and this role. No action taken."
                  end
                end
              end
            else
              log.error "Could not find group (#{r.ad_path}, #{r.ad_guid}) in AD."
            end

            log.info "Done syncing role #{r.id} with AD."

            r.last_ad_sync = Time.now
            
            r.save
          else
            log.info "Not syncing role because no AD path is set."
          end
          
          Authorization.ignore_access_control(false)
        else
          log.warn "Cannot find role with ID #{args[:role_id]}"
        end

        timestamp_finish = Time.now

        log.info "Sync finished. Time elapsed: " + (timestamp_finish - timestamp_start).to_s + " seconds"
      end
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
    ad_group.description = "#{g_desc} #{MAGIC_DESCRIPTOR}"
    ad_group.save
  end
end

def ou_to_short(name)
  name = name.upcase

  case name
  when "DSS IT SERVICE CENTER"
    "IT"
  when "DSS HR/PAYROLL SERVICE CENTER"
    "HR"
  when "CALIFORNIA HISTORY SS PROJECT"
    "CHP"
  when "UC CENTER SACRAMENTO"
    "UCCS"
  when "HEMISPHERIC INSTITUTE-AMERICAS"
    "PHE"
  when "HISTORY PROJECT"
    "HP"
  when "SOCIAL SCIENCES PROGRAM"
    "SSP"
  when "PHYSICAL EDUCATION PROGRAM"
    "PHE"
  when "DSS RESEARCH SERVICE CENTER"
    "RSC"
  when "GEOGRAPHY"
    "GEO"
  when "ANTHROPOLOGY"
    "ANT"
  when "COMMUNICATION"
    "CMN"
  when "ECONOMICS"
    "ECN"
  when "HISTORY"
    "HIS"
  when "LINGUISTICS"
    "LIN"
  when "MILITARY SCIENCE"
    "MSC"
  when "PHILOSOPHY"
    "PHI"
  when "POLITICAL SCIENCE"
    "POL"
  when "PSYCHOLOGY"
    "PSC"
  when "EASTERN ASIAN STUDIES"
    "EAS"
  when "INTERNATIONAL RELATIONS"
    "IRE"
  when "MIDDLE EAST/SOUTH ASIA STUDIES"
    "MSA"
  when "SCIENCE & TECHNOLOGY STUDIES"
    "STS"
  when "CENTER FOR MIND AND BRAIN"
    "CMB"
  when "SOCIOLOGY"
    "SOC"
  when "COM, PHIL & LIN RED CLUSTER"
    "RED"
  when "POLI SCI, IR ORANGE CLUSTER"
    "ORANGE"
  when "ECON, HIS, MS BLUE CLUSTER"
    "BLUE"
  when "ANT, SOC GREEN CLUSTER"
    "GREEN"
  when "L&S DEANS - SOCIAL SCIENCES"
    "DEANS"
  when "PSYCH, CMB YELLOW CLUSTER"
    "YELLOW"
  when "EDUCATION - PH.D."
    "EDU"
  when "COMMUNITY DEVELOPMENT"
    "ComDev"
  when "NEUROSCIENCE"
    "NueroSci"
  when "CENTER FOR INNOVATION STUDIES"
    "CSIS"
  else
    Rails.logger.warn "AD Sync: Missing OU for translation to container name: #{name}"
  end

  return false
end

def flatten_affiliation(affiliation)
  if affiliation.include? "staff" and not (affiliation.include? ":")
    return "staff-academic"
  end

  case affiliation
  when "faculty:senate"
    "faculty"
  when "faculty:federation"
    "lecturer"
  when "staff:career"
    "staff"
  when "staff:casual"
    "staff"
  when "staff:contract"
    "staff"
  when "staff:student"
    "staff-student"
  when "student:graduate"
    "student-graduate"
  when "visitor:student:graduate"
    "student-graduate"
  when "faculty"
    "faculty"
  else
    Rails.logger.warn "AD Sync: Missing affiliation for translation to container name: #{affiliation}"
  end

  return false
end
