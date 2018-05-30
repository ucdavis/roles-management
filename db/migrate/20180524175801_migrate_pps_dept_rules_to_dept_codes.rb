class MigratePpsDeptRulesToDeptCodes < ActiveRecord::Migration[5.1]
  # Ensure we pick the most populous department if multiple departments
  # with the same officialName are found.
  def find_department(official_name)
    Department.where(officialName: official_name).max_by { |d| d.pps_associations.length }
  end

  def up
    GroupRule.where(column: 'department').each do |gr|
      department = find_department(gr.value)
      next unless department.present?
      gr.value = department.code
      gr.save!
    end

    GroupRule.where(column: 'admin_department').each do |gr|
      department = find_department(gr.value)
      next unless department.present?
      gr.value = department.code
      gr.save!
    end

    GroupRule.where(column: 'appt_department').each do |gr|
      department = find_department(gr.value)
      next unless department.present?
      gr.value = department.code
      gr.save!
    end
  end

  def down
    STDERR.puts 'Migration is destructive and therefore irreversible.'
  end
end
