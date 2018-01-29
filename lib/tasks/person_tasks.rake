require 'rake'

namespace :person do
  DAYS_INDICATING_INACTIVE = 45
  DAYS_INDICATING_REMOVAL = 180

  desc 'Mark inactive any account not updated recently'
  task mark_inactive: :environment do
    # Find people who are active but have not been synced in 'DAYS_INDICATING_INACTIVE' days
    people = Person.where('(synced_at < ?) or (synced_at is null)', (Time.now - DAYS_INDICATING_INACTIVE.days))
                   .where(active: true)

    people.each do |p|
      p.active = false
      p.save!
    end

    # Only output if more than 5% of the user database is affected
    puts "Found and marked inactive #{people.length} people." if people.to_f / Person.count.to_f >= 0.05
  end

  desc 'Remove long-inactive people'
  task remove_inactive: :environment do
    # Find people who are inactive for at least 'DAYS_INDICATING_REMOVAL' days
    people = Person.where('(synced_at < ?) or (synced_at is null)', (Time.now - DAYS_INDICATING_REMOVAL.days))
                   .where(active: false)

    people.each(&:destroy)

    # Only output if more than 5% of the user database is affected
    puts "Found and removed inactive #{people.length} people." if people.to_f / Person.count.to_f >= 0.05
  end
end
