require 'rake'

namespace :rules do
  require 'authentication'
  include Authentication

  desc 'Generates a summary CSV about group rules.'
  task summary_csv: :environment do
    require 'csv'

    puts ["group_rule_id","group_id","group_name","column","condition","value","result_count"].to_csv
    GroupRule.all.each do |gr|
      puts [gr.id,gr.group_id,gr.group.name,gr.column,gr.condition,gr.value,gr.result_set.results.length].to_csv
    end
  end

  desc 'Diagnoses a person against a group\'s rules'
  task :diagnoses_rules, [:group_id, :loginid] => :environment do |t, args|
    old_logger = ActiveRecord::Base.logger
    ActiveRecord::Base.logger = nil

    g = Group.find_by(id: args[:group_id])
    unless g
      STDERR.puts "Could not find a group with ID #{args[:group_id]}"
      exit(-1)
    end

    p = Person.find_by(loginid: args[:loginid])
    unless p
      STDERR.puts "Could not find a person with login ID #{args[:loginid]}"
      exit(-1)
    end

    puts "Group (#{g.id},#{g.name}) has #{g.rules.length} rules"

    puts "According to the database, specified person (#{p.id},#{p.loginid}) " + (g.members.include?(p) ? 'is' : 'is not') + " in the group"

    matches_all_groups = true

    g.rules.group_by(&:column).each do |column, rules|
      puts "\tColumn: #{column} (#{rules.length} rules)"
      match_count = 0
      rules.each do |rule|
        matches = rule.matches?(p)
        match_count += matches ? 1 : 0
        puts "\t\tRule: #{rule.column} #{rule.condition} #{rule.value} ... " + (matches ? 'matches' : 'does not match')
      end
      puts "\tColumn is " + (match_count > 0 ? 'a match' : 'not a match') + " (matching #{match_count})"
      matches_all_groups &= (match_count > 0)
    end

    puts "According to check, specified person (#{p.id},#{p.loginid}) " + (matches_all_groups ? 'should be' : 'should not be') + " in the group"
    puts "NOTE: This test does not currently account for filter ('does not match') rules, which may change results."

    ActiveRecord::Base.logger = old_logger
  end

  desc 'Validate GroupRuleResultSets exist for every GroupRule.'
  task validate_group_rule_result_sets: :environment do
    invalid_count = 0

    GroupRule.all.each do |gr|
      # Ensure their properties match
      if gr.column != gr.result_set.column
        puts "GroupRule ID #{gr.id}: Mismatched column (#{gr.column}) against linked result set (#{gr.result_set.column})"
        # Unlink result set
        rs = gr.result_set
        rs.destroy_if_unused
        gr.result_set = nil
      end
      if gr.value != gr.result_set&.value
        puts "GroupRule ID #{gr.id}: Mismatched value (#{gr.value}) against linked result set (#{gr.result_set.value})"
        rs = gr.result_set
        rs.destroy_if_unused
        gr.result_set = nil
      end

      # Ensure result sets exist
      unless gr.result_set
        invalid_count += 1
        gr.save!
      end
    end

    puts "Corrected #{invalid_count} missing results out of #{GroupRule.count} total group rules"
  end

  desc 'Destroy unused GroupRuleResultSets.'
  task destroy_unused_group_rule_result_sets: :environment do
    unused_count = 0

    GroupRuleResultSet.all.each do |grrs|
      if grrs.rules.length == 0
        unused_count += 1
        grrs.destroy
      end
    end

    puts "Destroyed #{unused_count} unused GroupRuleResultSets"
  end

  # One-time task to clean up department IDs usage. DW returns three department IDs
  # (department_id, admin_department_id, appt_department_id) for each PPS association.
  # The three were found to always hold the same value after the switch to UCPath.
  # Collapsing rules onto department ahead of Rosetta migration.
  #
  # Dry run, rolls back, prints the audit:
  #   bundle exec rake rules:convert_appt_department_to_department
  # Commit, only if every group's member IDs match:
  #   WRITE=1 bundle exec rake rules:convert_appt_department_to_department
  desc 'Convert GroupRules using appt_department to department'
  task convert_appt_department_to_department: :environment do
    require 'csv'

    $stdout.sync = true

    start_time = Time.now
    write = ENV['WRITE'] == '1'
    csv_path = ENV.fetch('CSV_PATH', 'appt_department_conversion.csv')

    db = ActiveRecord::Base.connection_db_config.configuration_hash
    db_host = db[:host] || 'localhost'
    db_name = db[:database]
    local_db = %w[localhost 127.0.0.1 ::1].include?(db_host) || db_host.to_s.start_with?('/')

    puts "Environment: #{Rails.env} | Database: #{db_name} @ #{db_host}"
    puts "Mode: #{write ? 'WRITE' : 'DRY RUN (rolls back)'}"

    if write && (Rails.env.production? || !local_db) && ENV['CONFIRM_PRODUCTION'] != '1'
      abort "Refusing to write to #{db_name} @ #{db_host} without CONFIRM_PRODUCTION=1."
    end

    # Step 1: the conversion is only exact while appt_department equals department
    # on every association. A null appt_department would leave a person out of the
    # appt set but in the department set, so it counts as a difference too.
    differing = PpsAssociation.where('NOT (appt_department_id <=> department_id)').count
    abort "#{differing} pps_association(s) have appt_department different from department. Review before continuing." if differing.positive?
    puts "\nappt_department equals department on all #{PpsAssociation.count} associations."

    appt_rules = GroupRule.where(column: 'appt_department').order(:group_id, :id).to_a
    if appt_rules.empty?
      puts "\nNo appt_department rules found. Nothing to convert."
      next
    end

    rules_by_group = appt_rules.group_by(&:group_id)
    groups = Group.where(id: rules_by_group.keys).index_by(&:id)
    puts "Found #{appt_rules.count} appt_department rule(s) across #{rules_by_group.count} group(s)"

    # Membership read straight through the service, bypassing the Group#members cache.
    member_ids = lambda do |group|
      rule_ids = GroupsService.rule_member_ids(group).compact.uniq.sort
      explicit_ids = group.memberships.pluck(:entity_id).compact
      { rule: rule_ids, total: (rule_ids | explicit_ids).sort }
    end

    before = {}
    rows = []
    failures = []

    ActiveRecord::Base.transaction do
      # Step 2: preflight every group, then snapshot. No writes yet.
      rules_by_group.each do |group_id, rules|
        group = groups[group_id]

        # 'is' rules are OR'd within a column and AND'd across columns, so moving
        # appt_department 'is' rules into an existing department 'is' bucket can
        # widen the group unless both buckets hold the same values. 'is not' rules
        # are unioned across all columns, so they merge safely. Warn only: the
        # membership audit below decides, and a dry run shows exactly who moves.
        if rules.any? { |rule| rule.condition == 'is' } &&
           GroupRule.where(group_id: group_id, column: 'department', condition: 'is').exists?
          puts "WARNING: Group #{group_id} (#{group.name}) has department 'is' rules; converting merges AND'd buckets into one OR'd bucket"
        end

        before[group_id] = member_ids.call(group)
      end

      # Step 3: change each rule's column in place, keeping its ID. link_result_set
      # relinks it to the (department, value) set, creating and calculating one if
      # none exists. A rule the group already has as a department rule is removed
      # instead, so the group is not left with two identical rules.
      rules_by_group.each do |group_id, rules|
        group = groups[group_id]
        puts "\n----------------------------------------"
        puts "Group: #{group.name} (#{group_id})"

        roles = group.role_assignments.map { |ra| "#{ra.role.application.name}::#{ra.role.name}" }.uniq
        puts "Attached roles: #{roles.any? ? roles.join(', ') : 'none'}"

        converted_ids = []
        removed_ids = []
        rules.each do |rule|
          existing = GroupRule.find_by(group_id: group_id, column: 'department', condition: rule.condition, value: rule.value)
          if existing
            puts "  Rule #{rule.id}: appt_department #{rule.condition} #{rule.value} -> removed, already covered by rule #{existing.id}"
            rule.destroy
            removed_ids << rule.id
          else
            rule.update!(column: 'department')
            puts "  Rule #{rule.id}: appt_department #{rule.condition} #{rule.value} -> department (result set #{rule.group_rule_result_set_id})"
            converted_ids << rule.id
          end
        end

        rows << {
          group_id: group_id,
          group_name: group.name,
          roles: roles.join(' | '),
          converted_rule_ids: converted_ids.join(' '),
          removed_duplicate_rule_ids: removed_ids.join(' '),
          rules: rules.map { |rule| "#{rule.condition} #{rule.value}" }.join(' | ')
        }
      end

      # Relinking does not remove the old set: it still has this rule when the check
      # runs. Remove the appt_department sets, and their cached results, once unused.
      GroupRuleResultSet.where(column: 'appt_department').find_each(&:destroy_if_unused)

      # Step 4: audit after every write, since result sets are shared across groups.
      # Reload each group: the snapshot cached group.rules, which is now stale.
      rows.each do |row|
        after = member_ids.call(Group.find(row[:group_id]))
        snapshot = before[row[:group_id]]

        # Compare exact ID sets, rule-derived separately from total. An explicit
        # membership can mask a rule-derived change in the total set.
        row.merge!(
          before_rule_members: snapshot[:rule].count,
          after_rule_members: after[:rule].count,
          before_members: snapshot[:total].count,
          after_members: after[:total].count,
          rule_added_ids: (after[:rule] - snapshot[:rule]).join(' '),
          rule_removed_ids: (snapshot[:rule] - after[:rule]).join(' '),
          added_ids: (after[:total] - snapshot[:total]).join(' '),
          removed_ids: (snapshot[:total] - after[:total]).join(' ')
        )
        row[:status] = after == snapshot ? 'match' : 'MISMATCH'
        next if row[:status] == 'match'

        failures << "Group #{row[:group_id]} (#{row[:group_name]}): #{row[:before_members]} -> #{row[:after_members]} members; " \
                    "rule-derived added [#{row[:rule_added_ids]}] removed [#{row[:rule_removed_ids]}]; " \
                    "total added [#{row[:added_ids]}] removed [#{row[:removed_ids]}]"
      end

      remaining = GroupRule.where(column: 'appt_department').count
      failures << "#{remaining} appt_department rule(s) still remain after conversion" if remaining.positive?
      remaining_sets = GroupRuleResultSet.where(column: 'appt_department').count
      failures << "#{remaining_sets} appt_department result set(s) still remain after conversion" if remaining_sets.positive?

      # Step 4b: validate every department result set the conversion now relies on
      # against PPS associations. A reused set may be stale in a way that cancels
      # out in the membership audit above.
      used_values = appt_rules.map(&:value).uniq
      puts "\nResult set validation"
      GroupRuleResultSet.where(column: 'department', value: used_values).order(:value).each do |rs|
        cached = rs.results.where.not(entity_id: nil).pluck(:entity_id).uniq.sort
        department = Department.find_by(code: rs.value)
        expected = department ? PpsAssociation.where(department_id: department.id).distinct.pluck(:person_id).sort : []
        nulls = rs.results.where(entity_id: nil).count

        if cached == expected
          puts "  ok       set #{rs.id} department #{rs.value}: #{cached.size} member(s)#{nulls.positive? ? ", #{nulls} null row(s) ignored" : ''}"
        else
          puts "  MISMATCH set #{rs.id} department #{rs.value}: cached #{cached.size} vs expected #{expected.size}"
          failures << "Result set #{rs.id} (department #{rs.value}): cached #{cached.size} members but PPS associations give #{expected.size}; " \
                      "extra [#{(cached - expected).first(10).join(' ')}] missing [#{(expected - cached).first(10).join(' ')}]"
        end
      end

      # Record how the run ended; a rolled-back report is otherwise indistinguishable from a committed one.
      outcome = write && failures.empty? ? 'committed' : 'rolled_back'
      rows.each { |row| row.merge!(mode: write ? 'WRITE' : 'DRY_RUN', outcome: outcome) }

      CSV.open(csv_path, 'w') do |csv|
        csv << rows.first.keys
        rows.each { |row| csv << row.values }
      end

      puts "\n========================================"
      puts 'Member count audit'
      rows.each do |row|
        puts "  #{row[:status].ljust(8)} #{row[:group_name]} (#{row[:group_id]}): #{row[:before_members]} -> #{row[:after_members]} total, #{row[:before_rule_members]} -> #{row[:after_rule_members]} rule-derived"
      end
      puts "Wrote #{csv_path}"

      unless failures.empty?
        puts "\nRolling back. Problems found:\n  " + failures.join("\n  ")
        raise ActiveRecord::Rollback
      end

      unless write
        puts "\nDry run passed. Rolling back. Re-run with WRITE=1 to commit."
        raise ActiveRecord::Rollback
      end
    end

    committed = write && failures.empty?
    puts "\nCompleted in #{(Time.now - start_time).round(2)} seconds"
    converted = rows.sum { |row| row[:converted_rule_ids].split.size }
    puts "Groups processed: #{rows.count} | Rules converted: #{converted} | Duplicates removed: #{appt_rules.count - converted} | Committed: #{committed}"
    exit(1) unless failures.empty?
  end
end
