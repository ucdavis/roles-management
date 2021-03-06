class PpsAssociationsService
  # Adds a PPS association to a person, including all associated concerns (e.g. group rules, inherited roles, sync actions)
  def self.add_pps_association_to_person(person, title, department, admin_department, appt_department, association_rank, position_type_code, employee_class)
    raise 'Expected Person object' unless person.is_a?(Person)
    raise 'Expected Title object' unless title.is_a?(Title)
    raise 'Expected Department object' unless department.is_a?(Department)
    raise 'Expected Department object' unless admin_department.is_a?(Department)
    raise 'Expected Department object' unless appt_department.is_a?(Department)
    raise 'Expected Integer object' unless association_rank.is_a?(Integer)
    raise 'Expected Integer object' unless position_type_code.is_a?(Integer)
    raise 'Expected Integer object' unless employee_class.is_a?(Integer)

    PpsAssociation.create!(person_id: person.id,
                            title: title,
                            department: department,
                            admin_department: admin_department,
                            appt_department: appt_department,
                            association_rank: association_rank,
                            position_type_code: position_type_code,
                            employee_class: employee_class)

    person.reload

    ActivityLog.info!("Added title #{title.name} for department #{department.displayName}", ["person_#{person.id}"])

    GroupRulesService.update_results_for_columns([:pps_unit, :pps_position_type, :title, :business_office_unit, :admin_business_office_unit, :appt_business_office_unit, :department, :admin_department, :appt_department, :employee_class], person)
  end

  # Removes a PPS association from a person, including all associated concerns (e.g. group rules, inherited roles, sync actions)
  def self.remove_pps_association_from_person(person, pps_association)
    raise 'Expected Person object' unless person.is_a?(Person)
    raise 'Expected PpsAssociation object' unless pps_association.is_a?(PpsAssociation)

    old_title_name = pps_association.title&.name || 'unknown'
    old_department_display_name = pps_association.department.displayName
    pps_association.destroy!

    ActivityLog.info!("Removed title #{old_title_name} for department #{old_department_display_name}", ["person_#{person.id}"])

    person.reload
    GroupRulesService.update_results_for_columns([:pps_unit, :pps_position_type, :title, :business_office_unit, :admin_business_office_unit, :appt_business_office_unit, :department, :admin_department, :appt_department, :employee_class], person)
  end

  def self.remove_all_pps_associations_from_person(person)
    raise 'Expected Person object' unless person.is_a?(Person)

    person.pps_associations.each do |assoc|
      self.remove_pps_association_from_person(person, assoc)
    end
  end
end
