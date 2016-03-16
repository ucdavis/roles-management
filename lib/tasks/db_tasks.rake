namespace :db do
  desc 'Ensure all models are valid'
  task :validate_models => :environment do
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
        puts "\t##{go.id} invalid: #{go.errors.full_messages.join(",")}"
      end
    end

    # Group rule result
    puts "Validating group rule (#{GroupRule.count}) ..."
    GroupRule.all.each do |gr|
      if gr.valid? == false
        puts "\t##{gr.id} invalid: #{gr.errors.full_messages.join(",")}"
      end
    end
  end
end
