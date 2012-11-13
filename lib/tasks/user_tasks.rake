require 'rake'

namespace :user do
  desc 'Adds access token to user (basic RM usage).'
  task :grant_access, :arg1 do |t, args|
    Rake::Task['environment'].invoke

    Authorization.ignore_access_control(true)

    args.each do |arg|
      puts "Granting access to #{arg[1]}..."
      ra = RoleAssignment.new
      ra.role_id = Application.find_by_name("DSS Roles Management").roles.find(:first, :conditions => [ "lower(token) = 'access'" ]).id
      ra.entity_id = Person.find_by_loginid(arg[1]).id
      ra.save!
    end

    Authorization.ignore_access_control(false)
  end

  desc 'Adds admin token to user (admin RM usage).'
  task :set, :arg1 do |t, args|
    Rake::Task['environment'].invoke

    Authorization.ignore_access_control(true)

    args.each do |arg|
      puts "Granting admin to #{arg[1]}..."
      ra = RoleAssignment.new
      ra.role_id = Application.find_by_name("DSS Roles Management").roles.find(:first, :conditions => [ "lower(token) = 'admin'" ]).id
      ra.entity_id = Person.find_by_loginid(arg[1]).id
      ra.save!
    end

    Authorization.ignore_access_control(false)
  end

  desc 'Revokes admin from user (separate from regular access).'
  task :unset, :arg1 do |t, args|
    Rake::Task['environment'].invoke

    args.each do |arg|
      puts "Revoking admin from #{arg[1]}..."
      entity_id = Person.find_by_loginid(arg[1]).id
      role_id = Application.find_by_name("DSS Rights Management").roles.find(:first, :conditions => [ "lower(token) = 'admin'" ]).id
      ra = RoleAssignment.find_by_role_id_and_entity_id(role_id, entity_id)
      unless ra.nil?
        ra.destroy
      else
        puts "#{arg[1]} is not set as admin."
      end
    end
  end
end
