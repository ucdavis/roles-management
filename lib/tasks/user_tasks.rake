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

  desc 'Revokes access from user (separate from regular access).'
  task :revoke_access, :arg1 do |t, args|
    Rake::Task['environment'].invoke

    args.each do |arg|
      puts "Revoking access from #{arg[1]}..."
      entity_id = Person.find_by_loginid(arg[1]).id
      role_id = Application.find_by_name("DSS Rights Management").roles.find(:first, :conditions => [ "lower(token) = 'access'" ]).id
      ra = RoleAssignment.find_by_role_id_and_entity_id(role_id, entity_id)
      unless ra.nil?
        ra.destroy
      else
        puts "#{arg[1]} is not set for access."
      end
    end
  end

  desc 'Adds admin token to user (admin RM usage) and regular access if needed.'
  # Note: permissions for admins simply expand normal permissions, so an admin user
  #       must be granted both 'access' and 'admin', not simply 'admin'.
  task :grant_admin, :arg1 do |t, args|
    Rake::Task['environment'].invoke

    Authorization.ignore_access_control(true)

    args.each do |arg|
      p = Person.find_by_loginid(arg[1])
      a = Application.find_by_name("DSS Roles Management")
      puts "Granting admin to #{arg[1]}..."
      ra = RoleAssignment.new
      ra.role_id = a.roles.find(:first, :conditions => [ "lower(token) = 'admin'" ]).id
      ra.entity_id = p.id
      ra.save!
      
      # Ensure they have the 'access' role as well
      if p.roles.where(:application_id => a.id).where(:token => "access").length == 0
        ra = RoleAssignment.new
        ra.role_id = a.roles.find(:first, :conditions => [ "lower(token) = 'access'" ]).id
        ra.entity_id = p.id
        ra.save!
      end
    end

    Authorization.ignore_access_control(false)
  end

  desc 'Revokes admin from user (will keep regular access).'
  task :revoke_admin, :arg1 do |t, args|
    Rake::Task['environment'].invoke

    Authorization.ignore_access_control(true)

    args.each do |arg|
      puts "Revoking admin from #{arg[1]}..."
      entity_id = Person.find_by_loginid(arg[1]).id
      role_id = Application.find_by_name("DSS Roles Management").roles.find(:first, :conditions => [ "lower(token) = 'admin'" ]).id
      ra = RoleAssignment.find_by_role_id_and_entity_id(role_id, entity_id)
      unless ra.nil?
        ra.destroy
      else
        puts "#{arg[1]} is not set as admin."
      end
    end
    
    Authorization.ignore_access_control(false)
  end
  
  # This task is designed to clean up bad syncs. We shouldn't be running it often.
  desc 'Set names for users without LDAP information.'
  task :set_name_without_ldap do |t, args|
    Rake::Task['environment'].invoke
    
    Authorization.ignore_access_control(true)
    
    puts "Setting names for #{Person.where(:name => nil).count} people ..."
    
    Person.where(:name => nil).each do |p|
      p.name = p.loginid
      p.save
    end
    
    puts "done."
    
    Authorization.ignore_access_control(false)
  end
end
