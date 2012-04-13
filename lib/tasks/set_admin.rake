require 'rake'

namespace :admin do
  desc 'Sets a user as site admin.'
  task :set, :arg1 do |t, args|
    Rake::Task['environment'].invoke
    
    args.each do |arg|
      puts "Setting #{arg[1]} as admin..."
      ra = RoleAssignment.new
      ra.role_id = Application.find_by_name("DSS Rights Management").roles.find(:first, :conditions => [ "lower(token) = 'admin'" ]).id
      ra.person_id = Person.find_by_loginid(arg[1]).id
      ra.save!
    end
  end
end
