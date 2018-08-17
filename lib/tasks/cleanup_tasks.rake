require 'rake'

namespace :clean do
  desc 'Remove duplicate SIS associations'
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
end
