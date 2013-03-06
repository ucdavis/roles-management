class PersonFavoriteAssignment < ActiveRecord::Base
  using_access_control

  validates_uniqueness_of :favorite_id, :scope => [:person_id, :favorite_id]
  #validate :cannot_favorite_self

  belongs_to :favorite, :class_name => "Person", :foreign_key => "person_id"
  belongs_to :person, :class_name => "Person"

  private

  # def cannot_favorite_self
  #   if person_id == favorite_id
  #     errors.add(:favorite_id, "Cannot favorite self")
  #   end
  # end
end
