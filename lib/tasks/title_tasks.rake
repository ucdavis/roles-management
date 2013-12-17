require 'rake'

namespace :title do
  desc 'Import title codes from CSV (override any conflicting codes).'
  task :import_csv, [:csv_file_path] => :environment do |t, args|
    
    if args[:csv_file_path].nil?
      puts "You must specify a path to the CSV file.\nEnsure the first column contains title codes and the second contains the corresponding names."
      exit
    end

    require 'csv'
    
    Authorization.ignore_access_control(true)
    
    titles_csv = CSV.read(args[:csv_file_path])
    titles_csv.each do |row|
      code = "%04d" % row[0] # pad leading zeroes to ensure codes are always 4 digits (by definition)
      name = row[1]
      
      t = Title.find_by_code(code)
      if t
        puts "Found a title with code #{code}. Name #{t.name} -> #{name}"
        t.name = name
        t.save!
      else
        puts "Did not find a title with code #{code}. Creating ..."
        t = Title.new
        t.code = code
        t.name = name
        t.save!
      end
    end
    
    Authorization.ignore_access_control(false)
  end
end
