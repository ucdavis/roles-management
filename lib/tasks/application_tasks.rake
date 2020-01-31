require 'rake'

namespace :application do
  desc 'Recalculate inherited application ownerships from groups for a given person.'
  task :recalculate_inherited_application_ownerships, [:loginid] => :environment do |t, args|
    unless args[:loginid]
      puts "You must specify a login ID to recalculate."
      exit
    end

    p = Person.find_by_loginid(args[:loginid])
    unless p
      puts "Could not find a person with login ID #{args[:loginid]}"
      exit
    end

    calculated_aos = []
    p.application_ownerships.each do |ao|
      if ao.parent_id != nil
        calculated_aos << ao
      end
    end

    puts "#{p.loginid} has #{calculated_aos.length} inherited application ownership(s) out of #{p.application_ownerships.length} total application ownership(s)."

    # First remove the calculated application ownerships
    calculated_aos.each do |ao|
      ao.destroy
    end

    puts 'All calculated application ownership(s) destroyed.'

    # Now re-create them based on each group's application ownership(s)
    p.group_memberships.each do |gm|
      puts "Group (ID: #{gm.group_id} / #{gm.group.name}) has #{gm.group.application_ownerships.length} application ownerships ..."
      gm.group.application_ownerships.each do |group_ao|
        if(ApplicationOwnership.find_by(entity_id: p.id, application_id: group_ao.application_id, parent_id: group_ao.id) == nil)
          puts "\tGranting application ownership (ID: #{group_ao.application_id} / #{group_ao.application.name}) with parent assignment #{group_ao.id} ..."

          ApplicationsService.grant_application_ownership(Application.find_by(id: group_ao.application_id), p, group_ao.id)
        else
          puts "\tSkipping application ownership grant as it already exists: (ID: #{group_ao.application_id} / #{group_ao.application.name}) with parent assignment #{group_ao.id}. "
        end
      end
    end
  end

  desc 'Recalculate inherited application operatorships from groups for a given person.'
  task :recalculate_inherited_application_operatorships, [:loginid] => :environment do |t, args|
    unless args[:loginid]
      puts "You must specify a login ID to recalculate."
      exit
    end

    p = Person.find_by_loginid(args[:loginid])
    unless p
      puts "Could not find a person with login ID #{args[:loginid]}"
      exit
    end

    calculated_aos = []
    p.application_operatorships.each do |ao|
      if ao.parent_id != nil
        calculated_aos << ao
      end
    end

    puts "#{p.loginid} has #{calculated_aos.length} inherited application operatorship(s) out of #{p.application_operatorships.length} total application operatorship(s)."

    # First remove the calculated application operatorships
    calculated_aos.each do |ao|
      ao.destroy
    end

    puts "All calculated application operatorship(s) destroyed."

    # Now re-create them based on each group's application operatorship(s)
    p.group_memberships.each do |gm|
      puts "Group (ID: #{gm.group_id} / #{gm.group.name}) has #{gm.group.application_operatorships.length} application operatorships ..."
      gm.group.application_operatorships.each do |group_ao|
        if(ApplicationOperatorship.find_by(entity_id: p.id, application_id: group_ao.application_id, parent_id: group_ao.id) == nil)
          ao = ApplicationOperatorship.new
          ao.entity_id = p.id
          ao.application_id = group_ao.application_id
          ao.parent_id = group_ao.id

          puts "\tGranting application operatorship (ID: #{group_ao.application_id} / #{group_ao.application.name}) with parent assignment #{group_ao.id} ..."

          ao.save!
        else
          puts "\tSkipping application operatorship grant as it already exists: (ID: #{group_ao.application_id} / #{group_ao.application.name}) with parent assignment #{group_ao.id}. "
        end
      end
    end
  end

  desc 'Generates a directory tree for application owners containing role membership CSVs.'
  task role_report: :environment do
    require 'fileutils'
    require 'csv'

    def sanitize_filename(name)
      name.gsub!(/\+/, "plus")
      name.gsub!(/\//,"fs")

      return name
    end

    report_path = "reports/people_by_role_for_owners"

    ApplicationOwnership.all.each do |ao|
      owner = ao.entity
      application = ao.application

      application_path = "#{report_path}/#{owner.loginid}-#{owner.email}/#{application.id}-#{sanitize_filename(application.name)}"

      # Create directory if necessary
      FileUtils.mkdir_p application_path

      application.roles.each do |role|
        CSV.open("#{application_path}/#{role.id}-#{sanitize_filename(role.name)}.csv", "wb") do |csv|  
          csv << ["loginid", "last", "first"]
          role.members.each do |member|
            csv << [member.loginid, member.last, member.first]
          end
        end
      end
    end
  end
end
