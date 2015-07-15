require 'rake'

namespace :user do
  require 'authentication'
  include Authentication

  desc 'Adds access token to user (basic RM usage).'
  task :grant_access, :arg1 do |t, args|
    Rake::Task['environment'].invoke
    include RmBuiltinRoles

    disable_authorization

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

    enable_authorization
  end

  desc 'Revokes access from user (separate from regular access).'
  task :revoke_access, :arg1 do |t, args|
    Rake::Task['environment'].invoke
    include RmBuiltinRoles

    disable_authorization

    args.each do |arg|
      p = Person.find_by_loginid(arg[1])
      if p
        puts "Revoking access from #{arg[1]}..."
        entity_id = p.id
        ra = RoleAssignment.find_by_role_id_and_entity_id(rm_access_role_id, entity_id)
        unless ra.nil?
          ret = ra.destroy
          if ret == false
            puts "Could not remove access from user. Reason(s): " + ra.errors.full_messages.join(", ")
            exit
          end
        else
          puts "#{arg[1]} is not set for access."
        end
      else
        puts "No such user '#{arg[1]}'"
      end
    end

    enable_authorization
  end

  desc 'Adds operate token to user (less powerful type of admin).'
  task :grant_operate, :arg1 do |t, args|
    Rake::Task['environment'].invoke
    include RmBuiltinRoles

    disable_authorization

    args.each do |arg|
      p = Person.find_by_loginid(arg[1])
      if p
        puts "Granting operate to #{arg[1]}..."
        ra = RoleAssignment.new
        ra.role_id = rm_operate_role_id
        ra.entity_id = p.id
        ra.save!
      else
        puts "No such user '#{arg[1]}'"
      end
    end

    enable_authorization
  end

  desc 'Revokes operate status from user (less poweful type of admin).'
  task :revoke_operate, :arg1 do |t, args|
    Rake::Task['environment'].invoke
    include RmBuiltinRoles

    disable_authorization

    args.each do |arg|
      p = Person.find_by_loginid(arg[1])
      if p
        puts "Revoking operate from #{arg[1]}..."
        entity_id = p.id
        ra = RoleAssignment.find_by_role_id_and_entity_id(rm_operate_role_id, entity_id)
        unless ra.nil?
          ret = ra.destroy
          if ret == false
            puts "Could not remove operate from user. Reason(s): " + ra.errors.full_messages.join(", ")
            exit
          end
        else
          puts "#{arg[1]} is not set for operate."
        end
      else
        puts "No such user '#{arg[1]}'"
      end
    end

    enable_authorization
  end

  desc 'Adds admin token to user (admin RM usage) and regular access if needed.'
  # Note: permissions for admins simply expand normal permissions, so an admin user
  #       must be granted both 'access' and 'admin', not simply 'admin'.
  task :grant_admin, :arg1 do |t, args|
    Rake::Task['environment'].invoke
    include RmBuiltinRoles

    disable_authorization

    args.each do |arg|
      p = Person.find_by_loginid(arg[1])

      if p
        if p.role_ids.include? rm_admin_role_id
          puts "#{arg[1]} already has admin access"
        else
          puts "Granting admin to #{arg[1]}..."
          ra = RoleAssignment.new
          ra.role_id = rm_admin_role_id
          ra.entity_id = p.id
          ra.save!

          # Ensure they have the 'access' role as well
          if p.roles.where(:application_id => ra.role.application_id).where(:token => "access").length == 0
            ra = RoleAssignment.new
            ra.role_id = rm_access_role_id
            ra.entity_id = p.id
            ra.save!
          end
        end
      else
        puts "No such user '#{arg[1]}'"
      end
    end

    enable_authorization
  end

  desc 'Revokes admin from user (will keep regular access).'
  task :revoke_admin, :arg1 do |t, args|
    Rake::Task['environment'].invoke
    include RmBuiltinRoles

    disable_authorization

    args.each do |arg|
      p = Person.find_by_loginid(arg[1])
      if p
        puts "Revoking admin from #{arg[1]}..."
        entity_id = p.id
        ra = RoleAssignment.find_by_role_id_and_entity_id(rm_admin_role_id, entity_id)
        unless ra.nil?
          ret = ra.destroy
          if ret == false
            puts "Could not remove admin access from user. Reason(s): " + ra.errors.full_messages.join(", ")
            exit
          end
        else
          puts "#{arg[1]} is not set as admin."
        end
      else
        puts "No such user '#{arg[1]}'"
      end
    end

    enable_authorization
  end
end
