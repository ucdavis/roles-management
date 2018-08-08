require 'rake'

namespace :teem do
  desc 'Sync RM users to Teem'
  task sync_users: :environment do
    require 'teem.rb'

    organization_id = 13856

    token = Teem.teem_authorize()
    teem_groups = Teem.teem_get_groups(token)
    id_lookup = Teem.teem_id_lookup(token)

    # Adding new roles to Teem from RM
    teem_application = Application.find_by(name: "Teem Calendars")
    if teem_application
      teem_application.roles.each do |role|
        unless teem_groups.find_index { |group| group["name"] == role.name}
          name = role.name
          description = role.description

          teem_create_group(token, organization_id, name, description)
        end
      end
    else STDERR.puts "Cannot proceed, required application Teem Calendars not found."
      exit(-1)
    end

    # Deleting groups from Teem not found in RM
    teem_groups.each do |group|
      roles = teem_application.roles
      unless roles.find_index {|role| role.name == group["name"]}
        group_id = group["id"]

        teem_delete_group(token, group_id)
      end
    end

    # Evaluating group membership
    teem_groups.each do |group|
      roles = teem_application.roles

      roles.each do |role|
        if role.name == group["name"]
          rm_users = []
          teem_users = []

          role.members().each do |member|
            rm_users.push(member["email"])
          end

          user_ids = group["user_ids"]
          user_ids.each do |id|
            user = Teem.teem_get_user(token, id)
            email = user["email"]
            
            teem_users.push(email)
          end

          tm_diff_users = teem_users - rm_users
          tm_diff_users.each do |email|
            id = id_lookup[email]
            Teem.teem_delete_user(token, id)
          end

          rm_diff_users = rm_users - teem_users
          rm_diff_users.each do |email|
            user_id = id_lookup[email]
            group_id = group["id"]

            if user_id
              teem_update_group_assign(token, group_id, user_id)
            else
              role.members().each do |member|
                if member["email"] == email
                  first_name = member["first"]
                  last_name = member["last"]

                  teem_create_user(token, organization_id, email, first_name, last_name)
                end
              end
              teem_update_group_assign(token, group_ids, user_id)
            end
          end

        end
      end
    end

  end
end
