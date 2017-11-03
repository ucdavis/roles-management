class Major < ApplicationRecord
  has_many :sis_associations
  has_many :people, through: :sis_associations, source: :entity

  # Needed by custom controller#majors, used in details modal
  def as_json(_)
    { id: id, name: name }
  end
end
