class PeopleService
  # If a person goes from inactive to active, we need to ensure
  # any role_assignment or group views are touched correctly.
  def self.set_active_status(person, is_active)
    raise 'Expected Person object' unless person.is_a?(Person)
    raise 'Expected true/false flag' if is_active == nil

    return if person.active == is_active # no change

    person.active = is_active
    person.save!

    person.role_assignments.each(&:touch)
    person.group_memberships.each(&:touch)

    # Activating/de-activating a person emulates them losing all their roles
    if person.active
      ActivityLog.info!('Marking as active', ["person_#{person.id}"])

      person.roles.each do |role|
        Sync.person_added_to_role(Sync.encode(person), Sync.encode(role))
      end

      Sync.person_added_to_system(Sync.encode(person))
    else
      ActivityLog.info!('Marking as inactive', ["person_#{person.id}"])

      person.roles.each do |role|
        Sync.person_removed_from_role(Sync.encode(person), Sync.encode(role))
      end

      Sync.person_removed_from_system(Sync.encode(person))
    end
  end
end
