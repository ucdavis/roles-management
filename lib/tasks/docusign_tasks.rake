require "rake"

namespace :docusign do
  require "docusign"
  require "dss_dw"

  desc "Pulls DocuSign groups into RM roles (overwrites existing RM roles)"
  task import: :environment do
    Rails.logger.info "Running task docusign:import"
    job_start_ts = Time.now

    ds_application = Application.find_by(name: "DocuSign")

    unless ds_application
      ds_application = Application.create(name: "DocuSign", description: "A DocuSign group maps to an Application Role with the same name")
    end

    Docusign.configure
    ActiveDirectory.configure # DocuSign uses ADFS and DS_User::email maps to AD::UPN

    # Pull in any missing groups
    ds_groups = Docusign.get_groups
    rm_roles = ds_application.roles

    ds_group_names = ds_groups.map(&:group_name)
    rm_role_names = rm_roles.map(&:name)

    group_names_to_add = ds_group_names - rm_role_names
    ds_groups_to_add = ds_groups.select { |group| group_names_to_add.include? group.group_name }

    ds_groups_to_add.each do |ds_group|
      token = Docusign.tokenize(ds_group.group_name)
      new_role = RolesService.create_role(ds_application.id, ds_group.group_name, token, nil, nil)

      ds_group_users = Docusign.get_group_users(ds_group)
      ds_group_users.each do |ds_user|
        p = ActiveDirectory.create_or_update_person(ds_user.email)

        if p.nil?
          puts "Could not find #{ds_user.user_name} / #{ds_user.email}. Skipping"
          next
        end

        # Don't use RoleAssignmentsService here, it triggers the Sync subsystem
        ra = RoleAssignment.new(role_id: new_role.id, entity_id: p.id)
        ra.save!
      end
    end

    # Delete roles that no longer exists
    role_names_to_remove = rm_role_names - ds_group_names

    role_names_to_remove.each do |role_name|
      rm_role = rm_roles.find { |r| r.name == role_name }
      RolesService.destroy_role(rm_role)
    end

    # Sync members of existing groups, skip the ones we just added
    ds_groups_to_sync = ds_groups - ds_groups_to_add

    ds_groups_to_sync.each do |ds_group|
      ds_users = Docusign.get_group_users(ds_group)
      rm_role = rm_roles.find { |role| role.name == ds_group.group_name && role.token == Docusign.tokenize(ds_group.group_name) }

      next if rm_role.nil?
      role_members = rm_role.members

      users_to_add = Docusign.diff_users(ds_users, role_members)

      users_to_add.each do |ds_user|
        p = ActiveDirectory.create_or_update_person(ds_user.email)

        if p.nil?
          puts "Could not find #{ds_user.user_name} / #{ds_user.email} in ActiveDirectory. Skipping"
          next
        end

        unless p.roles.include?(rm_role)
          ra = RoleAssignment.new(role_id: rm_role.id, entity_id: p.id)
          ra.save!
        end
      end

      people_to_remove = Docusign.diff_users(role_members, ds_users)

      people_to_remove.each do |person|
        ra = RoleAssignment.find_by(entity_id: person.id, role_id: rm_role.id)
        ra.destroy!
      end
    end

    job_finish_ts = Time.now
    puts "docusign:import finished in #{job_finish_ts - job_start_ts} seconds"
    Rails.logger.info "Finished task docusign:import"
  end

  desc "Pushes Role members to DocuSign groups (overwrite existing DocuSign groups)"
  task sync: :environment do
    Rails.logger.info "Running task docusign:sync"

    ds_application = Application.find_by(name: "DocuSign")

    unless ds_application
      STDERR.puts "Required application 'DocuSign' not found."
      exit(-1)
    end

    if ds_application.roles.empty?
      STDOUT.puts "'DocuSign' application exists but has no roles."
      exit(0)
    end

    Docusign.configure
    ActiveDirectory.configure

    ds_groups = Docusign.get_groups
    rm_roles = ds_application.roles

    ds_group_names = ds_groups.map(&:group_name)
    rm_role_names = ds_application.roles.map(&:name)

    # ensure RM roles exists as DS groups
    group_names_to_add = rm_role_names - ds_group_names

    if group_names_to_add.length > 0
      new_ds_groups = Docusign.create_groups(group_names_to_add)
      ds_groups += new_ds_groups.groups
    end

    # remove DS groups that no longer exists as RM roles
    group_names_to_remove = ds_group_names - rm_role_names

    if group_names_to_remove.length > 0
      ds_groups_to_delete = group_names_to_remove.map { |group_name| ds_groups.find { |dsg| dsg.group_name == group_name } }
      
      # remove groups that were deleted
      response = Docusign.delete_groups(ds_groups_to_delete)
      group_ids = response.groups.map(&:group_id)
      ds_groups = ds_groups.select { |g| group_ids.exclude? g.group_id }
    end

    # Update membership within each DocuSign group
    rm_roles.each do |role|
      ds_group = ds_groups.find { |dsg| dsg.group_name == role.name }

      ds_group_users = Docusign.get_group_users(ds_group)
      role_members = role.members

      role_members_to_add = Docusign.diff_users(role_members, ds_group_users)
      ds_users_to_add = role_members_to_add.map do |role_member|
        ad_user = ActiveDirectory.create_or_update_person(role_member.email)
        user = Docusign.find_or_create_user({ name: "#{role_member.first} #{role_member.last}", email: ad_user.upn })
      end

      puts "adding to #{ds_group.group_name}, #{role_members_to_add.map(&:name).join(", ")}" if role_members_to_add.size > 0
      Docusign.add_users_to_group(ds_users_to_add, ds_group) if ds_users_to_add.size > 0

      ds_users_to_remove = Docusign.diff_users(ds_group_users, role_members)
      puts "removing from #{ds_group.group_name}, #{ds_users_to_remove.map{ |u| "#{u.user_name} (#{u.email})" }.join(", ")}" if ds_users_to_remove.size > 0

      Docusign.remove_users_from_group(ds_users_to_remove, ds_group) if ds_users_to_remove.size > 0
    end

    Rails.logger.info "Finished task docusign:sync"
  end
end
