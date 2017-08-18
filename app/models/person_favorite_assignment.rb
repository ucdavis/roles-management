# A favorite is a type of bookmark to a person or group. They appear in the right sidebar of the
# application.
# The LDAP import code automatically assigns as a favorite for an OU manager any individuals in that
# OU.
class PersonFavoriteAssignment < ApplicationRecord
  validates_uniqueness_of :owner_id, :scope => [:entity_id, :owner_id]
  validates_presence_of :owner
  validates_presence_of :entity

  # Owner is the person who holds this favorite
  belongs_to :owner, :class_name => "Person", :foreign_key => "owner_id", :touch => true
  # Entity is the group or person being favorited
  belongs_to :entity, :touch => true
end
