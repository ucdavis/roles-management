require 'rake'

namespace :bou do
  desc 'Migrate BOU-based rule key from names to codes (one-time task).'
  task migrate_names_to_codes: :environment do
    migrated_count = 0
    skipped_count = 0
    error_count = 0

    gr_query = GroupRule.where(column: ['business_office_unit', 'admin_business_office_unit', 'appt_business_office_unit'])

    gr_query.each do |gr|
      bou = BusinessOfficeUnit.find_by(dept_official_name: gr.value)

      unless bou
        puts "GroupRule ID #{gr.id}: Cannot find BOU matching #{gr.value}, skipping ..."
        skipped_count += 1
        next
      end

      unless gr.valid?
        puts "GroupRule ID #{gr.id}: Unable to update due to validation errors."
        error_count += 1
        next
      end

      gr.value = bou.org_oid
      gr.save!

      migrated_count += 1
    end

    puts "Complete. Total rules found: #{gr_query.count}. Migrated #{migrated_count}. Skipped #{skipped_count}. Errored on #{error_count}."
  end
end
