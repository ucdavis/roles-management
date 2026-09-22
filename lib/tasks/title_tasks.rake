require 'rake'

namespace :title do
  require 'authentication'
  include Authentication

  desc 'Compare titles against a UCPath job-code CSV; WRITE=1 applies the changes.'
  task :sync_titles_with_ucpath_csv, [:csv_file_path] => :environment do |_task, args|
    abort 'Usage: bin/rails title:sync_titles_with_ucpath_csv[path/to/ucpath_job_codes.csv]' if args[:csv_file_path].blank?

    require 'csv'

    write = ENV['WRITE'] == '1'

    csv = CSV.read(args[:csv_file_path], headers: true, encoding: 'bom|utf-8')
    required_headers = %w[CODE NAME UNIT]
    missing_headers = required_headers - csv.headers
    abort "Missing required CSV headers: #{missing_headers.join(', ')}" if missing_headers.any?

    puts "Target: #{ActiveRecord::Base.connection_db_config.configuration_hash[:database]}"
    puts "Mode:   #{write ? 'WRITE' : 'DRY RUN'}"

    source = {}
    conflicts = {}
    csv.each_with_index do |row, index|
      line = index + 2
      code = row['CODE'].to_s.strip
      attrs = { name: row['NAME'].to_s.strip, unit: row['UNIT'].to_s.strip.presence }

      if conflicts.key?(code)
        conflicts[code] << attrs.merge(csv_row: line)
      elsif source.key?(code) && source[code] != attrs
        conflicts[code] = [source.delete(code), attrs.merge(csv_row: line)]
      else
        source[code] = attrs
      end
    end

    missing_from_csv = []
    to_apply = []

    # Update only what we already have. Titles are created by the IAM import (lib/dss_dw.rb:250)
    # and nothing is deleted here -- pps_associations reference titles by id with no foreign key,
    # so destroying one silently orphans every association pointing at it.
    Title.find_each do |title|
      next if conflicts.key?(title.code)

      attrs = source[title.code]
      next missing_from_csv << title if attrs.nil?

      changes = {}
      changes['name'] = { 'from' => title.name, 'to' => attrs[:name] } if title.name != attrs[:name]
      changes['unit'] = { 'from' => title.unit, 'to' => attrs[:unit] } if title.unit != attrs[:unit]
      next if changes.empty?

      to_apply << [title, changes]
      message = "Title would change: #{{ title_id: title.id, code: title.code, changes: changes }.to_json}"
      puts message
      Rails.logger.info message
    end

    cleared = to_apply.select { |_, c| c['unit'] && c['unit']['to'].nil? }

    summary = {
      csv_rows: csv.length,
      titles_in_rm: Title.count,
      titles_to_change: to_apply.length,
      units_filled: to_apply.count { |_, c| c['unit'] && c['unit']['from'].nil? },
      units_changed: to_apply.count { |_, c| c['unit'] && c['unit']['from'] && c['unit']['to'] },
      units_cleared: cleared.length,
      names_changed: to_apply.count { |_, c| c['name'] },
      codes_skipped_conflicting: conflicts.length,
      rm_titles_not_in_csv: missing_from_csv.length,
      csv_codes_not_in_rm: (source.keys - Title.pluck(:code)).length
    }

    puts JSON.pretty_generate(summary)
    Rails.logger.info "UCPath title sync summary: #{summary.to_json}"

    conflicts.each do |code, rows|
      message = { code: code, rows: rows }.to_json
      puts "Skipped, CSV rows disagree: #{message}"
      Rails.logger.warn "UCPath title conflict: #{message}"
    end

    unless missing_from_csv.empty?
      puts 'In RM, absent from the CSV (left alone):'
      missing_from_csv.each { |t| puts "  #{t.code} #{t.name.inspect} (id #{t.id})" }
    end

    # Clearing a unit is the only change that can drop a title out of a pps_unit
    # rule, so call those out rather than leaving them in the pile.
    unless cleared.empty?
      puts "\nUnits being cleared -- these lose their pps_unit rule matches:"
      cleared.each { |t, c| puts "  #{t.code} #{t.name.inspect}: #{c['unit']['from'].inspect} -> null" }
    end

    unless write
      puts "\nDry run -- nothing changed. Re-run with WRITE=1 to apply."
      next
    end

    updated = 0
    failed = []
    ActiveRecord::Base.transaction do
      to_apply.each do |title, changes|
        title.name = changes['name']['to'] if changes['name']
        title.unit = changes['unit']['to'] if changes['unit']

        if title.save
          updated += 1
          Rails.logger.info "Title #{title.code} updated: #{changes.to_json}"
        else
          failed << "#{title.code}: #{title.errors.full_messages.join('; ')}"
        end
      end

      if failed.any?
        puts "\nFailures (#{failed.length}), rolling back:"
        failed.first(20).each { |f| puts "  #{f}" }
        raise ActiveRecord::Rollback
      end
    end

    if failed.any?
      puts "\nRolled back. No titles changed."
      exit 1
    end

    puts "\nUpdated #{updated} title(s)."
  end

  desc 'Import title codes from UC Path CSV (override any conflicting codes, remove codes not found in CSV).'
  task :import_titles_with_ucpath_csv, [:csv_file_path] => :environment do |t, args|
    if args[:csv_file_path].nil?
      STDERR.puts "You must specify a path to the CSV file.\nEnsure the first column contains title codes and the second contains the corresponding names."
      exit(-1)
    end

    require 'csv'

    titles_csv = CSV.read(args[:csv_file_path], "r:bom|utf-8")

    # Verify format of CSV file
    if titles_csv.length < 2
      STDERR.puts 'Expected at least a header row and a single row of data.'
      exit(-1)
    end

    # Check header expectations
    if titles_csv[0][0] != 'Job Code'
      puts "Expected first column of header row to be 'Job Code' (representing the numeric code) but was '#{titles_csv[0][0]}'."
      exit(-1)
    end
    if titles_csv[0][1] != 'Description'
      puts "Expected second column of header row to be 'Description'."
      exit(-1)
    end
    if titles_csv[0][2] != 'Short Description'
      puts "Expected third column of header row to be 'Short Description'."
      exit(-1)
    end
    if titles_csv[0][3] != 'Union Code'
      puts "Expected fourth column of header row to be 'Union Code'."
      exit(-1)
    end

    # Remove the header row
    titles_csv.shift

    titles_created = 0
    titles_updated = 0
    titles_untouched = 0

    existing_title_ids = Title.all.map(&:id)

    # Assume each remaining row is data
    titles_csv.each do |row|
      puts 'Parsing row ...'
      code = '%06d' % row[0].to_i # pad leading zeroes to ensure codes are always 6 digits (by definition)
      name = row[1]
      unit = row[3]
      puts "\tCode: #{code}"
      puts "\tName: #{name}"
      puts "\tUnit: #{unit}"

      # UC Path units include the variable character '%' which is set to 3 for UC Davis
      unit&.gsub!('%', '3')

      t = Title.find_by_code(code)
      if t
        t.name = name
        t.code = code
        t.unit = unit

        if t.valid? == false
          STDERR.puts "Could not save invalid title, skipping: '#{t.name}', '#{t.code}', '#{t.unit}'"
          next
        end

        if t.changed?
          t.save!
          titles_updated += 1
        else
          titles_untouched += 1
        end

        # Keep track of touched titles. We will remove untouched ones as
        # they no longer exist (according to this CSV).
        existing_title_ids.delete(t.id)
      else
        # Did not find a title with code. Create.
        t = Title.new
        t.code = code
        t.name = name
        t.unit = unit
        t.save!
        titles_created += 1
      end
    end

    existing_title_ids.each do |title_id|
      Title.find_by_id(title_id).destroy
    end

    puts "Parsed #{titles_csv.length} CSV rows."
    puts "Created #{titles_created} new titles."
    puts "Updated #{titles_updated} existing titles."
    puts "Left #{titles_untouched} existing titles alone (already up-to-date)."
    puts "Deleted #{existing_title_ids.length} old titles (not mentioned by CSV)."
  end

  desc 'DEPRECATED - Import title codes from CSV (override any conflicting codes, remove codes not found in CSV).'
  task :replace_titles_with_csv, [:csv_file_path] => :environment do |t, args|
    if args[:csv_file_path].nil?
      STDERR.puts "You must specify a path to the CSV file.\nEnsure the first column contains title codes and the second contains the corresponding names."
      exit(-1)
    end

    require 'csv'

    titles_csv = CSV.read(args[:csv_file_path])

    # Verify format of CSV file
    if titles_csv.length < 2
      STDERR.puts 'Expected at least a header row and a single row of data.'
      exit(-1)
    end

    # Check header expectations
    if titles_csv[0][0] != 'Title'
      puts "Expected first column of header row to be 'Title' (representing the numeric code) but was '#{titles_csv[0][0]}'."
      exit(-1)
    end
    if titles_csv[0][1] != 'Title Description'
      puts "Expected second column of header row to be 'Title Description'."
      exit(-1)
    end
    if titles_csv[0][2] != 'Pgm'
      puts "Expected third column of header row to be 'Pgm'."
      exit(-1)
    end
    if titles_csv[0][3] != 'Unit'
      puts "Expected fourth column of header row to be 'Unit'."
      exit(-1)
    end

    # Remove the header row
    titles_csv.shift

    titles_created = 0
    titles_updated = 0
    titles_untouched = 0

    existing_title_ids = Title.all.map(&:id)

    # Assume each remaining row is data
    titles_csv.each do |row|
      puts 'Parsing row ...'
      code = '%04d' % row[0].to_i # pad leading zeroes to ensure codes are always 4 digits (by definition)
      name = row[1]
      unit = row[3]
      puts "\tCode: #{code}"
      puts "\tName: #{name}"
      puts "\tUnit: #{unit}"

      t = Title.find_by_code(code)
      if t
        t.name = name
        t.code = code
        t.unit = unit

        if t.changed?
          t.save!
          titles_updated += 1
        else
          titles_untouched += 1
        end

        # Keep track of touched titles. We will remove untouched ones as
        # they no longer exist (according to this CSV).
        existing_title_ids.delete(t.id)
      else
        # Did not find a title with code. Create.
        t = Title.new
        t.code = code
        t.name = name
        t.unit = unit
        t.save!
        titles_created += 1
      end
    end

    existing_title_ids.each do |title_id|
      Title.find_by_id(title_id).destroy
    end

    puts "Parsed #{titles_csv.length} CSV rows."
    puts "Created #{titles_created} new titles."
    puts "Updated #{titles_updated} existing titles."
    puts "Left #{titles_untouched} existing titles alone (already up-to-date)."
    puts "Deleted #{existing_title_ids.length} old titles (not mentioned by CSV)."
  end

  desc 'Find missing PPSassociations Import title codes from CSV (override any conflicting codes, remove codes not found in CSV).'
  task :fill_missing_titles_via_http => :environment do |t, args|
    include ArmappsSalaryScales

    titles_to_create = []
    people_whose_titles_we_have = []
    titles_not_queryable = []
    people_issues = []

    total_records = Person.active.where('id NOT IN (select distinct(person_id) from pps_associations)').count

    Person.active.where('id NOT IN (select distinct(person_id) from pps_associations)').each_with_index do |p, i|
      puts "Parsing #{p.loginid} (#{i + 1} / #{total_records}) ..."
      dw_person = DssDw.fetch_person_by_loginid(p.loginid)

      next if dw_person.nil?

      dw_person['ppsAssociations'].uniq.each do |pps_assoc_json|
        next if pps_assoc_json.nil?

        dw_title_code = pps_assoc_json['titleCode']

        t = Title.find_by(code: dw_title_code)
        if t
          puts "\tWe have this title (code: #{dw_title_code}). Some other title creation error perhaps?"
          people_whose_titles_we_have << p.loginid
          people_issues << [p.loginid, 'RM has title. Unknown error.', dw_title_code, t.name]
        else
          puts "\tTitle not found locally (code: #{dw_title_code}), trying HTTP ..."

          begin
            ret = ArmappsSalaryScales.fetch_title_by_code(dw_title_code)
            puts "\tRet: #{ret}"
            titles_to_create << ret
            people_issues << [p.loginid, 'RM missing title. Available for import from armapps server.', dw_title_code, ret[:official_name]]
          rescue ArmAppsSalaryScalesCannotInterpretPageError
            puts "\tError while HTTP fetching title code. Either title does not exist or page layout / server has changed."
            titles_not_queryable << dw_title_code
            people_issues << [p.loginid, 'RM missing title. Error while querying armapps server.', dw_title_code, '']
          end
        end
      end
    end

    puts "\n\n"

    puts "People whose titles we have: #{people_whose_titles_we_have.length}"
    puts "loginid"
    people_whose_titles_we_have.uniq.each do |t|
      puts t
    end

    puts "Titles not queryable: #{titles_not_queryable.length}"
    puts "code"
    titles_not_queryable.uniq.each do |t|
      puts t
    end

    puts "Titles to create: #{titles_to_create.length}"
    puts "official_name,code,unit"
    titles_to_create.uniq.each do |t|
      puts "#{t[:official_name]},#{t[:code]},#{t[:unit]}"
    end

    puts "People issues: #{people_issues.length}"
    puts "loginid,issue,code,title name"
    people_issues.each do |t|
      puts "#{t[0]},#{t[1]},#{t[2]},#{t[3]}"
    end
  end

end
