require "rake"

namespace :clean do
  desc "Remove duplicate SIS associations"
  task :remove_duplicate_sis_assocs => :environment do |t, args|
    Person.all.each do |p|
      if p.sis_associations.length > 1
        existing_uniq_assocs = []
        dup_assocs = []

        p.sis_associations.each do |assoc|
          existing_idx = existing_uniq_assocs.index do |ex|
            ex.major_id == assoc.major_id &&
            ex.entity_id == assoc.entity_id &&
            ex.level_code == assoc.level_code &&
            ex.association_rank == assoc.association_rank
          end

          if existing_idx == nil
            existing_uniq_assocs << assoc
          else
            dup_assocs << assoc
          end
        end

        puts "#{p.loginid}: Found #{dup_assocs.length} dups out of a total #{p.sis_associations.length}"

        dup_assocs.each do |assoc|
          assoc.delete
        end
      end
    end
  end

  desc "Clean up manual entries of group members that also exists via rules"
  task dedupe_group_members: :environment do
    puts "Starting clean:dedupe_group_members"
    start_time = Time.now

    groups_modified = 0
    members_removed = 0

    Group.all.each do |g|
      manual_members = g.memberships
      rule_members = g.rule_members
      dupe_member = []

      rule_members.each do |rule_member|
        group_membership = manual_members.find { |m| m.entity_id == rule_member.id }

        if group_membership
          dupe_member.push(rule_member)

          puts "Deleting #{rule_member.name} from #{g.name}"
          group_membership.destroy!
        end
      end

      if dupe_member.size > 0
        groups_modified += 1
        members_removed += dupe_member.size
      end

      puts "#{g.name},#{dupe_member.map(&:name).join(",")}" unless dupe_member.empty?
    end

    stop_time = Time.now

    puts "Completed clean:dedupe_group_members in #{stop_time - start_time} seconds"
    puts "Removed #{members_removed} duplicate members from #{groups_modified} groups"
  end

  desc "Clean up manual role assignments that also exists via group"
  task dedupe_group_role_assignments: :environment do
    puts "Starting clean:dedupe_group_role_assignments"
    start_time = Time.now

    roles_modified = 0
    ra_removed = 0

    Role.all.each do |role|
      ra = role.role_assignments

      hash = Hash.new(0)
      ra.each { |ra| hash[ra.entity_id] += 1 }

      duplicate_assignments = []
      hash.each do |entity_id, size|
        if size > 1
          manual_ra = ra.find { |ra| ra.entity_id == entity_id && ra.parent_id == nil }

          if manual_ra
            duplicate_assignments.push(manual_ra.entity)

            puts "Deleting role assignment for #{manual_ra.entity.name} from #{role.application.name}:#{role.name}"
            manual_ra.destroy!
          end
        end
      end

      if duplicate_assignments.size > 0
        roles_modified += 1
        ra_removed += duplicate_assignments.size
      end

      puts "#{role.application.name}:#{role.name},#{duplicate_assignments.map(&:name).join(",")}" unless duplicate_assignments.empty?
    end

    stop_time = Time.now
    puts "Completed clean:dedupe_role_assignments in #{stop_time - start_time} seconds"
    puts "Removed #{ra_removed} role assignsments from #{roles_modified} roles"
  end

  desc "Find duplicate Role Assignments"
  task audit_duplicate_role_assignments: :environment do
    columns_that_make_record_distinct = [:role_id, :entity_id, :parent_id]
    distinct_records = RoleAssignment.select("MIN(id) as id").group(columns_that_make_record_distinct)
    duplicate_records = RoleAssignment.where.not(id: distinct_records)

    duplicate_records.each do |ra|
      puts "#{ra.id} (role_id: #{ra.role_id}, entity_id: #{ra.entity_id}) #{ra.role.application.name}:#{ra.role.name} / #{ra.entity.name}"
    end
  end
end
