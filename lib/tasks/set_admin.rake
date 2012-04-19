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

  desc 'Unsets a user from site admin.'
  task :unset, :arg1 do |t, args|
    Rake::Task['environment'].invoke
    
    args.each do |arg|
      puts "Unsetting #{arg[1]} from admin..."
      person_id = Person.find_by_loginid(arg[1]).id
      role_id = Application.find_by_name("DSS Rights Management").roles.find(:first, :conditions => [ "lower(token) = 'admin'" ]).id
      ra = RoleAssignment.find_by_role_id_and_person_id(role_id, person_id)
      unless ra.nil?
        ra.destroy
      else
        puts "#{arg[1]} is not set as admin."
      end
    end
  end
end
