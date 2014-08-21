require 'rake'

namespace :person do
  require 'authentication'
  include Authentication

  desc 'Searches for any invalid favorites (from code ran before 2014-08-21) and removes them.'
  task :remove_bad_favorites do
    Rake::Task['environment'].invoke

    disable_authorization

    count = 0

    PersonFavoriteAssignment.all.each do |pfa|
      if pfa.entity == nil
        puts "Found a bad favorite assignment: ID #{pfa.id} referencing entity ID #{pfa.entity_id} favorited by #{pfa.owner.name}. Removing ..."
        pfa.destroy
        count = count + 1
      end
    end

    puts "Found and removed #{count} bad favorites."

    enable_authorization
  end
end
