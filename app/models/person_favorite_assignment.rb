class PersonFavoriteAssignment < ActiveRecord::Base
  using_access_control

  validates_uniqueness_of :owner_id, :scope => [:entity_id, :owner_id]

  # favorite is the owner
  belongs_to :owner, :class_name => "Person", :foreign_key => "id", :touch => true
  # entity is the entity being favorited
  belongs_to :entity, :touch => true
end
