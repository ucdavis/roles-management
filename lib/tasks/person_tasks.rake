require 'rake'

namespace :person do
  DAYS_INDICATING_INACTIVE = 45

  desc 'Mark inactive any account not updated recently'
  task mark_inactive: :environment do
    # Find people who are active but have not been synced in 'DAYS_INDICATING_INACTIVE' days
    people = Person.where('(synced_at < ?) or (synced_at is null)', (Time.now - DAYS_INDICATING_INACTIVE.days))
                   .where(active: true)

    people.each do |p|
      p.active = false
      p.save!
    end

    puts "Found and marked inactive #{people.length} people."
  end
end
