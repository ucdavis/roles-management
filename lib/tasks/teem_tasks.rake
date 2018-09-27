require 'rake'

ORGANIZATION_ID = ENV['TEEM_ORGANIZATION_ID']

namespace :teem do
  desc 'Sync RM users to Teem'
  task sync_users: :environment do
    require 'teem.rb'

    token = Teem.authorize

    unless token
      STDERR.puts 'Unable to acquire token. Aborting!'
      exit(-1)
    end

    teem_groups = Teem.get_groups(token)
    teem_users = Teem.user_ids(token).map { |email, teem_id| OpenStruct.new(teem_id: teem_id, email: email.downcase) }

    # Adding new groups to Teem from RM
    teem_application = Application.find_by(name: 'Teem Calendars')
    if teem_application
      teem_application.roles.each do |role|
        unless teem_groups.find_index { |group| group['name'] == role.name }
          STDOUT.puts "Need to create Teem group '#{role.name}'"
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
      unless roles.find_index { |role| role.name == group['name'] }
        STDOUT.puts "Teem group (ID #{group['id']}, name #{group['name']}) no longer exists in RM. Removing from Teem ..."
        Teem.delete_group(token, group['id'])
        teem_groups.delete(group)
      end
    end

    # Update membership within each Teem group
    teem_groups.each do |group|
      STDOUT.puts "Syncing Teem group #{group['name']} (#{group['id']}) ..."

      role = teem_application.roles.find_by(name: group['name'])

      if role
        STDOUT.puts "\tFound matching RM role."
      else
        STDERR.puts "\tCould not find role #{group['name']} to match Teem group. Skipping ..."
        next
      end

      rm_users = role.members.map { |m| OpenStruct.new(rm_id: m.id, email: m.email.downcase) }
      puts "\tIn RM:"
      rm_users.each do |user|
        puts "\t\t#{user.email}"
      end
      teem_group_users = group['user_ids'].map { |teem_user_id| teem_users.find { |u| u.teem_id == teem_user_id } }
      puts "\tIn Teem:"
      teem_group_users.each do |user|
        puts "\t\t#{user.email}"
      end

      puts "\n\tUsers to remove from Teem group:"
      (teem_group_users.map(&:email) - rm_users.map(&:email)).each do |teem_user_to_remove|
        teem_id = teem_users.find { |u| u.email == teem_user_to_remove }.teem_id
        puts "\t\t#{teem_user_to_remove} (#{teem_id})"

        user = Teem.get_user(token, teem_id)
        user_groups = user['group_ids']
        user_groups.delete(group['id'])

        Teem.update_user_groups(token, user_groups, teem_id)
      end

      puts "\tUsers to add to Teem group from RM role:"
      (rm_users.map(&:email) - teem_group_users.map(&:email)).each do |rm_user_to_add|
        teem_user = teem_users.find { |u| u.email == rm_user_to_add }
        teem_id = teem_user&.teem_id
        puts "\t\t#{rm_user_to_add} (#{teem_id || 'No Teem ID yet'})"

        if teem_id
          user = Teem.get_user(token, teem_id)
          user_groups = user['group_ids']
          user_groups.push(group['id'])

          Teem.update_user_groups(token, user_groups, teem_id)
        else
          puts "\t\tCreating user in Teem ..."
          rm_user = Person.find_by(email: rm_user_to_add)
          if rm_user
            response = Teem.create_user(token, ORGANIZATION_ID, rm_user_to_add, rm_user.first, rm_user.last)
            if response
              teem_id = response['id']

              puts "\t\tCreated user with email #{rm_user_to_add} (Teem ID #{teem_id}). Adding to Teem group ..."

              user_groups = []
              user_groups.push(group['id'])

              Teem.update_user_groups(token, user_groups, teem_id)
            else
              STDERR.puts "Invalid response from Teem API while creating user #{rm_user_to_add}, skipping ..."
            end
          else
            STDERR.puts "Error: Need to add RM user to Teem but cannot find RM user with email #{rm_user_to_add}. Skipping ..."
            next
          end
        end
      end
    end
  end
end
