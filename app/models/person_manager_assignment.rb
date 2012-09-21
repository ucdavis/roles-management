class PersonManagerAssignment < ActiveRecord::Base
  using_access_control

  validates_uniqueness_of :manager_id, :scope => [:person_id, :ou_id]
  validate :cannot_manage_self

  belongs_to :subordinate, :class_name => "Person", :foreign_key => "person_id"
  belongs_to :manager, :class_name => "Person"
  belongs_to :ou, :class_name => "Group"

  def cannot_manage_self
    if person_id == manager_id
      errors.add(:manager_id, "Cannot manage self")
    end
  end
end
