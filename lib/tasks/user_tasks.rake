require 'rake'

namespace :user do
  desc 'Adds access token to user (basic RM usage).'
  task :grant_access, :arg1 do |t, args|
    Rake::Task['environment'].invoke
    include RmBuiltinRoles

    Authorization.ignore_access_control(true)

    args.each do |arg|
      p = Person.find_by_loginid(arg[1])
      if p
        puts "Granting access to #{arg[1]}..."
        ra = RoleAssignment.new
        ra.role_id = rm_access_role_id
        ra.entity_id = p.id
        ra.save!
      else
        puts "No such user '#{arg[1]}'"
      end
    end

    Authorization.ignore_access_control(false)
  end

  desc 'Revokes access from user (separate from regular access).'
  task :revoke_access, :arg1 do |t, args|
    Rake::Task['environment'].invoke
    include RmBuiltinRoles

    args.each do |arg|
      p = Person.find_by_loginid(arg[1])
      if p
        puts "Revoking access from #{arg[1]}..."
        entity_id = p.id
        ra = RoleAssignment.find_by_role_id_and_entity_id(rm_access_role_id, entity_id)
        unless ra.nil?
          ra.destroy
        else
          puts "#{arg[1]} is not set for access."
        end
      else
        puts "No such user '#{arg[1]}'"
      end
    end
  end

  desc 'Adds admin token to user (admin RM usage) and regular access if needed.'
  # Note: permissions for admins simply expand normal permissions, so an admin user
  #       must be granted both 'access' and 'admin', not simply 'admin'.
  task :grant_admin, :arg1 do |t, args|
    Rake::Task['environment'].invoke
    include RmBuiltinRoles

    Authorization.ignore_access_control(true)

    args.each do |arg|
      p = Person.find_by_loginid(arg[1])

      if p
        puts "Granting admin to #{arg[1]}..."
        ra = RoleAssignment.new
        ra.role_id = rm_admin_role_id
        ra.entity_id = p.id
        ra.save!

        # Ensure they have the 'access' role as well
        if p.roles.where(:application_id => ra.id).where(:token => "access").length == 0
          ra = RoleAssignment.new
          ra.role_id = rm_access_role_id
          ra.entity_id = p.id
          ra.save!
        end
      else
        puts "No such user '#{arg[1]}'"
      end
    end

    Authorization.ignore_access_control(false)
  end

  desc 'Revokes admin from user (will keep regular access).'
  task :revoke_admin, :arg1 do |t, args|
    Rake::Task['environment'].invoke
    include RmBuiltinRoles

    Authorization.ignore_access_control(true)

    args.each do |arg|
      p = Person.find_by_loginid(arg[1])
      if p
        puts "Revoking admin from #{arg[1]}..."
        entity_id = p.id
        ra = RoleAssignment.find_by_role_id_and_entity_id(rm_admin_role_id, entity_id)
        unless ra.nil?
          ra.destroy
        else
          puts "#{arg[1]} is not set as admin."
        end
      else
        puts "No such user '#{arg[1]}'"
      end
    end

    Authorization.ignore_access_control(false)
  end
end
