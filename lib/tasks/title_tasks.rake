require 'rake'

namespace :title do
  require 'authentication'
  include Authentication

  desc 'Import title codes from CSV (override any conflicting codes, remove codes not found in CSV).'
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
end
