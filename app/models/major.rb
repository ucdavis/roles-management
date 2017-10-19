class Major < ApplicationRecord
  has_many :major_assignments
  has_many :people, through: :major_assignments, source: :entity

  # Needed by custom controller#majors, used in details modal
  def as_json(_)
    { id: id, name: name }
  end
end
