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
    Thread.current[:application_ownership_destroy_flag] = true
    calculated_aos.each do |ao|
      ao.destroy
    end
    Thread.current[:application_ownership_destroy_flag] = nil

    puts "All calculated application ownership(s) destroyed."

    # Now re-create them based on each group's application ownership(s)
    p.group_memberships.each do |gm|
      puts "Group (ID: #{gm.group_id} / #{gm.group.name}) has #{gm.group.application_ownerships.length} application ownerships ..."
      gm.group.application_ownerships.each do |group_ao|
        if(ApplicationOwnership.find_by(entity_id: p.id, application_id: group_ao.application_id, parent_id: group_ao.id) == nil)
          ao = ApplicationOwnership.new
          ao.entity_id = p.id
          ao.application_id = group_ao.application_id
          ao.parent_id = group_ao.id

          puts "\tGranting application ownership (ID: #{group_ao.application_id} / #{group_ao.application.name}) with parent assignment #{group_ao.id} ..."

          ao.save!
        else
          puts "\tSkipping application ownership grant as it already exists: (ID: #{group_ao.application_id} / #{group_ao.application.name}) with parent assignment #{group_ao.id}. "
        end
      end
    end
  end
end
