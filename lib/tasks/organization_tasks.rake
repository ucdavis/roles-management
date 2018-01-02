require 'rake'

namespace :organization do
  require 'authentication'
  include Authentication

  desc 'Remove unused organizations'
  task remove_unused: :environment do
    # search_orgs flag tells us to re-do our org search should we delete an org.
    # Deleting an org changes whether or not children exist and may invalidate previous
    # results, forcing us to loop again and again until no orgs are found during the loop.
    search_orgs = true

    while search_orgs
      search_orgs = false
      Organization.all.each do |org|
        if org.child_org_ids.empty? && org.entities.empty? && org.managers.empty?
          puts "Removing unused organization (no children, no entities, no managers): #{org.name} ... "
          search_orgs = true
          org.destroy
        elsif GroupRule.where(column: 'organization', value: org.name).empty? && org.child_org_ids.empty?
          puts "Removing unused organization (no children, no rules): #{org.name} ... "
          search_orgs = true
          org.destroy
        end
      end
    end
  end
end
