require 'rake'

namespace :title do
  require 'authentication'
  include Authentication

  desc 'Import title codes from CSV (override any conflicting codes).'
  task :import_csv, [:csv_file_path] => :environment do |t, args|

    if args[:csv_file_path].nil?
      puts "You must specify a path to the CSV file.\nEnsure the first column contains title codes and the second contains the corresponding names."
      exit
    end

    require 'csv'

    titles_csv = CSV.read(args[:csv_file_path])

    # Verify format of CSV file
    if titles_csv.length < 2
      puts "Expected at least a header row and a single row of data."
      exit(-1)
    end

    if titles_csv[0][0] != "Title"
      puts "Expected first column of header row to be 'Title' (representing the numeric code)."
      exit(-1)
    end

    if titles_csv[0][1] != "Title Description"
      puts "Expected second column of header row to be 'Title Description'."
      exit(-1)
    end

    # Remove the header row
    titles_csv.shift

    preimport_title_count = Title.count
    titles_created = 0
    titles_updated = 0
    titles_untouched = 0

    # Assume each remaining row is data
    titles_csv.each do |row|
      code = "%04d" % row[0] # pad leading zeroes to ensure codes are always 4 digits (by definition)
      name = row[1]

      t = Title.find_by_code(code)
      if t
        # Found a title with code. Check name.
        if t.name != name
          t.name = name
          t.save!
          titles_updated = titles_updated + 1
        else
          titles_untouched = titles_untouched + 1
        end
      else
        # Did not find a title with code. Create.
        t = Title.new
        t.code = code
        t.name = name
        t.save!
        titles_created = titles_created + 1
      end
    end

    puts "Parsed #{titles_csv.length} CSV rows."
    puts "Created #{titles_created} new titles."
    puts "Updated #{titles_updated} existing titles."
    puts "Left #{titles_untouched} existing titles alone (already up-to-date)."
  end
end
