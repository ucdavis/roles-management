require 'rake'

namespace :organization do
  desc 'Imports organizations from a CSV file'
  task :import_csv, [:csv_file] => :environment do |t, args|
    Authorization.ignore_access_control(true)

    unless args[:csv_file]
      puts "You must specify a CSV file to import."
      exit
    end

    # Parse the given CSV file for organization information

    require 'csv'

    csv_text = File.read(args[:csv_file])
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      if row["HOME_DEPARTMENT_NUM"].nil?
        puts "Skipping a row with no department code:"
        pp row
        next
      end

      organization = Organization.new
      
      organization.org_id = row["CHART_NUM"] + row["ORG_ID"]
      organization.dept_code = row["HOME_DEPARTMENT_NUM"]
      organization.name = row["ORG_NAME"]
      organization.parent_org_id = row["RPTS_TO_ORG_CHART_NUM"] + row["RPTS_TO_ORG_ID"]
      
      if organization.save == false
        puts "Could not save organization:"
        pp row
        pp organization
        puts organization.errors.full_messages
        exit
      end
    end

    
    
    Authorization.ignore_access_control(false)
  end
  
  desc 'Drop all organizations'
  task :drop => :environment do
    Authorization.ignore_access_control(true)
    
    org_count = Organization.count
    
    Organization.destroy_all
    
    Authorization.ignore_access_control(false)
    
    puts "#{org_count} organization(s) dropped."
  end
end

