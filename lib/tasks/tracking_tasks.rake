require 'rake'

namespace :tracking do
  desc 'Ensures tracking is set for all in-use PPS departments'
  task enable_used_departments: :environment do
    Department.where(id: PpsAssociation.all.map(&:department_id).uniq).each do |department|
      TrackedItem.find_or_create_by(kind: 'department', item_id: department.id)
    end
  end
end
