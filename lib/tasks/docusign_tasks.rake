require "rake"

namespace :docusign do
  require "docusign"
  require "dss_dw"

  desc "Pulls DocuSign groups into RM roles (overwrites existing RM members)"
  task import: :environment do
    Rails.logger.info "Running task docusign:import"
    job_start_ts = Time.now

    ds_application = Application.find_by(name: "DocuSign")

    unless ds_application
      ds_application = Application.create(name: "DocuSign", description: "A DocuSign group maps to an Application Role with the same name")
    end

    Docusign.configure
    # Pull in any missing groups
    ds_groups = Docusign.get_groups
    rm_roles = ds_application.roles

    ds_group_names = ds_groups.map(&:group_name)
    rm_role_names = rm_roles.map(&:name)

    group_names_to_add = ds_group_names - rm_role_names
    groups_to_add = ds_groups.select { |group| group_names_to_add.include? group.group_name }

    groups_to_add.each do |group|
      token = Docusign.tokenize(group.group_name)
      new_role = RolesService.create_role(ds_application.id, group.group_name, token, nil, nil)

      ds_group_users = Docusign.get_group_users(group)

      ds_group_users.each do |ds_user|
        # because some users use login@ucdavis.edu, also search by first and last
        name = ds_user.user_name.split
        p = Person.where(email: ds_user.email).or(Person.where(first: name[0], last: name[1])).first

        if p.nil?
          # check if user exists in IAM and import
          result = DssDw.search_people(ds_user.email)
          p = DssDw.create_or_update_using_dw(result[0]["userId"]) if result.size == 1
          STDOUT.puts "Imported user #{p.loginid} from DW" if p

          # user not in RM or IAM, give up
          if p.nil?
            puts "Could not find #{ds_user.email} (#{ds_user.user_name}) for #{new_role.name}. Skipping..."
            next
          end
        end

        # Don't use RoleAssignmentsService here, or trigger Sync system unnecessarily
        # RoleAssignmentsService.assign_role_to_entity(p, new_role)
        ra = RoleAssignment.new(role_id: new_role.id, entity_id: p.id)
        ra.save!
      end
    end

    # Delete roles that no longer exists
    role_names_to_remove = rm_role_names - ds_group_names
    deleted_roles = []

    role_names_to_remove.each do |role_name|
      rm_role = rm_roles.select { |r| r.name == role_name }
      RolesService.destroy_role(rm_role)
      deleted_roles.push(rm_role)
    end

    # Sync members of existing groups, skip the ones we just added
    groups_to_sync = ds_groups - groups_to_add

    groups_to_sync.each do |group|
      byebug
      ds_users = Docusign.get_group_users(group)
      rm_role = rm_roles.find { |role| role.name == group.group_name && role.token == Docusign.tokenize(group.group_name) }

      next if rm_role.nil?
      role_members = rm_role.members

      users_to_add = Docusign.diff_users(ds_users, role_members)

      users_to_add.each do |ds_user|
        name = ds_user.user_name.split
        p = Person.where(email: ds_user.email).or(Person.where(first: name[0], last: name[1])).first

        if p.nil?
          # check if user exists in IAM and import
          # this won't work if user has login@ucdavis.edu for email
          result = DssDw.search_people(ds_user.email)
          p = DssDw.create_or_update_using_dw(result[0]["userId"]) if result.size == 1
          STDOUT.puts "Imported user #{p.loginid} from DW" if p

          # user not in RM or IAM, give up
          if p.nil?
            puts "Could not find #{ds_user.email} (#{ds_user.user_name}) for #{new_role.name}. Skipping..."
            next
          end
        end

        # RoleAssignmentsService.assign_role_to_entity(p, rm_role) unless p.roles.include?(rm_role)
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

  # overwrites DocuSign group members
  desc "Pushes Role members to DocuSign groups"
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

    ds_groups = Docusign.get_groups
    rm_roles = ds_application.roles

    ds_group_names = ds_groups.map(&:group_name)
    rm_role_names = ds_application.roles.map(&:name)

    # ensure RM roles exists as DS groups
    group_names_to_add = rm_role_names - ds_group_names
    new_ds_groups = Docusign.create_groups(group_names_to_add) unless group_names_to_add.empty?

    # Update membership within each DocuSign group
    ds_groups += new_ds_groups.groups unless new_ds_groups.nil?

    rm_roles.each do |role|
      ds_group = ds_groups.find { |dsg| dsg.group_name == role.name }

      ds_group_users = Docusign.get_group_users(ds_group)
      role_members = role.members

      role_members_to_add = Docusign.diff_users(role_members, ds_group_users)
      ds_users_to_add = role_members_to_add.map do |role_member|
        Docusign.find_or_create_user({ name: "#{role_member.first} #{role_member.last}", email: role_member.email })
      end
      Docusign.add_users_to_group(ds_users_to_add, ds_group) if ds_users_to_add.size > 0

      ds_users_to_remove = Docusign.diff_users(ds_group_users, role_members)
      Docusign.remove_users_from_group(ds_users_to_remove, ds_group) if ds_users_to_remove.size > 0
    end

    Rails.logger.info "Finished task docusign:sync"
  end
end
