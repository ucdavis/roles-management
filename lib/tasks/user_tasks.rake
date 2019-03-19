require 'rake'

namespace :user do
  require 'authentication'
  include Authentication

  desc 'Adds access token to user (basic RM usage).'
  task :grant_access, :arg1 do |t, args|
    Rake::Task['environment'].invoke
    include RmBuiltinRoles

    args.each do |arg|
      p = Person.find_by_loginid(arg[1])
      if p
        if p.role_ids.include?(rm_access_role_id)
          puts "#{arg[1]} already has access"
          next
        else
          RoleAssignmentsService.assign_role_to_entity(p, Role.find_by(id: rm_access_role_id))
        end
      else
        puts "No such user '#{arg[1]}'"
        next
      end

      puts "Granted access to #{arg[1]}"
    end
  end

  desc 'Revokes access from user (separate from regular access).'
  task :revoke_access, :arg1 do |t, args|
    Rake::Task['environment'].invoke
    include RmBuiltinRoles

    args.each do |arg|
      p = Person.find_by_loginid(arg[1])
      if p
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
          next
        end

        puts "Revoked access from #{arg[1]}."
      else
        puts "No such user '#{arg[1]}'"
      end
    end
  end

  desc 'Adds operate token to user (less powerful type of admin).'
  task :grant_operate, :arg1 do |t, args|
    Rake::Task['environment'].invoke
    include RmBuiltinRoles

    args.each do |arg|
      p = Person.find_by_loginid(arg[1])
      if p
        if p.role_ids.include?(rm_operate_role_id)
          puts "#{arg[1]} already has operate"
          next
        else
          RoleAssignmentsService.assign_role_to_entity(p, Role.find_by(id: rm_operate_role_id))

          puts "Granted operate to #{arg[1]}"
          next
        end
      else
        puts "No such user '#{arg[1]}'"
        next
      end
    end
  end

  desc 'Revokes operate status from user (less poweful type of admin).'
  task :revoke_operate, :arg1 do |t, args|
    Rake::Task['environment'].invoke
    include RmBuiltinRoles

    args.each do |arg|
      p = Person.find_by_loginid(arg[1])
      if p
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
          next
        end

        puts "Revoked operate from #{arg[1]}"
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

    args.each do |arg|
      p = Person.find_by_loginid(arg[1])

      if p
        if p.role_ids.include? rm_admin_role_id
          puts "#{arg[1]} already has admin access"
        else
          puts "Granting admin to #{arg[1]}..."
          RoleAssignmentsService.assign_role_to_entity(p, Role.find_by(id: rm_admin_role_id))

          # Ensure they have the 'access' role as well
          if p.roles.where(application_id: ra.role.application_id).where(token: 'access').length == 0
            RoleAssignmentsService.assign_role_to_entity(p, Role.find_by(id: rm_access_role_id))
          end
        end
      else
        puts "No such user '#{arg[1]}'"
      end
    end
  end

  desc 'Revokes admin from user (will keep regular access).'
  task :revoke_admin, :arg1 do |t, args|
    Rake::Task['environment'].invoke
    include RmBuiltinRoles

    args.each do |arg|
      p = Person.find_by_loginid(arg[1])
      if p
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
          next
        end

        puts "Revoked admin from #{arg[1]}"
      else
        puts "No such user '#{arg[1]}'"
      end
    end
  end

  desc 'Audit user(s).'
  task :audit, :arg1 do |t, args|
    Rake::Task['environment'].invoke
    include RmBuiltinRoles

    args.each do |arg|
      p = Person.find_by_loginid(arg[1])
      if p
        puts "#{p.name} (#{p.roles.length} roles):"
        p.role_assignments.each do |ra|
          printf "\t%-32s / %-16s %s\n", ra.role.application.name, ra.role.token, ra.created_at.strftime("%b %d, %Y %H:%M")
        end
      else
        puts "No such user '#{arg[1]}'"
      end
    end
  end
end
