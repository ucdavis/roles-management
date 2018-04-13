namespace :db do
  desc 'Ensure all models are valid'
  task validate_models: :environment do
    # People
    puts "Validating people (#{Person.count}) ..."
    Person.all.each do |p|
      if p.valid? == false
        puts "\t##{p.id} invalid: #{p.errors.full_messages.join(",")}"
      end
    end

    # Groups
    puts "Validating groups (#{Group.count}) ..."
    Group.all.each do |g|
      if g.valid? == false
        puts "\t##{g.id} invalid: #{g.errors.full_messages.join(",")}"
      end
    end

    # Group rules
    puts "Validating group rules (#{GroupRule.count}) ..."
    GroupRule.all.each do |gr|
      if gr.valid? == false
        puts "\t##{gr.id} invalid: #{gr.errors.full_messages.join(",")}"
      end
    end

    # Roles
    puts "Validating roles (#{Role.count}) ..."
    Role.all.each do |r|
      if r.valid? == false
        puts "\t##{r.id} invalid: #{r.errors.full_messages.join(",")}"
      end
    end

    # Role assignments
    puts "Validating role assignments (#{RoleAssignment.count}) ..."
    RoleAssignment.all.each do |ra|
      if ra.valid? == false
        puts "\t##{ra.id} invalid: #{ra.errors.full_messages.join(",")}"
      end
    end

    # Organizations
    puts "Validating organizations (#{Organization.count}) ..."
    Organization.all.each do |o|
      if o.valid? == false
        puts "\t##{o.id} invalid: #{o.errors.full_messages.join(",")}"
      end
    end

    # Applications
    puts "Validating applications (#{Application.count}) ..."
    Application.all.each do |a|
      if a.valid? == false
        puts "\t##{a.id} invalid: #{a.errors.full_messages.join(",")}"
      end
    end

    # Group memberships
    puts "Validating group memberships (#{GroupMembership.count}) ..."
    GroupMembership.all.each do |gm|
      if gm.valid? == false
        puts "\t##{gm.id} invalid: #{gm.errors.full_messages.join(",")}"
      end
    end

    # Group ownerships
    puts "Validating group ownerships (#{GroupOwnership.count}) ..."
    GroupOwnership.all.each do |go|
      if go.valid? == false
        puts "\t##{go.id} invalid: #{go.errors.full_messages.join(",")}"
      end
    end

    # Group operatorships
    puts "Validating group operatorships (#{GroupOperatorship.count}) ..."
    GroupOperatorship.all.each do |go|
      if go.valid? == false
        puts "\t##{go.id} invalid: #{go.errors.full_messages.join(',')}"
      end
    end

    # Group rule result
    puts "Validating group rule (#{GroupRule.count}) ..."
    GroupRule.all.each do |gr|
      if gr.valid? == false
        puts "\t##{gr.id} invalid: #{gr.errors.full_messages.join(',')}"
      end
    end
  end

  desc 'Dump certain models to CSV'
  task dump_csv: :environment do
    require 'csv'

    # Dump people list
    filename = Rails.root.join('people.csv')

    attributes = %w[id loginid name]

    CSV.open(filename, 'w') do |csv|
      csv << attributes

      Person.order(:loginid).all.each do |p|
        csv << attributes.map { |attr| p.send(attr) }
      end
    end

    # Dump application list
    filename = Rails.root.join('applications.csv')

    attributes = %w[id name]

    CSV.open(filename, 'w') do |csv|
      csv << attributes

      Application.order(:id).all.each do |p|
        csv << attributes.map { |attr| p.send(attr) }
      end
    end

    # Dump group list
    filename = Rails.root.join('groups.csv')

    attributes = %w[id name]

    CSV.open(filename, 'w') do |csv|
      csv << [attributes, 'member_count'].flatten

      Group.order(:id).all.each do |p|
        csv << [attributes.map { |attr| p.send(attr) }, p.members.count].flatten
      end
    end

    # Dump roles list
    filename = Rails.root.join('roles.csv')

    CSV.open(filename, 'w') do |csv|
      csv << ['id', 'application_name', 'token', 'entity_count']

      Role.order(:application_id).order(:id).all.each do |p|
        csv << [p.id, p.application.name, p.token, p.entities.count]
      end
    end

    # Dump individual role membership lists
    Role.all.each do |r|
      filename = Rails.root.join("role_#{r.id}.csv")

      CSV.open(filename, 'w') do |csv|
        csv << ['entity_id', 'loginid']

        r.entities.order(:id).each do |e|
          csv << [e.id, e.loginid]
        end
      end
    end

    # Dump individual group membership lists
    Group.all.each do |g|
      filename = Rails.root.join("group_#{g.id}.csv")

      CSV.open(filename, 'w') do |csv|
        csv << ['entity_id', 'name']

        g.members.order(:loginid).each do |m|
          csv << [m.id, m.name]
        end
      end
    end

    # Dump individual people's roles
    Person.all.each do |p|
      filename = Rails.root.join("person_#{p.id}.csv")

      CSV.open(filename, 'w') do |csv|
        csv << ['role_id', 'role_token', 'application_name']

        p.roles.order(:id).each do |r|
          csv << [r.id, r.token, r.application.name]
        end
      end
    end
  end
end
