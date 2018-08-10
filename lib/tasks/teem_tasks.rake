require 'rake'

ORGANIZATION_ID = 13856

namespace :teem do
  desc 'Sync RM users to Teem'
  task sync_users: :environment do
    require 'teem.rb'

    token = Teem.authorize
    teem_groups = Teem.get_groups(token)
    all_teem_user_ids = Teem.user_ids(token)

    # Adding new groups to Teem from RM
    teem_application = Application.find_by(name: "Teem Calendars")
    if teem_application
      teem_application.roles.each do |role|
        unless teem_groups.find_index { |group| group["name"] == role.name }
          Teem.create_group(token, ORGANIZATION_ID, role.name, role.description)
        end
      end
    else
      STDERR.puts "Cannot proceed, required application 'Teem Calendars' not found."
      exit(-1)
    end

    # Deleting groups from Teem not found in RM
    teem_groups.each do |group|
      roles = teem_application.roles
      unless roles.find_index { |role| role.name == group["name"] }
        STDOUT.puts "Teem group with ID #{group["id"]} no longer exists in RM. Removing from Teem..."
        Teem.delete_group(token, group["id"])
      end
    end

    # Evaluating groups for updating members
    teem_groups.each do |group|
      teem_application.roles.each do |role|
        if role.name == group["name"]
          rm_emails = []

          rm_emails = role.members.map(&:email)

          user_ids = group["user_ids"]
          user_ids.each do |id|
            user = Teem.get_user(token, id)

            if rm_emails.include?(user["email"])
              user_ids.delete(id)
              rm_emails.delete(user["email"])
            end
          end

          user_ids.each do |id|
            user = Teem.get_user(token, id)
            user_groups = user["group_ids"]
            user_groups.delete(group["id"])

            Teem.update_user_groups(token, user_groups, id)
          end

          rm_emails.each do |email|
            user_id = all_teem_user_ids[email]

            if user_id
              user = Teem.get_user(token, user_id)
              user_groups = user["group_ids"]
              user_groups.push(group["id"])

              Teem.update_user_groups(token, user_groups, user_id)
            else
              role.members.each do |member|
                if member["email"].downcase == email.downcase
                  Teem.create_user(token, ORGANIZATION_ID, email, member["first"], member["last"])
                end
              end
              Teem.update_user_groups(token, group_id, user_id)
            end
          end
        end
      end
    end
  end
end
