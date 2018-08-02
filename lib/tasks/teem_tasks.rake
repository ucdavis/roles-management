require 'rake'

namespace :teem do
  desc 'Sync RM users to Teem'
  task sync_users: :environment do
    require 'teem.rb'

    token = Teem.teem_authorize()
    teem_groups = Teem.teem_get_groups(token)

    count = 1

    # Need to add members: Looping through rm people and comparing with all in Teem.
    Application.find_by(name: "Teem Calendars").roles.each do |role|
      unless teem_groups.find_index { |group| group["name"] == role.name}
        print "#{count}. "
        puts role.name

        #organization_id = 13856
        #name = "Young 102A"
        #description = "Can book Young 102A"
        #created_group = teem_create_group(access_token, organization_id, name, description)

        count += 1
      end
    end

    count = 1

    # Need to Delete members: Looping through Teem people and comparing with rm people.
    teem_groups.each do |group|
      roles = Application.find_by(name: "Teem Calendars").roles
      unless roles.find_index {|role| role.name == group["name"]}
        print "#{count}. "
        puts group["name"]

        #user_id = 2146837
        #teem_delete_user(access_token, user_id)

        count += 1
      end
    end

  end
end
