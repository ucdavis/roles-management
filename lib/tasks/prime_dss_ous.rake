require 'rake'

namespace :ucd do
  desc 'Sets up OUs data useful to the UCD DSS. To be run after ldap:import'
  task :setup_ous => :environment do
    
    ous = [{:code => "040325", :parent => "040390"}, {:code => "040027", :parent => "040390"}, {:code => "040280", :parent => "040114"}, {:code => "040110", :parent => "040111"},
      {:code => "040320", :parent => "040112"}, {:code => "040385", :parent => "040390"}, {:code => "040290", :parent => "040113"},
      {:code => "040360", :parent => "040114"}, {:code => "040256", :parent => "040390"}, {:code => "040076", :parent => "040114"}, {:code => "040250", :parent => "040390"},
      {:code => "040014", :parent => "040008"}, {:code => "040017", :parent => "040008"}, {:code => "040016", :parent => "040008"},
      {:code => "040115", :parent => "040114"}, {:code => "040009", :parent => "040390"}, {:code => "040020", :parent => "040112"},
      {:code => "040235", :parent => "040113"}, {:code => "040182", :parent => "040008"},
      {:code => "040181", :parent => "040111"}, {:code => "040180", :parent => "040111"}, {:code => "040230", :parent => "040111"}, {:code => "040150", :parent => "040390"},
      {:code => "040310", :parent => "040390"}, {:code => "040265", :parent => "040008"}, {:code => "040026", :parent => "040390"}, {:code => "040255", :parent => "040390"},
      {:code => "040210", :parent => "040390"}]
    
    ous.each do |o|
      ou = Ou.find_by_code(o[:code])
      parent = Ou.find_by_code(o[:parent])
      
      unless ou.nil?
        puts "Found OU with code #{o[:code]}"
        # Ensure 'ou' belongs to 'parent'
        unless ou.parents.include? parent
          puts "Adding parent with code #{o[:parent]}"
          ou.parents << parent
        else
          puts "Already has parent with code #{o[:parent]}"
        end
      else
        puts "Could not find OU with code #{o[:code]}"
      end
    end
    
  end
end
