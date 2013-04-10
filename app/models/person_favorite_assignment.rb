class PersonFavoriteAssignment < ActiveRecord::Base
  using_access_control

  validates_uniqueness_of :owner_id, :scope => [:person_id, :owner_id]

  # favorite is the owner
  belongs_to :owner, :class_name => "Person", :foreign_key => "id"
  # person is the person being favored
  belongs_to :person, :class_name => "Person"
end
