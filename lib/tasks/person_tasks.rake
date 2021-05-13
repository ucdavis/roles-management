require 'rake'

namespace :person do
  DAYS_INDICATING_INACTIVE = 45
  DAYS_INDICATING_REMOVAL = 180

  desc 'Mark active/inactive based on account sync recency'
  task update_active_flag: :environment do
    puts "Running update_active_flag"
    # Find people who are _active_ but have not been synced in 'DAYS_INDICATING_INACTIVE' days
    people = Person.where('(synced_at < ?) or (synced_at is null)', (Time.now - DAYS_INDICATING_INACTIVE.days))
                   .where(active: true)

    people.each do |p|
      PeopleService.set_active_status(p, false)
      p.save!
    end

    # Only output if more than 5% of the user database is affected
    puts "Found and marked inactive #{people.length} people." if people.length.to_f / Person.count.to_f >= 0.05

    # Find people who are _inactive_ but have been synced in 'DAYS_INDICATING_INACTIVE' days
    people = Person.where('synced_at >= ?', (Time.now - DAYS_INDICATING_INACTIVE.days))
    .where(active: false)

    people.each do |p|
      PeopleService.set_active_status(p, true)
      p.save!
    end

    # Only output if more than 5% of the user database is affected
    puts "Found and marked active #{people.length} people." if people.length.to_f / Person.count.to_f >= 0.05
  end

  desc 'Remove long-inactive people'
  task remove_inactive: :environment do
    puts "Running remove_inactive"
    # Find people who are inactive for at least 'DAYS_INDICATING_REMOVAL' days
    people = Person.where('(synced_at < ?) or (synced_at is null)', (Time.now - DAYS_INDICATING_REMOVAL.days))
                   .where(active: false)

    people.each(&:destroy)

    # Only output if more than 5% of the user database is affected
    puts "Found and removed inactive #{people.length} people." if people.length.to_f / Person.count.to_f >= 0.05
  end
end
