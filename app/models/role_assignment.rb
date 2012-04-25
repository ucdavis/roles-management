class RoleAssignment < ActiveRecord::Base
  belongs_to :role
  belongs_to :person
  belongs_to :group
  validates :role, :presence => true
  validate :has_person_or_group
  
  private
  
  def has_person_or_group
    if !person.nil? and !group.nil?
      # Cannot have both a person and a group
      return false
    end
    
    # Must have a person or a group
    !person.nil? || !group.nil?
  end
end
