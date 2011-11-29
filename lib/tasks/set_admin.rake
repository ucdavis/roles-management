require 'rake'

namespace :admin do
  desc 'Sets a user as site admin.'
  task :set, :arg1 do |t, args|
    Rake::Task['environment'].invoke
    
    args.each do |arg|
      puts "Setting #{arg[1]} as admin..."
      Person.find_by_loginid(arg[1]).roles << Application.find_by_name("DSS Rights Management").roles[0]
    end
  end
end
