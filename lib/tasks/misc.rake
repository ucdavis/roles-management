namespace :misc do # rubocop:disable Metrics/BlockLength
  desc 'Convert old affiliation rules to IAM-based ones'
  task convert_affiliation_rules: :environment do
    # Convert 'faculty:senate' rules
    GroupRule.where(column: 'affiliation', condition: 'is', value: 'faculty:senate').each do |gr|
      # Convert to is_faculty and pps_unit is 'A3'
      group_id = gr.group_id

      gr.destroy

      GroupRule.create(column: 'is_faculty', condition: 'is', value: 't', group_id: group_id)
      GroupRule.create(column: 'pps_unit', condition: 'is', value: 'A3', group_id: group_id)
    end

    # Convert 'staff:career' rules
    GroupRule.where(column: 'affiliation', condition: 'is', value: 'staff:career').each do |gr|
      group_id = gr.group_id

      gr.destroy

      GroupRule.create(column: 'is_staff', condition: 'is', value: 't', group_id: group_id)
      GroupRule.create(column: 'pps_position_type', condition: 'is', value: 2, group_id: group_id)
      GroupRule.create(column: 'pps_position_type', condition: 'is', value: 7, group_id: group_id)
    end

    # Convert 'student:graduate' rules
    GroupRule.where(column: 'affiliation', condition: 'is', value: 'student:graduate').each do |gr|
      group_id = gr.group_id

      gr.destroy

      GroupRule.create(column: 'is_student', condition: 'is', value: 't', group_id: group_id)
      GroupRule.create(column: 'sis_level_code', condition: 'is', value: 'GR', group_id: group_id)
      GroupRule.create(column: 'sis_level_code', condition: 'is', value: 'LW', group_id: group_id)
      GroupRule.create(column: 'sis_level_code', condition: 'is', value: 'MD', group_id: group_id)
    end

    # Convert 'staff:student' rules
    GroupRule.where(column: 'affiliation', condition: 'is', value: 'staff:student').each do |gr|
      group_id = gr.group_id

      gr.destroy

      GroupRule.create(column: 'is_staff', condition: 'is', value: 't', group_id: group_id)
      GroupRule.create(column: 'pps_position_type', condition: 'is', value: 4, group_id: group_id)
    end

    GroupRule.where(column: 'affiliation', condition: 'is', value: 'staff:casual').each do |gr|
      group_id = gr.group_id

      gr.destroy

      GroupRule.create(column: 'is_staff', condition: 'is', value: 't', group_id: group_id)
      GroupRule.create(column: 'pps_position_type', condition: 'is', value: 3, group_id: group_id)
    end

    GroupRule.where(column: 'affiliation', condition: 'is', value: 'staff').each do |gr|
      group_id = gr.group_id

      gr.destroy

      GroupRule.create(column: 'is_staff', condition: 'is', value: 't', group_id: group_id)
    end

    GroupRule.where(column: 'affiliation', condition: 'is', value: 'staff:contract').each do |gr|
      group_id = gr.group_id

      gr.destroy

      GroupRule.create(column: 'is_staff', condition: 'is', value: 't', group_id: group_id)
      GroupRule.create(column: 'pps_position_type', condition: 'is', value: 1, group_id: group_id)
    end

    GroupRule.where(column: 'affiliation', condition: 'is', value: 'faculty:federation').each do |gr|
      group_id = gr.group_id

      gr.destroy

      GroupRule.create(column: 'is_faculty', condition: 'is', value: 't', group_id: group_id)
      GroupRule.create(column: 'pps_unit', condition: 'is', value: 'IX', group_id: group_id)
    end

    GroupRule.where(column: 'affiliation', condition: 'is', value: 'faculty').each do |gr|
      group_id = gr.group_id

      gr.destroy

      GroupRule.create(column: 'is_faculty', condition: 'is', value: 't', group_id: group_id)
    end

    GroupRule.where(column: 'affiliation', condition: 'is', value: 'student:undergraduate').each do |gr|
      group_id = gr.group_id

      gr.destroy

      GroupRule.create(column: 'is_student', condition: 'is', value: 't', group_id: group_id)
      GroupRule.create(column: 'sis_level_code', condition: 'is', value: 'UG', group_id: group_id)
    end
  end
end
