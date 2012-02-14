require 'rake'

namespace :ucd do
  desc 'Sets up classification data useful to UC Davis. To be run after ldap:import'
  task :setup_classifications => :environment do
    
    c = Classification.find_or_create_by_name("Senate Faculty")
    titles = ['1102','1308','1318','1423','1426','3258','3278','1000','1010','1100','1109','1110','1132','1143','1200','1243','1300','1310','1343','1603','1607','1621','1707','1721','1726','1208']
    titles.each do |t|
      ti = Title.find_by_code(t)
      if ti.nil?
        puts "Could not find title with code #{t}"
      else
        c.titles << ti
      end
    end
    
    c = Classification.find_or_create_by_name("Federation Faculty")
    titles = ['1550','1630','1631','1632','1653','1728','2100','3200','3210','3220','3252','3268','3269','3298','3320','3394','3612','3800','0841','0843']
    titles.each do |t|
      ti = Title.find_by_code(t)
      if ti.nil?
        puts "Could not find title with code #{t}"
      else
        c.titles << ti
      end
    end
    
    c = Classification.find_or_create_by_name("Academic Staff")
    titles = ['2500','3253','7703','9612','7685','1506','2310','2850','3282','3330','3570','2851','3266']
    titles.each do |t|
      ti = Title.find_by_code(t)
      if ti.nil?
        puts "Could not find title with code #{t}"
      else
        c.titles << ti
      end
    end
    
    c = Classification.find_or_create_by_name("Career Staff")
    titles = ['2600','3802','4805','0245','0384','4353','4354','4358','4722','4723','4725','7212','7234','7235','7236','7237','7238','7247','7281','7282','7285','7286','7287','7288','7294','0743','7510','7698','9610','9617','9632','9722']
    titles.each do |t|
      ti = Title.find_by_code(t)
      if ti.nil?
        puts "Could not find title with code #{t}"
      else
        c.titles << ti
      end
    end

    c = Classification.find_or_create_by_name("Student Staff")
    titles = ['4919','4920','4921']
    titles.each do |t|
      ti = Title.find_by_code(t)
      if ti.nil?
        puts "Could not find title with code #{t}"
      else
        c.titles << ti
      end
    end
    
  end
end
