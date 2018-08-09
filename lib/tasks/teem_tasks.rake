require 'rake'

$organization_id = 13856

def remove_teem_group_member(token, tm_diff_users, all_user_ids, group_id)
  tm_diff_users.each do |email|
    user_id = all_user_ids[email]

    user = Teem.teem_get_user(token, user_id)
    user_groups = user["group_ids"]
    user_groups.delete(group_id)

    Teem.teem_update_group_assign(token, user_groups, user_id)
  end
end

def add_rm_group_member(token, rm_diff_users, all_user_ids, group_id, role)
  rm_diff_users.each do |email|
    user_id = all_user_ids[email]

    if user_id
      Teem.teem_update_group_assign(token, group_id, user_id)
    else
      role.members().each do |member|
        if member["email"] == email
          first_name = member["first"]
          last_name = member["last"]

          Teem.teem_create_user(token, $organization_id, email, first_name, last_name)
        end
      end
      Teem.teem_update_group_assign(token, group_id, user_id)
    end
  end
end

namespace :teem do
  desc 'Sync RM users to Teem'
  task sync_users: :environment do
    require 'teem.rb'

    token = Teem.teem_authorize()
    teem_groups = Teem.teem_get_groups(token)
    all_user_ids = Teem.teem_user_ids(token)

    # Adding new groups to Teem from RM
    teem_application = Application.find_by(name: "Teem Calendars")
    if teem_application
      teem_application.roles.each do |role|
        unless teem_groups.find_index { |group| group["name"] == role.name}
          name = role.name
          description = role.description
          
          Teem.teem_create_group(token, $organization_id, name, description)
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

        Teem.teem_delete_group(token, group_id)
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
          remove_teem_group_member(token, tm_diff_users, all_user_ids, group["id"])

          rm_diff_users = rm_users - teem_users
          add_rm_group_member(token, rm_diff_users, all_user_ids, Array.new(1, group["id"]), role)
        end
      end
    end
  end
end
