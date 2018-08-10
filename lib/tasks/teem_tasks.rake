require 'rake'

ORGANIZATION_ID = 13856

# Removes group members from Teem that are no longer in Roles Management.
#
# +token+ is a string containing the access token used to authorize against Teem API
# +teem_users_to_remove+ is an array of strings containing users in Teem that need to be removed
# +all_user_ids+ is an array of strings containing a mapping from user email to id in Teem
# +group_id+ is an integer containing the group id
def remove_teem_group_members(token, teem_users_to_remove, all_user_ids, group_id)
  teem_users_to_remove.each do |email|
    user_id = all_user_ids[email]

    user = Teem.teem_get_user(token, user_id)
    user_groups = user["group_ids"]
    user_groups.delete(group_id)
    
    Teem.teem_update_user_groups(token, user_groups, user_id)
  end
end

# Adds group members to Teem that are in Roles Management.
#
# +token+ is a string containing the access token used to authorize against Teem API
# +teem_users_to_add+ is an array containing users in Teem that need to be added
# +all_user_ids+ is an array of strings containing a mapping from user email to id in Teem
# +group_id+ is an integer containing the group id
# +role+ is a json object containing a roles information
def add_teem_group_members(token, teem_users_to_add, all_user_ids, group_id, role)
  teem_users_to_add.each do |email|
    user_id = all_user_ids[email]

    if user_id
      Teem.teem_update_user_groups(token, group_id, user_id)
    else
      role.members.each do |member|
        if member["email"].downcase == email.downcase
          first_name = member["first"]
          last_name = member["last"]

          Teem.teem_create_user(token, ORGANIZATION_ID, email, first_name, last_name)
        end
      end
      Teem.teem_update_user_groups(token, group_id, user_id)
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
        unless teem_groups.find_index { |group| group["name"] == role.name }
          name = role.name
          description = role.description

          Teem.teem_create_group(token, ORGANIZATION_ID, name, description)
        end
      end
    else
      STDERR.puts "Cannot proceed, required application Teem Calendars not found."
      exit(-1)
    end

    # Deleting groups from Teem not found in RM
    teem_groups.each do |group|
      roles = teem_application.roles
      unless roles.find_index { |role| role.name == group["name"] }
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

          rm_users = role.members.map(&:email)

          user_ids = group["user_ids"]
          user_ids.each do |id|
            user = Teem.teem_get_user(token, id)
            teem_users.push(user["email"])
          end

          teem_users_to_remove = teem_users - rm_users
          remove_teem_group_members(token, teem_users_to_remove, all_user_ids, group["id"])

          teem_users_to_add = rm_users - teem_users
          add_teem_group_members(token, teem_users_to_add, all_user_ids, Array.new(1, group["id"]), role)
        end
      end
    end
  end
end
