require 'rake'

namespace :group do
  require 'authentication'
  include Authentication

  desc 'Generates a summary CSV about groups.'
  task summary_csv: :environment do
    require 'csv'

    puts ["group_id","group_name","group_member_count"].to_csv
    Group.all.each do |g|
      puts [g.id,g.name,g.members.length].to_csv
    end
  end

  desc 'Recalculate all rule-based groups.'
  task :recalculate_all do
    Rake::Task['environment'].invoke

    total_count = GroupRuleResultSet.count

    GroupRuleResultSet.all.each_with_index do |grrs, i|
      puts "Recalculating for #{i} of #{total_count} ..."
      grrs.update_results
    end
  end

  desc 'Recalculate inherited application operatorships from groups.'
  task :recalculate_inherited_application_operatorships do
    Rake::Task['environment'].invoke

    # For every group ...
    Group.all.each do |g|
      # For that group's every application operatorship ...
      g.application_operatorships.all.each do |gao|
        # For each member of the group ...
        g.members.each do |m|
          # If they don't already have an _inherited_ application operatorship for this group, grant them one
          ao = ApplicationOperatorship.find_by_parent_id_and_entity_id_and_application_id(g.id, m.id, gao.application_id)
          if ao
            puts "Group member (#{m.id}, #{m.name}) of group (#{g.id}, #{g.name}) already had inherited application operatorship for application (#{gao.application_id}, #{gao.application.name})"
          else
            iao = ApplicationOperatorship.new
            iao.parent_id = g.id
            iao.entity_id = m.id
            iao.application_id = gao.application_id
            iao.save!
            puts "Inheriting new application operatorship for group member (#{m.id}, #{m.name}) of group (#{g.id}, #{g.name}) for application (#{gao.application_id}, #{gao.application.name})"
          end
        end
      end
    end
  end

  desc 'Recalculate inherited roles from groups for a given person.'
  task :recalculate_inherited_roles, [:loginid] => :environment do |t, args|
    unless args[:loginid]
      puts 'You must specify a login ID to recalculate.'
      exit
    end

    p = Person.find_by_loginid(args[:loginid])
    unless p
      puts "Could not find a person with login ID #{args[:loginid]}"
      exit
    end

    puts 'Pre-existing inherited role assignments:'

    preexisting_role_ids = []

    calculated_ras = []
    p.role_assignments.each do |ra|
      next if ra.parent_id.nil?

      puts "\tID: #{ra.id}, Role: #{ra.role.application.name} / #{ra.role.token}, via Group #{RoleAssignment.find_by_id(ra.parent_id).entity.name}"
      preexisting_role_ids << ra.role_id
      calculated_ras << ra
    end

    puts "\n#{p.loginid} has #{calculated_ras.length} inherited roles out of #{p.role_assignments.length} total roles."

    # First remove the calculated role assignments
    Thread.current[:role_assignment_destroying_calculated_flag] = true
    calculated_ras.each(&:destroy)
    Thread.current[:role_assignment_destroying_calculated_flag] = nil

    puts "All calculated role assignments destroyed.\n\n"

    recalculated_role_ids = []

    # Now re-create them based on each group's role assignment
    p.group_memberships.each do |gm|
      puts "Group (ID: #{gm.group_id} / #{gm.group.name}) has #{gm.group.roles.length} roles ..."
      gm.group.role_assignments.each do |group_ra|
        if RoleAssignment.find_by(entity_id: p.id, role_id: group_ra.role_id, parent_id: group_ra.id).nil?
          ra = RoleAssignment.new
          ra.entity_id = p.id
          ra.role_id = group_ra.role_id
          ra.parent_id = group_ra.id

          puts "\tGranting role (ID: #{group_ra.role_id} / #{group_ra.role.application.name}, #{group_ra.role.token}) with parent assignment #{group_ra.id} ..."

          ra.save!

          recalculated_role_ids << ra.role_id
        else
          puts "\tSkipping role grant as it already exists: role (ID: #{group_ra.role_id} / #{group_ra.role.application.name}, #{group_ra.role.token}) with parent assignment #{group_ra.id}. "
        end
      end
    end

    puts "\nPre-existing roles no longer assigned:"
    [preexisting_role_ids - recalculated_role_ids].flatten.each do |role_id|
      puts "\tRole ID: #{role_id}, #{Role.find_by_id(role_id).application.name} / #{Role.find_by_id(role_id).token}"
    end.empty? && begin
      puts "\tNone"
    end

    puts "\nRecalculated roles not previously assigned:"
    [recalculated_role_ids - preexisting_role_ids].flatten.each do |role_id|
      puts "\tRole ID: #{role_id}, #{Role.find_by_id(role_id).application.name} / #{Role.find_by_id(role_id).token}"
    end.empty? && begin
      puts "\tNone"
    end
  end

  desc '(Old) Audit inherited roles for data correctness.'
  task :old_audit_inherited_roles, [:loginid] => :environment do |_t, args|
    people = []
    bad_people_count = 0

    if args[:loginid]
      people << Person.find_by_loginid(args[:loginid])
    else
      people = Person.all
    end

    people.each do |p|
      calculated_ras = []
      bad_ras = []
      p.role_assignments.each do |ra|
        if ra.parent_id != nil
          calculated_ras << ra
          if RoleAssignment.find_by_id(ra.parent_id).nil?
            bad_ras << ra
            bad_people_count += 1
          end
        end
      end
    end

    puts "#{bad_people_count} / #{people.length} (#{bad_people_count / people.length}%) people have invalid inherited roles."
  end

  desc 'Audit inherited roles for data correctness.'
  task :audit_inherited_roles, [:loginid] => :environment do |_t, args|
    people = []

    total_ra_count = RoleAssignment.count
    total_incorrect = 0
    total_missing = 0

    if args[:loginid]
      people << Person.find_by_loginid(args[:loginid])
    else
      people = Person.all
    end

    total_people = people.count

    people.each_with_index do |p, i|
      # puts "Analyzing #{p.loginid} (#{i + 1} / #{total_people}) ..."

      # Ensure a person doesn't have inherited roles they shouldn't have ...
      p.role_assignments.each do |ra|
        next if ra.parent_id.nil?

        # Role is inherited
        parent_ra = RoleAssignment.find_by_id(ra.parent_id)

        if parent_ra.nil?
          puts "#{p.loginid}: Role assignment #{ra.id} is inherited from #{ra.parent_id} but parent doesn't exist. Skipping ..."
          next
        end

        # Role is inherited from a group ...
        group = parent_ra.entity
        unless group.members.map(&:loginid).include?(p.loginid)
          puts "#{p.loginid}: Group #{group.id} #{group.name} (excluded) ..."
          puts "#{p.loginid}: -- Has inherited role #{parent_ra.role_id} / #{parent_ra.role.application.name}, #{parent_ra.role.token} but should not ..."
          ra.destroy
          total_incorrect += 1
        end
      end

      person_role_ids = p.roles.map(&:id)

      # Ensure a person has the inherited roles they shouuld have ...
      p.groups.each do |group|
        group.role_assignments.each do |ra|
          unless person_role_ids.include?(ra.role_id)
            puts "#{p.loginid}: Group #{group.id} #{group.name} (included) ..."
            puts "#{p.loginid}: -- Should have inherited role #{ra.role_id} / #{ra.role.application.name}, #{ra.role.token} but has not yet ..."

            new_ra = RoleAssignment.new
            new_ra.role_id = ra.role_id
            new_ra.entity_id = p.id
            new_ra.parent_id = ra.id
            new_ra.save!

            total_missing += 1
          end
        end
      end
    end

    puts "Total role assignments (at start)  : #{total_ra_count}"
    puts "Total role assignments (at finish) : #{RoleAssignment.count}"
    puts "Total found incorrect              : #{total_incorrect}"
    puts "Total found missing                : #{total_missing}"
  end

  desc 'Imports a custom JSON file for Lynda integration'
  task import_lynda_json: :environment do
    depts_file = File.read('depts.json')
    @depts = JSON.parse(depts_file)
    @group_names = []

    def get_dept_abbrev_by_code(code)
      d = @depts.find { |d| d['deptCode'] == code }
      return nil if d.nil?
      return d['deptAbbrev']
    end

    # Generates group names like "Lynda #{org_name} #{get_dept_abbrev_by_code(code)}"
    # but also handles appending -1, -2, -3 as needed to prevent naming conflicts.
    def generate_group_name(org_name, dept)
      idx = 0
      group_name = "Lynda #{org_name} #{get_dept_abbrev_by_code(dept)}"
      loop do
        if @group_names.include?(group_name) == false
          @group_names << group_name
          return group_name
        else
          idx += 1
          group_name = "Lynda #{org_name} #{get_dept_abbrev_by_code(dept)}-#{idx}"
        end
      end
    end

    def pps_position_type_code(type_label)
      case type_label
      when 'Contract'
        return 1
      when 'Regular/Career'
        return 2
      when 'Limited, Formerly Casual'
        return 3
      when 'Casual/RESTRICTED-Students'
        return 4
      when 'Academic'
        return 5
      when 'Per Diem'
        return 6
      when 'Regular/Career Partial YEAR'
        return 7
      when 'Floater'
        return 8
      else
        raise "Unknown PPS position type code: #{type_code}"
      end
    end

    def ensure_department_is_tracked(dept_code)
      d = Department.find_by(code: dept_code)
      raise 'Expected department to exist' unless d
      tr = TrackedItem.find_by(kind: 'department', item_id: d.id)
      unless tr
        tr = TrackedItem.new
        tr.kind = 'department'
        tr.item_id = d.id
        tr.save!
        puts "NOW TRACKING DEPARTMENT #{dept_code}"
      end
    end

    rules_file = File.read('newrules.json')
    data = JSON.parse(rules_file)

    organizations = data['organizations']

    p_jeremy = Person.find_by(loginid: 'jeremy')
    raise 'Expected Jeremy to exist' unless p_jeremy

    organizations.each do |organization|
      # Parse name
      name = organization['name']
      raise 'Expected name' unless name.present?

      # Parse contacts
      raise 'Expected contacts.length == 1' unless organization['contacts'].length == 1
      contact_name = organization['contacts'][0]['name']
      contact_email = organization['contacts'][0]['email']
      contact_loginid = organization['contacts'][0]['loginid']
      raise 'Expected contact_name' unless contact_name.present?
      raise 'Expected contact_email' unless contact_email.present?
      raise 'Expected contact_loginid' unless contact_loginid.present?

      # Parse rules
      raise 'Expected contacts.rules' unless organization['rules'].length > 0
      organization['rules'].each do |rule|
        dept = nil

        deptCode = rule['deptCode']
        dept = deptCode if deptCode
        apptDeptCode = rule['apptDeptCode']
        raise 'Unexpected multiple depts' if apptDeptCode && dept
        dept = apptDeptCode if apptDeptCode
        adminDeptCode = rule['adminDeptCode']
        raise 'Unexpected multiple depts' if adminDeptCode && dept
        dept = adminDeptCode if adminDeptCode

        raise 'Expected dept' unless dept.present?

        group_name = generate_group_name(name, dept)

        # Ensure group exists
        g = Group.find_or_create_by(name: group_name)

        puts "Group: #{group_name}"
        puts "\tOwner: #{contact_name} #{contact_email} #{contact_loginid}"

        p = Person.find_by(loginid: contact_loginid)
        unless p
          imported_p = DssDw.create_or_update_using_dw(contact_loginid)
          raise "Could not find nor import person with login ID #{contact_loginid}" unless imported_p
          p = imported_p
        end

        # Ensure group has proper owners
        g.owners << p unless g.owners.include?(p)
        g.owners << p_jeremy unless g.owners.include?(p_jeremy)

        if rule['usernames'].present?
          # Create group with explicit group members dictated by 'usernames'
          usernames = rule['usernames']

          puts "\tExplicit members, no rules: #{usernames}"

          usernames.each do |username|
            m = Person.find_by(loginid: username)
            unless m
              imported_m = DssDw.create_or_update_using_dw(username)
              STDERR.puts "ERROR: Could not find nor import person with login ID #{username}" unless imported_m
              m = imported_m
            end

            if m
              g.memberships << GroupMembership.new(group_id: g.id, entity_id: m.id) unless g.members.include?(m)
            end
          end
        else
          titleCodes = rule['titleCodes']
          positionTypes = rule['positionTypes']

          raise 'Unknown rule type parsed' if deptCode.nil? && apptDeptCode.nil? && adminDeptCode.nil? && titleCodes.nil? && positionTypes.nil?

          if deptCode
            puts "\tRule: deptCode is #{deptCode}"
            ensure_department_is_tracked(deptCode)
            gr = GroupRule.new(column: 'department', condition: 'is', value: deptCode)
            g.rules << gr
          end
          if apptDeptCode
            puts "\tRule: apptDeptCode is #{apptDeptCode}"
            ensure_department_is_tracked(apptDeptCode)
            gr = GroupRule.new(column: 'appt_department', condition: 'is', value: apptDeptCode)
            g.rules << gr
          end
          if adminDeptCode
            puts "\tRule: adminDeptCode is #{adminDeptCode}"
            ensure_department_is_tracked(adminDeptCode)
            gr = GroupRule.new(column: 'admin_department', condition: 'is', value: adminDeptCode)
            g.rules << gr
          end
          if titleCodes
            titleCodes.each do |title_code|
              puts "\tRule: title_code is #{title_code}"
              t = Title.find_by(code: title_code)
              STDERR.puts "ERROR: Could not find title with code #{title_code}" unless t
              if t
                gr = GroupRule.new(column: 'title', condition: 'is', value: t.name)
                g.rules << gr
              end
            end
          end
          if positionTypes
            positionTypes.each do |position_type|
              puts "\tRule: position_type is #{position_type}"
              type_code = pps_position_type_code(position_type)
              gr = GroupRule.new(column: 'pps_position_type', condition: 'is', value: type_code)
              g.rules << gr
            end
          end
        end
      end
    end
  end
end
