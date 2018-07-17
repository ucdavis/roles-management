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

  desc 'Export models to CSV'
  task export_csv: :environment do
    require 'csv'

    models = %w[ApiKeyUser ApiWhitelistedIpUser ApplicationOperatorship ApplicationOwnership Application BusinessOfficeUnit Department GroupMembership GroupOperatorship GroupOwnership GroupRule Group Major PersonFavoriteAssignment Person PpsAssociation RoleAssignment Role SisAssociation Title]

    models.each do |model|
      attributes = model.constantize.column_names

      filename = Rails.root.join(model.downcase.pluralize + '.csv')

      puts "Exporting #{model} ..."
      CSV.open(filename, 'w') do |csv|
        csv << attributes

        model.constantize.order(:id).all.each do |p|
          csv << attributes.map { |attr| p.send(attr) }
        end
      end
    end

    # Special exports (produces redundant but filtered data)
    # Role Assignments (of people)
    attributes = RoleAssignment.column_names
    filename = Rails.root.join('role_assignments_people.csv')

    puts "Exporting #{filename} ..."
    CSV.open(filename, 'w') do |csv|
      csv << attributes

      RoleAssignment.joins(:entity).where(entities: {type: 'Person'}).order(:id).all.each do |p|
        csv << attributes.map { |attr| p.send(attr) }
      end
    end

    # Role Assignments (of groups)
    attributes = RoleAssignment.column_names
    filename = Rails.root.join('role_assignments_groups.csv')

    puts "Exporting #{filename} ..."
    CSV.open(filename, 'w') do |csv|
      csv << attributes

      RoleAssignment.joins(:entity).where(entities: {type: 'Group'}).order(:id).all.each do |p|
        csv << attributes.map { |attr| p.send(attr) }
      end
    end

    # Person favorites (of people)
    attributes = PersonFavoriteAssignment.column_names
    filename = Rails.root.join('person_favorite_people.csv')

    puts "Exporting #{filename} ..."
    CSV.open(filename, 'w') do |csv|
      csv << attributes

      PersonFavoriteAssignment.joins(:entity).where(entities: {type: 'Person'}).order(:id).all.each do |p|
        csv << attributes.map { |attr| p.send(attr) }
      end
    end

    # Person favorites (of groups)
    attributes = PersonFavoriteAssignment.column_names
    filename = Rails.root.join('person_favorite_groups.csv')

    puts "Exporting #{filename} ..."
    CSV.open(filename, 'w') do |csv|
      csv << attributes

      PersonFavoriteAssignment.joins(:entity).where(entities: {type: 'Group'}).order(:id).all.each do |p|
        csv << attributes.map { |attr| p.send(attr) }
      end
    end

    # Application ownerships (of people)
    attributes = ApplicationOwnership.column_names
    filename = Rails.root.join('application_ownerships_people.csv')

    puts "Exporting #{filename} ..."
    CSV.open(filename, 'w') do |csv|
      csv << attributes

      ApplicationOwnership.joins(:entity).where(entities: {type: 'Person'}).order(:id).all.each do |p|
        csv << attributes.map { |attr| p.send(attr) }
      end
    end

    # Application ownerships (of groups)
    attributes = ApplicationOwnership.column_names
    filename = Rails.root.join('application_ownerships_groups.csv')

    puts "Exporting #{filename} ..."
    CSV.open(filename, 'w') do |csv|
      csv << attributes

      ApplicationOwnership.joins(:entity).where(entities: {type: 'Group'}).order(:id).all.each do |p|
        csv << attributes.map { |attr| p.send(attr) }
      end
    end

    # Application operatorships (of people)
    attributes = ApplicationOperatorship.column_names
    filename = Rails.root.join('application_operatorships_people.csv')

    puts "Exporting #{filename} ..."
    CSV.open(filename, 'w') do |csv|
      csv << attributes

      ApplicationOperatorship.joins(:entity).where(entities: {type: 'Person'}).order(:id).all.each do |p|
        csv << attributes.map { |attr| p.send(attr) }
      end
    end

    # Application operatorships (of groups)
    attributes = ApplicationOperatorship.column_names
    filename = Rails.root.join('application_operatorships_groups.csv')

    puts "Exporting #{filename} ..."
    CSV.open(filename, 'w') do |csv|
      csv << attributes

      ApplicationOperatorship.joins(:entity).where(entities: {type: 'Group'}).order(:id).all.each do |p|
        csv << attributes.map { |attr| p.send(attr) }
      end
    end

    # Group rules (by is/is not, and type)
    # Application operatorships (of groups)
    attributes = GroupRule.column_names
    rule_types = %w[title major loginid department is_staff is_faculty is_student is_employee
                    is_external is_hs_employee sis_level_code pps_unit pps_position_type
                    business_office_unit admin_department appt_department]

    rule_types.each do |rule_type|
      filename = Rails.root.join("group_rules_is_#{rule_type}.csv")

      puts "Exporting #{filename} ..."
      CSV.open(filename, 'w') do |csv|
        csv << attributes

        GroupRule.where(condition: 'is', column: rule_type).order(:id).all.each do |p|
          csv << attributes.map { |attr| p.send(attr) }
        end
      end

      filename = Rails.root.join("group_rules_is_not_#{rule_type}.csv")

      puts "Exporting #{filename} ..."
      CSV.open(filename, 'w') do |csv|
        csv << attributes

        GroupRule.where(condition: 'is not', column: rule_type).order(:id).all.each do |p|
          csv << attributes.map { |attr| p.send(attr) }
        end
      end
    end
  end
end
